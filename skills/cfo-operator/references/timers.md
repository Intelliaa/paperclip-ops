# Timer wakes — rutinas programadas CFO

Cuando despertás con `wakeReason: timer`, el `contextSnapshot.timerType` indica el tipo de rutina.

---

## Lunes 8am Ecuador (UTC-5) — Resumen semanal

1. Listar ingresos esperados de la semana (vía Twenty CRM o data manual)
2. Sumar gastos del mes hasta hoy
3. Calcular runway al ritmo actual
4. Detectar alertas (ninguna / específicas)
5. Identificar items que necesitan atención esta semana
6. Generar digest formato 2 (`references/digest-formatos.md`)
7. POST al webhook ceo-notify con `slackChannel: "#paperclip-cfo"` + `audience: ["raul"]`

---

## Primer lunes del mes 9am Ecuador — Cierre de mes

1. Listar todos los ingresos del mes anterior
2. Listar todos los gastos del mes anterior
3. Calcular margen mensual + comparar con promedio 3m
4. Calcular dinero disponible al cierre
5. Comparar con cierre del mes anterior
6. Generar digest formato 3 (`references/digest-formatos.md`)
7. POST al webhook ceo-notify con `audience: ["raul", "dey"]`

---

## Diario — Monitor operativo

1. Verificar que workflows críticos del Sales Engine NO estén fallando:
   - `mcp__n8n-mcp__n8n_executions` — listado de ejecuciones recientes
   - Si > 3 ejecuciones consecutivas con `error` en un workflow crítico → alertar
2. Si todo OK → silencio (no spamear)
3. Si hay falla → Slack a Raul con detalles

---

## Primer día del trimestre — Reporte trimestral

1. Calcular revenue/gastos/margen del trimestre completo
2. Avance de objetivos vs OKRs (`references/numeros-base.md`)
3. Concentración de revenue por cliente (Transaher %)
4. Aprendizajes principales (3-5 bullets)
5. Recomendaciones para próximo trimestre
6. Generar digest formato 5 + email
7. POST con `audience: ["raul", "dey"]` + thread en Slack

---

## Estructura de un timer wake

```json
{
  "wakeReason": "timer",
  "contextSnapshot": {
    "timerType": "weekly_summary|monthly_close|daily_monitor|quarterly_report",
    "scheduledFor": "<ISO timestamp>",
    "timerId": "<uuid>"
  }
}
```

Si `timerType` no está definido, asumir `daily_monitor` y proceder.

---

## Cosas que NO hacés en timer

- Cierre de mes que no es tuyo (ej. cliente cierra contrato — eso es del CEO)
- Comunicación a clientes (eso es del CMO)
- Hires (eso es del CEO)
- Proyecciones largas (>6 meses) — escalás al CEO si te las piden
