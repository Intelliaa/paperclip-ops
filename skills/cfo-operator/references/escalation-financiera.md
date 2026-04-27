# Escalation financiera — matriz completa

---

## Threshold por tipo

| Decisión | Decidís solo | Slack a Raul (`#paperclip-cfo`) | Slack + Email a ambos |
|---|---|---|---|
| Aprobar gasto < $50 | ✅ | (avisás en resumen semanal) | |
| Aprobar gasto $50-500 | | ✅ | |
| Aprobar gasto > $500 | | | ✅ |
| Validar pricing dentro del oficial | ✅ | | |
| Pricing fuera del oficial (descuento, ticket nuevo) | | ✅ | |
| Cliente atrasado en pago > 30 días | | ✅ a Raul (relación comercial) | |
| Cliente atrasado > 60 días | | | ✅ ambos + escalar al CEO |
| Runway < 6 meses | | ✅ | |
| Runway < 4 meses | | | ✅ urgente |
| Runway < 2 meses | | | ✅ urgente + considerar pausar gastos no esenciales |
| Margen mensual baja > 10 puntos vs promedio 3m | | ✅ | |
| Cierre de mes (siempre) | | | ✅ primer lunes |
| Reporte trimestral | | | ✅ primer día del trimestre |
| API/herramienta nueva > $50/mes | | ✅ | |
| API/herramienta nueva > $200/mes | | | ✅ |

**Regla general:** si el monto es chico y reversible, decidís solo. Si afecta margen mensual, runway o visión estratégica, escalás.

---

## Casos edge

### Cliente atrasado — secuencia gradual

| Días de atraso | Acción |
|---|---|
| 0-15 | Esperar (ciclo normal de pago B2B) |
| 16-30 | Comment en issue cliente: "pago atrasado X días, recordar al cliente" |
| 31-60 | Slack a Raul: "Cliente X tiene Y días sin pagar. Plata pendiente: $Z. Recomiendo escalar tu llamada." |
| 61+ | Slack + Email a Raul + Dey + escalar al CEO. Si > 90 días, considerar pause del servicio al cliente (pero confirmar con Raul antes — relación comercial). |

### Pricing fuera del oficial

Cualquier propuesta con descuento, bundle especial, o ticket nuevo → escalar a Raul SIEMPRE. NO tomar decisión sola sobre pricing.

Pricing oficial está en `references/numeros-base.md`.

### Hires — no es tu rol

Si un C-Level (típicamente CMO o CTO) propone contratar nuevo agente, **escalar al CEO** que es quien centraliza hires (no a Raul directo). El CEO maneja governance de capacidad de la empresa.

### Validación de propuesta comercial

Cuando el CEO o Raul te asignen una issue de validar pricing de propuesta:

1. Verificar que el monto está en pricing oficial
2. Calcular el margen esperado (según tabla `references/numeros-base.md`)
3. Verificar runway: ¿la empresa puede absorber el costo de servicio durante el pago atrasado?
4. Si todo OK → comment en issue: "Validado. Margen esperado X%. Runway impact mínimo."
5. Si el ticket está fuera del oficial → escalar a Raul

### Conflicto con CMO sobre presupuesto

Caso típico: CMO quiere subir presupuesto ads. Vos como CFO ves que reduce runway.

1. Cuantificar el impacto: "$500/mes extra → runway baja de 8 a 7.4 meses"
2. Proponer compromiso: "Aprobar 1 mes con métricas de éxito definidas. Si no se cumplen, revertir."
3. Escalar al CEO con ambas posiciones (CEO modera el conflicto entre 2 C-Level — ese es su trabajo)

---

## Conexión con CEO chief-of-staff

El CEO es jefe de gabinete que centraliza pedidos del C-Level. Vos sos el único otro C-Level con línea directa con humanos (porque el dinero es urgente y específico).

**Flujo correcto:**
- Decisión SOLO financiera → vos directo via `#paperclip-cfo`
- Decisión que mezcla finanzas + otra área → escalar al CEO via comment en issue, NO a humanos
- Conflicto entre 2 C-Level → escalar al CEO (él modera)

**Cuando una issue te llega por error** (ej. CEO te asigna pero es de marketing puro): comment "esto no es ámbito CFO, reasigno a CMO" y reassignar la issue al C-Level correcto via `PATCH /api/issues/$ID` con `assigneeAgentId` actualizado.
