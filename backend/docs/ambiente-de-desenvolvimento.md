# Ambiente de Desenvolvimento — Backend

Instalação e execução local da API NestJS do Otzar.

Para o ambiente completo (frontend + backend + banco), consulte também [`frontend/docs/12-ambiente-de-desenvolvimento.md`](../../frontend/docs/12-ambiente-de-desenvolvimento.md).

---

# Pré-requisitos

## Node.js

O backend exige **Node.js 20 ou superior**.

```powershell
node --version
npm --version
```

## PostgreSQL local (opcional)

O backend utiliza PostgreSQL. Em desenvolvimento existem duas opções:

* **Docker** — subir o banco com o `docker-compose.yml` versionado nesta pasta.
* **Neon** — apontar `DATABASE_URL` para o banco gerenciado, conforme [`08-stack-tecnologica.md`](../../frontend/docs/08-stack-tecnologica.md).

Com Docker instalado:

```powershell
cd C:\GitHub\Otzar\backend
docker compose up -d
```

O container expõe o PostgreSQL em `localhost:5432` com usuário, senha e banco `otzar`.

A API sobe mesmo sem banco disponível: `GET /health` responde `database: "down"` em vez de impedir a inicialização. Isso permite desenvolver o frontend antes de configurar o PostgreSQL.

---

# Instalação

```powershell
cd C:\GitHub\Otzar\backend
npm install
```

---

# Variáveis de ambiente

Copiar o arquivo de exemplo e ajustar os valores:

```powershell
Copy-Item .env.example .env
```

| Variável | Finalidade |
| -------- | ---------- |
| `PORT` | Porta da API. Padrão `3000`. |
| `CORS_ORIGIN` | Origens liberadas, separadas por vírgula. `*` libera todas. |
| `DATABASE_URL` | Conexão com o PostgreSQL. |
| `JWT_SECRET` | Segredo do JWT, utilizado a partir do módulo de Autenticação. |

O arquivo `.env` não deve ser versionado.

---

# Prisma

O Prisma Client é gerado a partir do schema e **não é versionado**. Gerar após clonar o repositório e sempre que o schema mudar:

```powershell
npm run prisma:generate
```

A URL de conexão fica em `prisma.config.ts` e o `PrismaClient` recebe o adaptador `@prisma/adapter-pg`, conforme exigido pelo Prisma 7.

> Não atualizar o Prisma com `npm install prisma@latest`. A tag `latest` do npm aponta para o CLI da Prisma Developer Platform, que é outro produto e não possui os comandos `generate` e `migrate`. O motivo está em [`08-stack-tecnologica.md`](../../frontend/docs/08-stack-tecnologica.md).

Para aplicar migrations quando existirem entidades:

```powershell
npm run prisma:migrate
```

---

# Executar

```powershell
npm run start:dev
```

A API sobe em `http://localhost:3000` com recarga automática ao alterar arquivos.

Verificar:

```powershell
curl http://localhost:3000/health
```

Resposta esperada com banco disponível:

```json
{ "status": "ok", "database": "up", "timestamp": "2026-08-30T01:31:33.796Z" }
```

---

# Scripts disponíveis

| Script | Comando | Finalidade |
| ------ | ------- | ---------- |
| `start:dev` | `nest start --watch` | Desenvolvimento com hot reload |
| `start` | `nest start` | Execução sem watch |
| `start:prod` | `node dist/src/main` | Produção (após `npm run build`) |
| `build` | `nest build` | Compila TypeScript para `dist/` |
| `prisma:generate` | `prisma generate` | Gera o Prisma Client |
| `prisma:migrate` | `prisma migrate dev` | Aplica migrations em desenvolvimento |
| `prisma:studio` | `prisma studio` | Interface visual do banco |

---

# Deploy (Render)

O backend NestJS roda como **Web Service** no Render e o PostgreSQL fica no **Neon**, conforme [`08-stack-tecnologica.md`](../../frontend/docs/08-stack-tecnologica.md).

```text
Root Directory:  backend
Build Command:   npm install && npm run prisma:generate && npm run build
Start Command:   npm run start:prod
```

Definir `DATABASE_URL`, `JWT_SECRET` e `CORS_ORIGIN` nas variáveis do serviço. O `CORS_ORIGIN` deve conter a URL do Site Estático do frontend, já que frontend e backend possuem domínios distintos.
