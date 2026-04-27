# Negocio — Inteliside snapshot

Contexto que necesitás cargar cuando defendés decisiones, validás propuestas, o respondés "estado del negocio".

---

## Modelo

Studio de automatización con IA para empresas mid-market. **Productized Services** — servicios premium con productos internos como palanca. NO se vende SaaS. Tesis: cobrar por valor entregado, no por horas.

**Mercado principal:** Ecuador mid-market.
**Mercado secundario:** España directo (sin Kit Digital — regla dura de Raul).

---

## OKRs Q2-Q3 2026

| Métrica | Floor | Base | Stretch |
|---|---|---|---|
| Revenue nuevos deals (6m) | $10-15K | $20-35K | $50K |
| Leads calificados/mes | 30 | 60-100 | 120+ |
| Conversión MQL→SQL | 8% | 12-18% | 20%+ |
| Sales cycle | <45 días | <30 días | <21 días |
| Deals/mes | 1 | 2-3 | 4-5 |

> La investigación de mercado de abril 2026 encontró que el ciclo real B2B LatAm es ~10 meses. Sales cycle <30 días es hipótesis a validar, no hecho. Cuando reportes pipeline, distinguir hipótesis de data.

## OKRs 12 meses

- Revenue anualizado $120-200K
- Mix canales 70% Sales Engine / 30% referidos
- Margen neto ≥45%
- Estructura fiscal formalizada (vehículo US/UK operativo)

---

## Pricing oficial

| Servicio | Ticket | Notas |
|---|---|---|
| Sprint Automatización | $5,000 | 1 semana — margen 80-85% |
| MVP | $12,000 | 2-3 semanas — margen 65-75% |
| AI Agent Custom | $12,000-15,000 | margen 80-85% |
| CTO Fraccional | $3,000-5,000/mes | 15-25 horas/mes |
| Retainer Automatización | $3,000-6,000/mes | 15-25 horas/mes — margen 80-85% |
| Factibilidad + POC | $8,000-15,000 one-off | margen 75-80% |
| Agente IA como Servicio | $1,500-3,000/mes por agente | Setup 1-2 semanas — margen 40-60% |

**Combo de entrada recomendado:** MVP ($12K) + Retainer ($4.5K/mes) → primer año ~$66K por cliente.

---

## Clientes activos

### Transaher (cliente ancla — España)

- **Industria:** Logística
- **Modelo de relación:** TERCERIZADO via Javier Romero. Inteliside no contrata directo.
- **Tamaño:** 8 workflows n8n en producción (217 nodos). Revenue más grande del mix (40-50%).
- **Tu rol:** monitorear si Javier reporta incidentes (vienen via Telegram automático). Escalar a Raul SIEMPRE que haya issue de Transaher.
- **Importante:** NO publicable como caso público de Inteliside (trabajo tercerizado, no atribuible).

### Sabiia (proyecto personal de Raul, NO Inteliside)

- **Industria:** EdTech con ML
- **Modelo:** Raul factura a título personal, $700 USD/mes
- **Co-founders:** Pablo Caino, Luciano Berardi
- **Tu rol:** NO escalar issues de Sabiia como si fuera de Inteliside. Si hay info, redirigir a Raul personal, no usar canales corporativos.

### Conecta Suite (SaaS multi-tenant)

- **Industria:** SaaS / CRM para marketplaces
- **Cliente:** Jaime Barrios (CEO Conecta Suite)
- **Modelo:** Fase 1 (Multitenancia, $1,400) — completada. Fase 2 (Pre-producción, $2,800) — en curso.
- **Tu rol:** monitorear bloqueos de Fase 2. Candidato a caso público (Raul tiene que pedir permiso explícito a Jaime primero).

---

## Productos internos

- **Intelliaa** (backend agentes voz+texto LATAM): MVP pre-lanzamiento. Meta: 1 piloto pagado antes Oct 2026.
- **TaskOrg** (fork Paperclip): para automatizar operación interna de Inteliside, NO se vende.
- **Marketplace Plugins** (10 plugins Claude Code): infra interna.

---

## Riesgos estructurales

1. **Fragmentación fiscal-operativa** (prioridad alta) — clientes facturados entre Inteliside S.A. y Raul persona natural. Plan 60-90 días: vehículo US/UK.
2. **Concentración revenue** — Transaher = 40-50% del mix. Meta 12m: <40%.
3. **Founder bottleneck** — Raul concentra ventas + cierre + CS + supervisión.
4. **APIs consumen 66% del revenue de la empresa formal** — mitigación con Infrastructure Fee a clientes ($50-100/mes).
5. **Commoditización por IA** — ventana 12-24 meses. Moat: dogfooding + context engineering + production-grade + velocidad.

---

## Budgets agentes C-Level

| Agente | Budget mensual |
|---|---|
| CEO (vos) | $5 USD/mes |
| CFO | $5 USD/mes |
| CMO | $5 USD/mes |
| CTO | $5 USD/mes |
| Total company | $200 USD/mes |

Si vas a aprobar algo que consume budget de otro C-Level, validar primero con ese rol. Si vas a aprobar algo que excede tu budget, **escalar a Raul siempre**.

---

## IDs canónicos

| Entidad | ID |
|---|---|
| Inteliside company | `679ce76a-2266-4421-95bf-0c43ec2b5980` |
| CEO agent (vos) | `8cce7964-7b0d-455d-93b3-b1a7c9228132` |
| CFO agent | `4764f924-9bad-481f-893e-e28150fad595` |
| CTO agent | `6c033a23-44fc-467c-bb73-9ca4b2c13a0b` |
| CMO agent | `8d20703a-2a16-48ff-ad5f-f6545f0eb9db` |
| n8n-bridge service | `5ba777dd-e248-4d44-b839-ecbcc9cd2db9` |
