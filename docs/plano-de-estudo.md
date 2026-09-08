# Plano de estudo — Otzar

Guia de aprendizado para contribuir no monorepo: Cursor, IA, produto e stack.

Ordem sugerida: **Cursor → IA → Otzar → Stack**. Assim você aprende a ferramenta, o modo de trabalhar com IA, o produto e só depois o código.

---

# Fase 0 — Mapa mental (1 dia)

Antes de aprofundar, fixe isto:


| Camada   | O que é no Otzar                             |
| -------- | -------------------------------------------- |
| Produto  | Gestão de projetos + tickets + base Markdown |
| Frontend | Flutter (Web + mobile), MVVM                 |
| Backend  | NestJS (Node.js + TypeScript), API REST      |
| Dados    | Prisma 7 → PostgreSQL (Neon)                 |
| Deploy   | Render (site estático + web service)         |
| Agente   | Cursor com Rules + Skills + docs             |


**Leitura rápida:** `[README.md](../README.md)` → `[docs/README.md](README.md)` → `[frontend/docs/01-visao-geral.md](../frontend/docs/01-visao-geral.md)`.

---



# Fase 1 — Cursor



## 1.1 Geral

- Chat vs Agent vs Ask (quando editar / só perguntar)
- Contexto: `@` arquivos, docs, seleção de código
- Monorepo: trabalhar em `frontend/` e `backend/` sem misturar responsabilidades
- Terminal, diffs e revisão antes de aceitar mudanças
- Commits só quando pedido; documentação como parte da tarefa

**Prática:** abrir o Otzar no Cursor, pedir um resumo de `[07-arquitetura.md](../frontend/docs/07-arquitetura.md)` em Ask mode.

## 1.2 Rules

No Otzar as rules vivem em:

```text
.cursor/rules/                 → documentacao.mdc (sempre)
frontend/.cursor/rules/        → flutter-*.mdc
backend/.cursor/rules/         → nestjs-*.mdc
```

Pontos principais:

- O que são rules (instruções persistentes do agente)
- Always apply vs globs (`**/*.dart`, `backend/**/*.ts`)
- A rule de documentação: ler docs antes, atualizar depois
- Rules de arquitetura Flutter (View → ViewModel → Service → Repository)
- Rules NestJS (Controller → Service → Prisma; regras de negócio no backend)

**Prática:** ler uma rule Flutter e explicar, em 5 linhas, o que o agente não pode fazer.

## 1.3 Skills

- Diferença: **Rules** = regras contínuas; **Skills** = procedimentos sob demanda (`SKILL.md`)
- Quando criar skill (fluxo repetível: PR, review, hook, setup)
- Skills do Cursor vs skills do projeto
- Como o agente “lê e segue” a skill no início da tarefa

**Prática:** listar 2 skills úteis para o Otzar (ex.: “atualizar docs após endpoint”, “checklist de fundação Flutter”).

---



# Fase 2 — IA

O roadmap do Otzar prevê agente na base de conhecimento e nos projetos. Estudar isto prepara o produto e o dia a dia com Cursor.

## 2.1 Fundamentos

- LLM: prompt, contexto, tokens, alucinação
- Grounding: resposta ancorada em docs/código (o Otzar usa docs como fonte de verdade)
- Agentes: ferramenta + loop (ler → agir → verificar)



## 2.2 RAG (Retrieval-Augmented Generation)

Especialmente relevante para a base Markdown e a “IA especialista no conhecimento da empresa”.

Pontos principais:

- Indexação (chunking) → embedding → busca → contexto no prompt
- Quando RAG ajuda vs quando rules/docs no Cursor bastam
- Qualidade: chunk size, metadados (projeto, tarefa, ticket), citações
- Riscos: contexto errado, docs desatualizados (daí a rule de sync docs ↔ código)

**Prática conceitual:** desenhar como um ticket usaria RAG sobre documentos N:N vinculados.

## 2.3 Harness

“Harness” = o que cerca o modelo para ele ser útil e seguro.

Pontos principais:

- Contexto (repo, rules, skills, MCP)
- Ferramentas (ler/editar, terminal, busca)
- Guardrails (Ask mode, permissões, não commit automático)
- Feedback loop: testes, lint, health check, revisão humana
- No Otzar: harness = Cursor + rules do monorepo + docs + ambiente local

**Prática:** mapear “o que o agente pode e não pode fazer” no seu fluxo Otzar.

## 2.4 Spec kit

Kit de **especificação** para agentes e features. Se o foco for *Eval kit*, troque esta seção por métricas de qualidade do agente.

Pontos principais:

- Spec clara: objetivo, fora de escopo, critérios de aceite
- Specs do Otzar já existem em docs (`[04-regras-de-negocio.md](../frontend/docs/04-regras-de-negocio.md)`, `[10-mvp.md](../frontend/docs/10-mvp.md)`, `[03-modelo-de-dados.md](../frontend/docs/03-modelo-de-dados.md)`)
- Converter doc → tarefa agentável (ex.: “implementar GET /health conforme `[backend/docs/endpoints/health.md](../backend/docs/endpoints/health.md)`”)
- Checklist de aceite + testes
- Evitar prompt solto; preferir spec + doc + rule

**Prática:** pegar um item do MVP e escrever uma spec de 10 linhas para o Agent.

---



# Fase 3 — Otzar (produto e domínio)

Ordem de leitura sugerida:


| Ordem | Documento                                                          | Foco                    |
| ----- | ------------------------------------------------------------------ | ----------------------- |
| 1     | `[01-visao-geral](../frontend/docs/01-visao-geral.md)`             | O que é / o que não é   |
| 2     | `[02-glossario](../frontend/docs/02-glossario.md)`                 | Vocabulário             |
| 3     | `[10-mvp](../frontend/docs/10-mvp.md)`                             | O que construir agora   |
| 4     | `[03-modelo-de-dados](../frontend/docs/03-modelo-de-dados.md)`     | Entidades e relações    |
| 5     | `[04-regras-de-negocio](../frontend/docs/04-regras-de-negocio.md)` | Fonte de verdade da API |
| 6     | `[05-modulos](../frontend/docs/05-modulos.md)`                     | Módulos funcionais      |
| 7     | `[07-arquitetura](../frontend/docs/07-arquitetura.md)`             | Camadas FE/BE           |
| 8     | `[09-api](../frontend/docs/09-api.md)`                             | Princípios REST         |
| 9     | `[11-roadmap](../frontend/docs/11-roadmap.md)`                     | IA e evolução           |
| 10    | `[backend/docs/](../backend/docs/README.md)`                       | Fundação e endpoints    |




## Pontos principais do domínio

- Uma organização; projetos, backlog, sprints (roadmap), tarefas
- **Ticket ≠ tarefa** (suporte é entidade própria)
- Base de conhecimento: **um** acervo Markdown, vínculos N:N
- Visualizações: Kanban, calendário, timeline, tabela (mesmos dados)
- Backend = única fonte de verdade das regras
- Documentação sincronizada com o comportamento atual

**Prática:** explicar em 1 parágrafo a diferença entre tarefa, ticket e documento.

---



# Fase 4 — Stack tecnológica



## 4.1 Flutter / Dart

- Dart básico (tipos, async, null safety)
- Widgets, navegação, estado
- Arquitetura Otzar: **MVVM + Service + Repository + ApiClient**
- Web + mobile, uma base
- `API_URL` via `--dart-define`
- Fundação: `[frontend/docs/13-fundacao.md](../frontend/docs/13-fundacao.md)` + rules `flutter-*.mdc`

**Prática:** seguir o fluxo View → … → API num feature existente (ou health).

## 4.2 Node.js / NestJS / TypeScript

- Node e npm scripts (`start:dev`, Prisma)
- NestJS: Module, Controller, Service, DI
- Validação, filtros de erro, health
- Regras de negócio só no backend
- Fundação: `[backend/docs/arquitetura/fundacao.md](../backend/docs/arquitetura/fundacao.md)` + rules `nestjs-*.mdc`

**Prática:** ler o endpoint `GET /health` (código + `[backend/docs/endpoints/health.md](../backend/docs/endpoints/health.md)`).

## 4.3 PostgreSQL + Prisma

- Modelo relacional, FKs, transações
- Prisma schema, migrate, generate, Client
- Prisma 7 + `adapter-pg` + `prisma.config.ts` (decisão documentada em `[08-stack-tecnologica.md](../frontend/docs/08-stack-tecnologica.md)`)
- Neon em cloud; local via `DATABASE_URL`
- Frontend **nunca** acessa o banco

**Prática:** relacionar 3 entidades do `[03-modelo-de-dados](../frontend/docs/03-modelo-de-dados.md)` com o que existiria no schema Prisma.

## 4.4 Infra (complemento útil)

- Render: estático (Flutter Web) + Web Service (NestJS)
- CORS, HTTPS, variáveis de ambiente
- Hibernação free tier (latência a frio)

Detalhes em `[08-stack-tecnologica.md](../frontend/docs/08-stack-tecnologica.md)` e `[12-ambiente-de-desenvolvimento.md](../frontend/docs/12-ambiente-de-desenvolvimento.md)`.

---



# Cronograma sugerido (4 semanas, ritmo leve)


| Semana | Foco                                          | Entrega de aprendizado                       |
| ------ | --------------------------------------------- | -------------------------------------------- |
| 1      | Cursor (geral + rules + skills) + setup local | Ambiente sobe; sabe onde estão as rules      |
| 2      | Otzar produto (visão → MVP → modelo → regras) | Consegue explicar o domínio sem código       |
| 3      | Flutter + NestJS na arquitetura do repo       | Desenha o fluxo de uma tela até o banco      |
| 4      | Prisma/PostgreSQL + IA (RAG/harness/spec)     | Spec de uma feature MVP + ideia de RAG na KB |


---



# Checklist — pronto para contribuir

- [ ] Sobe backend e frontend localmente (`[12-ambiente-de-desenvolvimento.md](../frontend/docs/12-ambiente-de-desenvolvimento.md)`)
- [ ] Sabe onde documentar produto vs backend (`[docs/README.md](README.md)`)
- [ ] Entende MVVM Flutter e camadas NestJS
- [ ] Sabe que regras de negócio mudam primeiro no backend + `[04-regras-de-negocio.md](../frontend/docs/04-regras-de-negocio.md)`
- [ ] Lê a rule relevante antes de pedir mudança ao Agent
- [ ] Escreve specs curtas em vez de prompts vagos
- [ ] Conhece o escopo do MVP (e o que fica de fora)