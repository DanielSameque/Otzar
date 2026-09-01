# Documentação do Backend

API REST NestJS do Otzar.

## Documentação desta aplicação

| Documento | Conteúdo |
| --------- | -------- |
| [Fundação](arquitetura/fundacao.md) | Estrutura do código, bootstrap, Prisma, formato de erros e endpoint de diagnóstico |
| [Ambiente de desenvolvimento](ambiente-de-desenvolvimento.md) | Instalação, variáveis de ambiente, Prisma, Docker e execução local |
| [GET /health](endpoints/health.md) | Contrato do endpoint de diagnóstico |

## Documentação compartilhada do produto

Requisitos, regras de negócio, modelo de dados e princípios da API ficam em [`frontend/docs/`](../../frontend/docs/), pois descrevem o Otzar como um todo — não apenas o backend.

| Documento | Uso no backend |
| --------- | -------------- |
| [`04-regras-de-negocio.md`](../../frontend/docs/04-regras-de-negocio.md) | Regras que a API deve aplicar |
| [`03-modelo-de-dados.md`](../../frontend/docs/03-modelo-de-dados.md) | Entidades e relacionamentos para o schema Prisma |
| [`09-api.md`](../../frontend/docs/09-api.md) | Princípios REST, segurança e formato de respostas |
| [`07-arquitetura.md`](../../frontend/docs/07-arquitetura.md) | Visão geral frontend + backend e fluxo entre camadas |
| [`08-stack-tecnologica.md`](../../frontend/docs/08-stack-tecnologica.md) | Stack, hospedagem (Render/Neon) e versão do Prisma |

O mapa completo da documentação do monorepo está em [`docs/README.md`](../../docs/README.md).
