# Digest formatos — payload webhook ceo-notify para CFO

---

## Schema general

Mismo schema que el CEO. La diferencia: `slackChannel: "#paperclip-cfo"`, `fromAgentRole: "cfo"`, `fromAgentName: "CFO"`.

```json
{
  "issueId": "<uuid>",
  "issueTitle": "<título>",
  "urgency": "low|medium|high|urgent",
  "channel": "slack-only|email-only|both",
  "slackChannel": "#paperclip-cfo",
  "audience": ["raul"] | ["raul", "dey"] | ["dey"],
  "summary": "<digest markdown>",
  "fromAgentName": "CFO",
  "fromAgentRole": "cfo",
  "actionRequested": "approve|reject|review|input|info",
  "linkToIssue": "https://paperclip.codetrain.cloud/issues/<issueId>"
}
```

**CRÍTICO — `fromAgentRole`:** identifica al agente que **envía** el webhook, no al rol que originalmente pidió la decisión. Para vos como CFO, el valor es **siempre** `"cfo"` y `fromAgentName` es **siempre** `"CFO"`. n8n usa este campo para routing — valores distintos rompen el switch.

URL: `https://n8n-dev1.codetrain.cloud/webhook/ceo-notify` (mismo webhook, n8n hace fan-out por slackChannel).

---

## Formato 1 — Aprobación de gasto

```markdown
💰 *Aprobación requerida* — gasto $X

*De qué se trata:* [descripción sin jerga]
*Por qué se necesita:* [razón concreta]
*Cuánto es:* $X (una vez / cada mes)
*Impacto en el dinero disponible:* [si es relevante: "esto baja la pista de 8 a 7.5 meses"]
*Mi recomendación:* [aprobar / rechazar / contraponer alternativa]

Respondé en thread "sí / no / [contrapropuesta]" o por email.
```

**Ejemplo concreto:**

```markdown
💰 *Aprobación requerida* — gasto $200/mes

*De qué se trata:* LinkedIn Sales Navigator Premium para mejorar el motor de ventas
*Por qué se necesita:* El equipo de mercadeo dice que duplica la cantidad de prospectos buenos por hora de trabajo
*Cuánto es:* $200 cada mes (subscripción)
*Impacto en el dinero disponible:* Baja nuestra pista de dinero de 8 meses a 7.6 meses
*Mi recomendación:* Aprobar por 3 meses con compromiso de medir resultados. Si en esos 3 meses no traemos al menos 2 clientes nuevos atribuibles a esa herramienta, lo cancelamos.

Respondé en thread "sí / no / [contrapropuesta]" o por email.
```

---

## Formato 2 — Resumen semanal (lunes 8am Ecuador)

```markdown
📊 *Resumen financiero semanal* — semana del 22 al 28 abril

*Ingresos esperados esta semana:* $4,500 (de Conecta Suite Fase 2 — pago programado el viernes)
*Gastos del mes hasta hoy:* $620 ($386 en APIs, $80 en hosting, $154 en herramientas operativas)
*Dinero disponible:* alcanza para aproximadamente 8 meses al ritmo actual de gastos

*Alertas:*
- Ninguna esta semana

*Algo que necesita tu atención:*
- Conecta Suite tiene pago programado el viernes 26. Si no entra, el mes baja a 7 meses de pista.
```

---

## Formato 3 — Cierre de mes (primer lunes del mes 9am EC)

```markdown
💼 *Cierre de mes — abril 2026*

*Lo que entró:*
- Conecta Suite Fase 2 (cuota): $1,400
- Transaher (vía Javier): $X,XXX
- Total ingresos del mes: $X,XXX

*Lo que salió:*
- APIs: $386
- Hosting + dominios: $80
- Herramientas operativas: $170
- Otros: $XX
- Total gastos del mes: $XXX

*Resultado:*
- Quedaron limpios después de todo: $X,XXX
- Eso es un margen de XX% sobre lo que entró
- Comparado con marzo, el margen subió/bajó X puntos por [razón concreta]

*Estado del dinero disponible:*
- Al cierre tenemos $XX,XXX
- Al ritmo actual alcanza para X meses
- Comparado con cierre de marzo, [creció/bajó] X meses

*Lo que recomiendo revisar:*
- [propuesta concreta basada en lo que viste el mes]
```

---

## Formato 4 — Alerta runway

```markdown
🚨 *Alerta: dinero disponible* — pista bajó a X meses

*Estado:*
- Tenemos $XX,XXX en cuentas
- Al ritmo actual de gastos ($Y,YYY/mes) alcanza para X meses
- El mes pasado eran X+1 meses

*Por qué bajó:*
- [razón concreta — ej. "agregamos $200/mes en Sales Navigator + $150/mes en plataforma email"]
- [+ ingresos esperados que no entraron]

*Mi recomendación:*
- [acción concreta — ej. "pausar Sales Navigator hasta que entre Conecta Suite Fase 2"]
- [+ revisar contratos de clientes con pago atrasado > 30 días]

Respondé "sigo / pauso / [otra cosa]" o por email.
```

---

## Formato 5 — Reporte trimestral

```markdown
📈 *Reporte trimestral Q1 2026*

*Lo que entró este trimestre:*
- Total: $XX,XXX
- Por cliente:
  - Transaher: $X,XXX (XX% del total)
  - Conecta Suite: $X,XXX (XX%)
  - Otros: $X,XXX

*Lo que salió:*
- Total: $X,XXX
- Por categoría:
  - APIs: $X,XXX (XX%)
  - Hosting + dominios: $XXX
  - Herramientas: $XXX

*Resultado:*
- Quedaron limpios: $X,XXX
- Margen del trimestre: XX%

*Avance de objetivos:*
- Revenue Q2 base $20-35K: vamos en $X,XXX (XX% del base)
- Concentración Transaher: XX% (meta <40% al fin de año)
- Margen ≥45% (meta 12m): estamos en XX%

*Aprendizajes principales:*
- [3-5 bullets concretos]

*Recomendaciones:*
- [3 acciones para Q2]
```

---

## Reglas en cada digest

- "Pista de dinero" / "dinero disponible" no "runway"
- "Lo que cobramos cada mes" no "MRR"
- "Lo que entró" / "lo que salió" no "revenue/OPEX"
- "Quedaron limpios" no "net margin"
- "Por cada $100 de venta, $X quedan" no "gross margin %"
- "Persona interesada" / "gente que pide info" no "lead"

Tabla completa: `references/humanos.md`.
