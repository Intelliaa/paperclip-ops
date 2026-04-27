# Digest formato — payload webhook ceo-notify

---

## Schema completo

```json
{
  "issueId": "<uuid de la issue Paperclip>",
  "issueTitle": "<título corto>",
  "urgency": "low|medium|high|urgent",
  "channel": "slack-only|email-only|both",
  "slackChannel": "#paperclip-ceo",
  "audience": ["raul"] | ["raul", "dey"] | ["dey"],
  "summary": "<digest legible markdown — formato abajo>",
  "fromAgentName": "CEO",
  "fromAgentRole": "ceo",
  "actionRequested": "approve|reject|review|input|info",
  "deadline": "<ISO timestamp opcional>",
  "alternativesProposed": "<texto opcional>",
  "linkToIssue": "https://paperclip.codetrain.cloud/issues/<issueId>"
}
```

**CRÍTICO — `fromAgentRole`:** identifica al agente que **envía** el webhook, no al rol que originalmente pidió la decisión. Para vos como CEO, el valor es **siempre** `"ceo"` y `fromAgentName` es **siempre** `"CEO"`. Quién pidió la decisión originalmente (CMO/CTO/CFO) va dentro del campo `summary` (formato: "Quien lo pide: CMO ..."), no en el routing.

n8n usa `fromAgentRole` para decidir el canal Slack y el remitente del email. Si pones `cmo` o `cto`, el switch en n8n no matchea y el digest se pierde.

---

## URL del webhook

```
POST https://n8n-dev1.codetrain.cloud/webhook/ceo-notify
```

Sin auth (URL secreta). HTTPS + obscure path. **No usar `Authorization` header** (n8n no lo espera).

---

## Generación del payload con `jq -n --arg`

```bash
SUMMARY="<digest markdown — escribirlo previamente a /tmp/summary.md y leerlo con --rawfile>"

jq -n \
  --arg issueId "$ISSUE_ID" \
  --arg title "Aprobar gasto $200 publicidad LinkedIn" \
  --arg urgency "medium" \
  --rawfile summary /tmp/summary.md \
  '{
    issueId: $issueId,
    issueTitle: $title,
    urgency: $urgency,
    channel: "both",
    slackChannel: "#paperclip-ceo",
    audience: ["raul"],
    summary: $summary,
    fromAgentName: "CEO",
    fromAgentRole: "ceo",
    actionRequested: "approve",
    linkToIssue: "https://paperclip.codetrain.cloud/issues/\($issueId)"
  }' > /tmp/payload.json

curl -X POST "https://n8n-dev1.codetrain.cloud/webhook/ceo-notify" \
  -H "Content-Type: application/json" \
  -d @/tmp/payload.json
```

n8n hace fan-out a Slack + email según `channel` y `audience`, guarda `thread_ts` (id del hilo Slack) en su DataTable mapeado a `issueId`, y queda en standby para procesar la respuesta humana.

---

## Formato del campo `summary` — sin jerga

Slack acepta `*texto*` para bold (no markdown estándar `**`). Si es `email-only`, podés usar `**`.

### Ejemplo 1 — Aprobación de gasto

```markdown
🚨 *Aprobación requerida* — INT-42

*Quién lo pide:* CMO
*Qué pide:* Aprobar gasto de $200 en publicidad pagada en LinkedIn (anuncios pagados), para una campaña entre abril y junio
*Por qué:* En abril, el porcentaje de personas que hacen clic en nuestras publicaciones gratuitas en LinkedIn bajó 30% comparado con marzo. La hipótesis es que los anuncios pagados pueden recuperar la atención que perdimos
*Riesgo si no decidís hoy:* Estimamos que en mayo recibiremos aproximadamente 15 personas interesadas menos de lo proyectado (gente que pide info pero todavía no compra)
*Alternativa que propongo:* Empezar con $100 (no $200) durante 2 semanas. Comparar resultados con un grupo donde no gastemos. Si los $100 traen más personas interesadas que el grupo sin gasto, escalamos a $200. Si no, paramos y revisamos

Respondé en este thread "sí / no / [tu propuesta]" o por email.
```

### Ejemplo 2 — Hire (nuevo agente)

```markdown
👤 *Aprobación requerida — contratar nuevo agente* — INT-58

*Quién lo pide:* CMO
*Qué propone:* Crear un nuevo agente "Brand Building Specialist" para construir credibilidad pública de Inteliside en LinkedIn
*Por qué:* La estrategia 2026 dice que necesitamos credibilidad antes de pedir leads. Hoy nadie en el equipo dedica tiempo a posts editoriales
*Costo:* $5/mes en API (modelo glm-5 via OpenCode Zen). Sin costo humano — es un agente IA dentro de Paperclip
*Tiempo de impacto:* 30-45 días para ver tracción en interacciones
*Alternativa que propongo:* Aprobar con review a los 30 días. Si genera < 10 posts publicados o engagement < 100 likes/30d, lo despedimos.

Respondé "sí / no / [tu propuesta]" o por email.
```

### Ejemplo 3 — Conflicto entre C-Level

```markdown
⚠️ *Conflicto de visiones* — INT-71

*Tema:* Presupuesto ads Mayo 2026
*CMO propone:* Subir gasto ads de $200 a $500/mes — argumenta que el aumento de leads paga el extra
*CFO propone:* Bajar gasto ads a $100 — argumenta que estamos en runway 7 meses y no es momento de aumentar gasto fijo
*Diferencia subyacente:* No coinciden en si la conversión de los leads a ventas reales valida el costo. CMO usa data de los últimos 30 días (alta tasa de conversión). CFO usa promedio 90 días (más bajo).
*Mi visión:* Necesito tu input. Yo me inclino a probar el incremento por 30 días con la data del CMO + el techo del CFO ($300 no $500). Si conversión sigue alta a los 30 días, escalamos. Si baja, volvemos a $200.

Respondé en thread o por email.
```

### Ejemplo 4 — Cliente urgente

```markdown
🚨 *Cliente urgente — Transaher* — INT-83

*Reporta:* Javier Romero (intermediario)
*Qué pasó:* Workflow n8n de procesamiento de emails llevó 2 horas caído. Cliente final detectó pérdida de pedidos.
*Estado actual:* Workflow restaurado a las 14:30. 8 emails perdidos en el período están siendo reprocesados manualmente.
*Riesgo:* Transaher representa ~40% del revenue. Si percibe inestabilidad puede pedir contrato de SLA o buscar alternativa.
*Acción que propongo:* Llamar a Javier hoy mismo. Reconocer el incidente, ofrecer post-mortem por escrito en 48h, no defender. Yo tengo el log técnico listo para vos.

Respondé en thread cuando puedas hablar con Javier.
```

### Ejemplo 5 — Digest semanal (timer wake)

```markdown
📊 *Resumen semanal* — semana del 22 al 28 abril

*Pipeline activo:*
- 3 propuestas en revisión por clientes potenciales (montos: $12K, $5K, $8K)
- 1 cliente nuevo cerrado esta semana (Conecta Suite Fase 2, $2,800)

*Decisiones tomadas sin escalar (gastos < $50):*
- Renovación dominio inteliside.com — $14
- Upgrade plan Notion — $24/mes

*Cosas que necesitan tu atención esta semana:*
- INT-58 hire Brand Building Specialist (esperando tu respuesta hace 3 días)
- INT-71 ads budget Mayo (esperando tu respuesta hace 1 día)

*Estado clientes activos:*
- Transaher: estable, 0 incidencias
- Conecta Suite: Fase 2 en pago programado para viernes
- Sabiia: separado de Inteliside (proyecto personal de Raul)
```

---

## Reglas en cada digest

- "Aprobación" no "approval"
- "Personas interesadas" / "gente que pide info" no "leads"
- "Comparar contra un grupo sin gasto" no "A/B test"
- "Anuncios pagados" no "ads"
- "Cliente potencial" no "prospect"
- "Cuánto tarda en cerrar un cliente" no "sales cycle"
- "Lo que cobramos cada mes" no "MRR"
- "Pista de dinero" no "runway"

Más en `references/humanos.md` tabla traduce-jerga.
