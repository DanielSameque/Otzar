# Documentação do Otzar

O Otzar é um monorepo com duas aplicações independentes. A documentação está organizada em três níveis.

---

# Estrutura

```text
Otzar/
├── docs/                  # Índice e orientações do monorepo (este arquivo)
├── frontend/
│   └── docs/              # Documentação do produto + frontend
└── backend/
    └── docs/              # Documentação técnica do backend
```

---

# Onde documentar o quê

| Conteúdo | Local | Exemplos |
| -------- | ----- | -------- |
| Visão do produto, glossário, MVP, roadmap | `frontend/docs/` | `01-visao-geral.md`, `10-mvp.md` |
| Regras de negócio (fonte de verdade para a API) | `frontend/docs/` | `04-regras-de-negocio.md` |
| Modelo de dados (entidades e relacionamentos) | `frontend/docs/` | `03-modelo-de-dados.md` |
| Princípios da API REST | `frontend/docs/` | `09-api.md` |
| Arquitetura geral (frontend + backend) | `frontend/docs/` | `07-arquitetura.md` |
| Stack, hospedagem e comunicação | `frontend/docs/` | `08-stack-tecnologica.md` |
| Fundação e implementação do frontend | `frontend/docs/` | `13-fundacao.md` |
| Fundação e implementação do backend | `backend/docs/` | `arquitetura/fundacao.md` |
| Ambiente de desenvolvimento do backend | `backend/docs/` | `ambiente-de-desenvolvimento.md` |
| Contratos de endpoints da API | `backend/docs/endpoints/` | `health.md` |
| Ambiente completo (frontend + backend) | `frontend/docs/` | `12-ambiente-de-desenvolvimento.md` |

### Regra prática

> Documentação de **produto** (o que o Otzar faz) fica em `frontend/docs/`.
> Documentação de **implementação do backend** (como a API funciona) fica em `backend/docs/`.

Quando uma alteração afetar ambos os lados, atualizar os dois locais e manter os links cruzados.

---

# Regras do Cursor

As regras de codificação ficam em `.cursor/rules/` dentro de cada aplicação:

```text
.cursor/rules/                          # Regras compartilhadas do monorepo
frontend/.cursor/rules/               # Regras Flutter (globs: **/*.dart)
backend/.cursor/rules/                  # Regras NestJS (globs: backend/**/*.ts)
```

| Regra | Escopo |
| ----- | ------ |
| `documentacao.mdc` (raiz) | Política de documentação — sempre aplicada |
| `flutter-*.mdc` | Código Dart do frontend |
| `nestjs-*.mdc` | Código TypeScript do backend |

---

# Índice da documentação do produto

Documentos numerados em `frontend/docs/`:

| # | Documento | Assunto |
| - | --------- | ------- |
| 01 | [Visão geral](../frontend/docs/01-visao-geral.md) | Produto e princípios |
| 02 | [Glossário](../frontend/docs/02-glossario.md) | Termos do domínio |
| 03 | [Modelo de dados](../frontend/docs/03-modelo-de-dados.md) | Entidades e relacionamentos |
| 04 | [Regras de negócio](../frontend/docs/04-regras-de-negocio.md) | Regras aplicadas pela API |
| 05 | [Módulos](../frontend/docs/05-modulos.md) | Módulos funcionais |
| 06 | [UI/UX](../frontend/docs/06-ui-ux.md) | Interface e navegação |
| 07 | [Arquitetura](../frontend/docs/07-arquitetura.md) | Camadas frontend + backend |
| 08 | [Stack tecnológica](../frontend/docs/08-stack-tecnologica.md) | Tecnologias e hospedagem |
| 09 | [API](../frontend/docs/09-api.md) | Princípios REST |
| 10 | [MVP](../frontend/docs/10-mvp.md) | Escopo inicial |
| 11 | [Roadmap](../frontend/docs/11-roadmap.md) | Evolução planejada |
| 12 | [Ambiente de desenvolvimento](../frontend/docs/12-ambiente-de-desenvolvimento.md) | Setup completo |
| 13 | [Fundação (frontend)](../frontend/docs/13-fundacao.md) | Base técnica do Flutter |

# Índice da documentação do backend

| Documento | Assunto |
| --------- | ------- |
| [README](../backend/docs/README.md) | Índice do backend |
| [Fundação](../backend/docs/arquitetura/fundacao.md) | Bootstrap, Prisma, erros, módulos |
| [Ambiente](../backend/docs/ambiente-de-desenvolvimento.md) | Instalação e execução |
| [GET /health](../backend/docs/endpoints/health.md) | Endpoint de diagnóstico |
