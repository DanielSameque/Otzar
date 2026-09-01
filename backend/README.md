# Otzar — Backend

API REST NestJS do Otzar, uma plataforma de gestão de projetos, tarefas, tickets e base de conhecimento.

O frontend Flutter fica em `../frontend`.

## Executar

```powershell
npm install
Copy-Item .env.example .env
npm run prisma:generate
npm run start:dev
```

A API sobe em `http://localhost:3000`. Verificar com `curl http://localhost:3000/health`.

## Documentação

| Escopo | Local |
| ------ | ----- |
| Backend (implementação, endpoints, ambiente) | [`docs/`](docs) |
| Produto (regras de negócio, modelo de dados, API) | [`../frontend/docs/`](../frontend/docs) |
| Mapa do monorepo | [`../docs/README.md`](../docs/README.md) |

Principais documentos:

- [Fundação](docs/arquitetura/fundacao.md)
- [Ambiente de desenvolvimento](docs/ambiente-de-desenvolvimento.md)
- [Princípios da API](../frontend/docs/09-api.md)
- [Regras de negócio](../frontend/docs/04-regras-de-negocio.md)
