# Números base — Inteliside snapshot financiero

---

## Modelo de negocio

Inteliside es un studio de automatización con IA. Vende **servicios premium** (no SaaS). El truco económico: usar IA y automatización propia para entregar 2-3x más rápido que la competencia, lo que permite cobrar precios altos con márgenes altos.

---

## Ingresos (revenue) — clientes activos

| Cliente | Tipo | Cuánto entra | Dónde se factura | Notas |
|---|---|---|---|---|
| Transaher (logística España) | Cliente ancla | El más grande del mix (40-50% del total) | Vía Javier Romero (intermediario), `JAVIER ROMERO TORRES SL` | Tercerizado — Inteliside no contrata directo. Es el ingreso más estable pero también la mayor concentración de riesgo |
| Conecta Suite (SaaS multi-tenant) | Proyecto activo | Fase 1 ya cobrada ($1,400). Fase 2 en curso ($2,800). | Inteliside S.A. (formal) | Cliente: Jaime Barrios |
| Sabiia (EdTech con ML) | NO Inteliside, personal de Raul | $700/mes | Raul persona natural — NO Inteliside | **No contar este como ingreso de Inteliside** |
| Otros (referidos sueltos) | Variable | A documentar mes a mes | Mix Inteliside / Raul persona natural | Estructura legacy |

---

## Pricing oficial

| Servicio | Precio | Tiempo de entrega | Margen |
|---|---|---|---|
| Sprint Automatización | $5,000 | 1 semana | 80-85% (queda $4,000-4,250 limpios) |
| MVP | $12,000 | 2-3 semanas | 65-75% (queda $7,800-9,000 limpios) |
| AI Agent Custom | $12,000-15,000 | 2-3 semanas | 80-85% |
| CTO Fraccional | $3,000-5,000/mes | 15-25 horas/mes | ~100% |
| Retainer Automatización | $3,000-6,000/mes | 15-25 horas/mes | 80-85% |
| Factibilidad + POC | $8,000-15,000 (one-time) | 2-3 semanas | 75-80% |
| Agente IA como Servicio | $1,500-3,000/mes por agente | Setup 1-2 semanas | 40-60% |

**Combo de entrada recomendado:** MVP ($12K) + Retainer ($4.5K/mes). En el primer año un cliente puede dejar $66K (12K inicial + 12 meses x $4.5K = $54K).

---

## Gastos (lo que sale)

| Categoría | Monto aprox | Notas |
|---|---|---|
| APIs (OpenAI, Anthropic, Linear, Notion, Canva) | $386 / mes | **Riesgo crítico:** 66% del ingreso directo de Inteliside S.A. (no contando Raul persona natural). Mitigación: cobrar "Infrastructure Fee" mensual a clientes ($50-100 por cliente activo) |
| Dominios + hosting + Tailscale | ~$80 / mes | Estable |
| Herramientas (Sales Navigator, etc) | ~$170 / mes | LinkedIn + Sales Navigator + plataforma motor de ventas + plataforma de newsletter |
| Otros operativos | Variable | Depende del mes |

---

## Riesgos financieros

1. **Fragmentación fiscal-operativa (prioridad alta):** clientes facturados entre Inteliside S.A. y Raul persona natural. La empresa formal genera margen muy delgado (~$100-180/mes) mientras la operación real factura mucho más vía Raul. Plan 60-90 días: vehículo legal en Estados Unidos o Reino Unido (LLC), migración gradual de clientes.

2. **Concentración de ingresos:** cliente ancla Transaher = 40-50% del total. Si lo perdemos, perdemos casi la mitad del ingreso. Meta a 12 meses: bajar esa concentración a menos de 40%.

3. **Dependencia de un solo founder:** Raul concentra ventas + cierre + soporte + supervisión. Si no puede operar 1-2 meses, los ingresos se caen.

4. **APIs consumen 66% del ingreso de la empresa formal:** mitigación con cobro de "Infrastructure Fee" a clientes.

5. **Commoditización del servicio por IA:** ventana de oportunidad estimada 12-24 meses antes de que cualquiera pueda ofrecer "automatización con IA" como commodity. Mitigación: defender el moat (dogfooding propio, casos en producción real, contexto profundo, velocidad).

---

## Objetivos 2026 (los que defendés)

- **Q2-Q3 2026 (3-6 meses):** revenue de $20-35K en deals nuevos (escenario base)
- **12 meses:** ingresos anualizados de $120-200K, con margen neto >= 45% (más de la mitad limpio después de todos los gastos)
- **2028:** $500K-1M anuales, equipo de 4-6 personas operando con stack IA propio

---

## Sistemas que monitoreás

### Twenty CRM

Acceso vía MCP. Endpoints útiles:
- `mcp__twenty-crm__list_opportunities_by_stage` — clientes potenciales por etapa del embudo
- `mcp__twenty-crm__search_companies` — empresas que estamos prospectando
- `mcp__twenty-crm__get_relationship_summary` — resumen de relación con un cliente

Lo que medís: cantidad de clientes potenciales por etapa, tiempo en cada etapa, probabilidad de cierre, monto esperado.

### Motor de ventas (Sales Engine)

Vive en n8n dev1 (`https://n8n-dev1.codetrain.cloud`). Workflows clave:
- `Sales Engine v1 — Classify & Score`
- `[SE] Auto 3 — Buscador LinkedIn`
- `Automatización 2 — Clasificador y Validador de Correos`

Acceso vía MCP `n8n-mcp` cargado en Hermes.

Lo que medís: empresas clasificadas/semana, correos válidos obtenidos, primeros contactos enviados, tasa de respuesta.

### Cuentas bancarias y facturación

Por integrar — actualmente Raul tiene un dashboard manual en Notion/Sheets. Por ahora, info de cierres de mes vía comments en issues asignadas, no scrapeo automático.

### Ejecuciones n8n (monitor de operación)

`mcp__n8n-mcp__n8n_executions` — ejecuciones recientes. Útil para detectar workflows críticos fallando (afecta servicio al cliente, afecta ingresos).

---

## IDs canónicos

| Entidad | ID |
|---|---|
| Inteliside company | `679ce76a-2266-4421-95bf-0c43ec2b5980` |
| CEO agent | `8cce7964-7b0d-455d-93b3-b1a7c9228132` |
| CFO agent (vos) | `4764f924-9bad-481f-893e-e28150fad595` |
| CTO agent | `6c033a23-44fc-467c-bb73-9ca4b2c13a0b` |
| CMO agent | `8d20703a-2a16-48ff-ad5f-f6545f0eb9db` |
| n8n-bridge service | `5ba777dd-e248-4d44-b839-ecbcc9cd2db9` |
