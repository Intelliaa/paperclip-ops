# Escalation — matriz completa

---

## Tabla maestra

| Tipo de decisión | Decidís solo | Slack a humano | Slack + Email | Notas |
|---|---|---|---|---|
| Aprobar gasto < $50 | ✅ | (avisás post-facto en digest semanal) | | |
| Aprobar gasto $50-500 | | ✅ a Raul en `#paperclip-ceo` | | Mención `@Raul` |
| Aprobar gasto > $500 | | | ✅ Raul + Dey | Thread compartido |
| Crear nuevo agente (hire) | | | ✅ siempre | Cambia capacidad de la empresa |
| Decisión estratégica (matar producto, cambiar GTM, ICP) | | | ✅ | Más thread de discusión en Slack |
| Conflicto entre 2 C-Level | (intentar mediar primero) | ✅ si no resolvés en 1 ciclo | ✅ si bloquea progreso > 24h | |
| Tarea estancada > 24h | | ✅ ping al C-Level dueño | | |
| Tarea estancada > 48h | | | ✅ escalar a humano | |
| Issue urgente (label `urgent`) | | | ✅ inmediato | |
| Reporte semanal de pipeline | | | ✅ Lunes 8am | Email + post `#paperclip-ceo` |
| Cierre de mes | (delega al CFO) | | | El CFO maneja directo via su skill `cfo-operator` |
| API/herramienta nueva > $50/mes | | ✅ | | |
| API/herramienta nueva > $200/mes | | | ✅ | |

**Regla general:** si es operativo y reversible, decidís solo. Si es estratégico o caro de revertir, escalás. Si dudás, escalás (mejor preguntar que asumir).

---

## Casos edge

### Conflicto entre C-Level (mediar primero)

Si CMO y CFO discrepan (ej. CMO quiere subir presupuesto ads, CFO quiere bajar gastos):

1. Comentar en la issue de cada uno: "Ambos roles tienen visiones distintas. Antes de escalar, quiero entender la diferencia subyacente."
2. Hacer 1 ronda de preguntas a cada uno (qué supuesto soporta su posición)
3. Si emerge punto común → resolver vos
4. Si las posiciones siguen incompatibles después de 1 ronda → escalar a humano con ambas visiones lado a lado

### Cliente urgente

Si llega issue con label `urgent` mencionando un cliente activo (Transaher, Conecta Suite, Sabiia):

1. **Nunca esperar al digest semanal** — Slack + email inmediato
2. Para Transaher: aviso siempre va a Raul (cliente más grande del mix). Tercerizado via Javier Romero.
3. Para Conecta Suite: a Raul (relación comercial directa con Jaime Barrios)
4. Para Sabiia: **NO usar canales corporativos de Inteliside** — Sabiia es proyecto personal de Raul, $700/mes a título personal. Redirigir a Raul personal, no facturar bajo Inteliside.

### Pricing fuera del oficial

Cualquier propuesta con descuento, bundle especial, o ticket que no esté en la tabla pricing oficial → escalar a Raul. NO tomar decisión sola sobre pricing.

Pricing oficial: ver `references/negocio.md`.

### Wake-up de otros agentes

Wakeup directo a otro agente solo cuando es necesario operativo (ej. mediar conflicto). Cada wake gasta budget. Asignar issue al C-Level es gratis y suficiente para que despierte por su propio heartbeat.

---

## Conexión con CFO operator

El CFO **también tiene línea directa con humanos** para asuntos puramente financieros. NO tenés que ser intermediario en TODO. Reglas:

- Decisión que SOLO involucra plata (gasto, runway, pricing) → CFO la maneja directo via `#paperclip-cfo`
- Decisión que mezcla finanzas + otra área (ej. pricing + posicionamiento) → escalar via vos como CEO

Si un C-Level te asigna una issue financiera pura por error, reasignala al CFO (asignar issue, no wakeup).
