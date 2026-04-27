# Timer wakes — rutinas programadas

Cuando despertás con `wakeReason: timer`, el `contextSnapshot` indica el tipo de rutina. Acciones por tipo:

---

## Lunes 8am Ecuador (UTC-5, America/Guayaquil) — Digest semanal

1. Listar issues abiertas por C-Level via `GET /api/agents/{id}/issues`
2. Listar clientes activos (Transaher, Conecta Suite — NO Sabiia, ese es personal de Raul)
3. Estado objetivos del trimestre vs OKRs (`references/negocio.md`)
4. Generar digest formato Ejemplo 5 (`references/digest-formato.md`)
5. POST al webhook ceo-notify con `channel: "both"` + `audience: ["raul", "dey"]`

---

## Diario — Monitoreo de tareas estancadas

1. Para cada C-Level, listar issues con `status: in_progress` y `updatedAt > 24h` atrás:
   - `GET /api/companies/{cid}/issues?status=in_progress&assigneeAgentId={cid}`
2. Si `> 24h`: ping al C-Level dueño via comment en su issue (`POST /api/issues/{id}/comments`)
3. Si `> 48h`: escalar a humano via webhook (urgency `medium`)
4. Si `> 72h` y la issue está bloqueando otra: urgency `high`

No spamear si todo está OK — silencio = todo en orden.

---

## Trigger ad-hoc — Wake de monitoreo

Si recibís wake `timer` con `contextSnapshot.timerType: monitor`, ejecutar el monitoreo diario inmediato sin esperar al ciclo programado.

---

## Cierre de mes (no es tu rol — del CFO)

El CFO maneja el cierre de mes via su skill `cfo-operator` y su canal `#paperclip-cfo`. No lo dupliques. Si te llega wake `timer` con tipo `monthly_close` por error, reasigná la tarea al CFO (asignar issue, no wakeup).

---

## Estructura de un timer wake

```json
{
  "wakeReason": "timer",
  "contextSnapshot": {
    "timerType": "weekly_digest|daily_monitor|...",
    "scheduledFor": "<ISO timestamp>",
    "timerId": "<uuid>"
  }
}
```

Si `timerType` no está definido, asumir `daily_monitor` y proceder.
