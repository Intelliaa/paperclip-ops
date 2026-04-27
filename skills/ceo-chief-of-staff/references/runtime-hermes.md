# Runtime Hermes — limitaciones y patrones shell-safe

Hermes corre un security scanner que bloquea comandos potencialmente peligrosos. Como el agente ejecuta headless en heartbeat, cualquier comando que pida aprobación interactiva deja el run colgado.

---

## Env vars que SÍ recibís en el runtime

| Var | Qué es |
|---|---|
| `PAPERCLIP_API_KEY` | Tu credencial bearer para todo request a la API |
| `PAPERCLIP_RUN_ID` | ID del heartbeat run actual (úsalo en el header `X-Paperclip-Run-Id` para mutations) |
| `PAPERCLIP_API_URL` | Base URL: `https://paperclip.codetrain.cloud` |

---

## Env vars que NO se inyectan (a pesar de lo que dice el skill `paperclip` base)

`PAPERCLIP_TASK_ID`, `PAPERCLIP_WAKE_REASON`, `PAPERCLIP_WAKE_COMMENT_ID`, `PAPERCLIP_WAKE_PAYLOAD_JSON`, `PAPERCLIP_APPROVAL_ID`, `PAPERCLIP_APPROVAL_STATUS`.

**No buscar estas en `env`.** Consultar `/api/heartbeat-runs/$PAPERCLIP_RUN_ID` y leer `.contextSnapshot.{wakeReason, issueId, commentId, approvalId, approvalStatus}` desde el JSON de respuesta.

---

## Reglas shell — obligatorias

### Regla 1 — Cero pipes a python3

```bash
# ❌ MAL — Hermes lo flaggea como DANGEROUS
curl -s "$URL" | python3 -c "import json,sys; print(json.load(sys.stdin)['id'])"

# ✅ BIEN
curl -s "$URL" > /tmp/r.json
jq -r '.id' /tmp/r.json
```

### Regla 2 — Pasos separados, no encadenes con pipes

```bash
# ❌ MAL — pipe entre dos procesos
curl -s "$URL" | jq -r '.tasks[0]' | head -1

# ✅ BIEN — archivos intermedios
curl -s "$URL" > /tmp/data.json
jq -r '.tasks[0]' /tmp/data.json > /tmp/task.json
head -1 /tmp/task.json
```

`jq` con expresión compleja en **un solo binario** NO se considera pipe peligroso. El problema es **conectar dos procesos con `|`**.

### Regla 3 — POST con body desde archivo, no heredoc inline

```bash
# ❌ MAL — strings con quotes/newlines pueden romper o disparar scanner
curl -X POST "$URL" -H "Content-Type: application/json" -d "{\"foo\":\"$VAR\"}"

# ✅ BIEN — armar JSON con jq, POST con @file
jq -n --arg foo "$VAR" '{foo: $foo}' > /tmp/payload.json
curl -X POST "$URL" \
  -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
  -H "X-Paperclip-Run-Id: $PAPERCLIP_RUN_ID" \
  -H "Content-Type: application/json" \
  -d @/tmp/payload.json
```

`jq -n --arg` escapa correctamente quotes, newlines, etc.

### Regla 4 — Cálculo numérico con `bc` o aritmética bash

```bash
RUNWAY=$(echo "scale=1; $CASH / $BURN" | bc)        # OK — bc es 1 proceso
TOTAL=$((INGRESOS - GASTOS))                         # OK — bash nativo
```

Nunca python3 para cálculos.

### Regla 5 — Limpiar /tmp al final del run

```bash
rm -f /tmp/run.json /tmp/inbox.json /tmp/comment.json /tmp/payload.json /tmp/r.json
```

### Regla 6 — Headers obligatorios para mutaciones Paperclip API

Toda llamada POST/PATCH/DELETE/PUT a `paperclip.codetrain.cloud/api/*` requiere:
- `Authorization: Bearer $PAPERCLIP_API_KEY`
- `X-Paperclip-Run-Id: $PAPERCLIP_RUN_ID` (link al run actual para auditoría)
- `Content-Type: application/json` (si lleva body)

GETs solo necesitan Authorization.

### Regla 7 — Nombres explícitos para archivos temp

`/tmp/<descripcion>.json` (no `/tmp/$RANDOM`). Facilita debug si algo falla mid-run.
