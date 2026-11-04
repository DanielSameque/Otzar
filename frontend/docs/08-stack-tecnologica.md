# Stack Tecnológica

## Visão Geral

O Otzar utiliza uma arquitetura multiplataforma baseada em **Flutter no frontend**, **NestJS no backend**, **Prisma como ORM** e **SQL Server 2025 como banco de dados**.

Para hospedagem, o **Flutter Web** e o **backend NestJS** serão executados no **Render**, e o banco de dados será hospedado no **Azure SQL Database**, a versão gerenciada do SQL Server na Microsoft Azure.

O Render concentra as duas aplicações no mesmo painel: o frontend como **Site Estático** e o backend como **Web Service**.

```mermaid
flowchart TD
    A["Flutter Web"]
    M["Flutter Mobile"]
    B["Render<br/>Site Estático: build/web"]
    C["Render<br/>Web Service: NestJS"]
    D["Prisma"]
    E["Azure SQL Database<br/>SQL Server"]

    A --> B
    B -->|"HTTPS / REST"| C
    M -->|"HTTPS / REST"| C
    C --> D
    D --> E
```

### Arquitetura

```text
Flutter Web
  │
  └── Render (Site Estático)
        │
        │ HTTPS / REST
        ▼
      Render (Web Service)
        │
        └── NestJS
              │
              └── Prisma
                    │
                    ▼
                Azure SQL Database (SQL Server)
```

Os aplicativos móveis Flutter não são hospedados: consomem diretamente a mesma API do NestJS via HTTPS.

---

# 🎨 Frontend — Flutter

**Tecnologia:** Flutter
**Linguagem:** Dart

O Flutter será utilizado para desenvolver a interface do Otzar para **Web e dispositivos móveis a partir de uma única base de código**.

### Motivos da escolha

* Código compartilhado entre Web, Android e iOS.
* Desenvolvimento rápido de interfaces.
* Componentes visuais nativos do Flutter.
* Bom desempenho.
* Ecossistema consolidado.
* Integração direta com Dart.
* Permite manter uma única arquitetura de frontend para diferentes plataformas.

A utilização de uma única base de código reduz a duplicação de funcionalidades e facilita a manutenção do sistema.

---

# ⚙️ Backend — NestJS

**Tecnologia:** NestJS
**Linguagem:** TypeScript
**Runtime:** Node.js

O NestJS será responsável pelo backend do Otzar e fornecerá a API REST consumida pelo Flutter.

### Responsabilidades

* API REST;
* Autenticação e autorização;
* Regras de negócio;
* Validação de dados;
* Controle de acesso;
* Integração com banco de dados;
* Integração com serviços externos;
* Processamentos no servidor.

### Motivos da escolha

* Arquitetura modular.
* Excelente suporte a TypeScript.
* Estrutura adequada para aplicações de médio e grande porte.
* Injeção de dependência.
* Facilidade para separar Controllers, Services e outras responsabilidades.
* Bom suporte para APIs REST.
* Ecossistema consolidado no Node.js.

A arquitetura do backend deverá priorizar separação de responsabilidades e facilidade de manutenção.

---

# 🗄️ ORM — Prisma

**Tecnologia:** Prisma ORM

O Prisma será utilizado como camada de acesso ao banco de dados entre o NestJS e o SQL Server.

```text
NestJS
   │
   ▼
Prisma
   │
   ▼
SQL Server 2025
```

### Responsabilidades

* Acesso ao banco de dados;
* Consultas;
* Inserções;
* Atualizações;
* Exclusões;
* Tipagem das entidades;
* Migrations;
* Geração do Prisma Client.

### Motivos da escolha

* Integração com TypeScript.
* Tipagem forte.
* Autocomplete durante o desenvolvimento.
* Redução de erros em consultas.
* Sistema de migrations.
* Suporte oficial ao SQL Server (provider `sqlserver`).
* Boa integração com NestJS.

O Prisma deverá permanecer concentrado na camada de acesso a dados, evitando que Controllers ou outras camadas da aplicação acessem o banco diretamente.

### Versão adotada

O Otzar utiliza o **Prisma ORM 7**, versão mais recente do ORM. Os três pacotes são fixados em `^7.10.0`:

```text
prisma                  # CLI do ORM
@prisma/client          # runtime consultado pela aplicação
@prisma/adapter-mssql   # driver adapter do SQL Server (usa o driver mssql/tedious)
```

A partir da versão 7, o ORM exige a URL de conexão em `prisma.config.ts` e um driver adapter passado ao `PrismaClient`. A `url` deixou de ser aceita no bloco `datasource` do schema.

O `@prisma/adapter-mssql` aceita a mesma `DATABASE_URL` no formato `sqlserver://` usada pelo CLI do Prisma, então migrations e runtime compartilham uma única variável.

### Por que não a versão 8

O pacote `prisma@8` **não é uma versão mais nova do ORM**: é o CLI da **Prisma Developer Platform**, um produto distinto, voltado a autenticação, projetos, buckets, deploy e ao banco gerenciado Prisma Postgres. Nele o ORM passa a ser o subcomando `prisma orm`, que inicializa projetos no modelo "Prisma Next".

A versão 8 não foi adotada porque:

* Não existe `@prisma/client` nem `@prisma/adapter-mssql` na versão 8. O runtime consumido pela aplicação só existe até a 7.10.0.
* O CLI 8 não expõe `generate` nem `migrate` no nível principal, quebrando os scripts `prisma:generate` e `prisma:migrate` do backend.
* A versão publicada é *release candidate*, não estável.
* A plataforma é orientada ao Prisma Postgres, enquanto o Otzar usa **SQL Server** hospedado no **Azure SQL Database** e a aplicação no **Render**.

O CLI 8 é publicado sob a tag `latest` do npm. Por isso os pacotes são fixados explicitamente em `^7.10.0`: um `npm install` sem restrição instala o CLI da plataforma e quebra a geração do Prisma Client.

Essa decisão deve ser reavaliada quando o `@prisma/client` na versão 8 for publicado como estável.

---

# 🗃️ Banco de Dados — SQL Server 2025

**Tecnologia:** Microsoft SQL Server 2025

O SQL Server 2025 será o banco de dados relacional do Otzar.

### Motivos da escolha

* Banco de dados relacional maduro e consolidado.
* Excelente suporte a relacionamentos.
* Integridade referencial.
* Transações.
* Índices e consultas avançadas.
* Ferramental consolidado (SQL Server Management Studio, Azure Data Studio, `sqlcmd`).
* Compatibilidade com Prisma (provider `sqlserver`).
* Mesmo motor em desenvolvimento (container Docker) e produção (Azure SQL Database).

### Edições utilizadas

| Ambiente | Edição | Observação |
| -------- | ------ | ---------- |
| Desenvolvimento local | **Developer** (imagem `mcr.microsoft.com/mssql/server:2025-latest`) | Gratuita, todos os recursos, uso restrito a desenvolvimento e testes. |
| Produção | **Azure SQL Database** | Serviço gerenciado, sempre na versão mais recente do motor do SQL Server. |

### Particularidades em relação a outros bancos

* O SQL Server **não cria o banco automaticamente** a partir de variáveis de ambiente do container. O `docker-compose.yml` do backend inclui um serviço de inicialização que cria o banco `otzar`.
* A conexão usa TLS. Em desenvolvimento, o container usa certificado autoassinado, por isso a `DATABASE_URL` local inclui `trustServerCertificate=true`. Em produção esse parâmetro deve ser `false`.
* O schema padrão é `dbo`.

O SQL Server será utilizado para armazenar os dados persistentes do sistema, incluindo usuários, projetos, clientes, tarefas, sprints e demais entidades do Otzar.

---

# 🌐 Hospedagem do Frontend Web — Render (Site Estático)

**Plataforma:** Render
**Tipo de serviço:** Site Estático

O build do Flutter Web (`build/web`) será publicado como **Site Estático no Render**, no mesmo painel do backend.

```text
Internet
   │
   ▼
Render — Site Estático
   │
   └── build/web (Flutter Web)
```

### Motivos da escolha

* Mesma plataforma do backend, reduzindo o número de contas e painéis.
* Deploy integrado ao Git.
* HTTPS e domínio próprio.
* Site estático gratuito, adequado ao MVP.
* Não exige administração de servidor web (NGINX, Apache ou similares).

### Configuração

O ambiente de build do Render **não possui o SDK do Flutter pré-instalado**. Por isso, o `Build Command` instala o SDK antes de gerar o build.

* **Build Command:** `./scripts/render-build.sh`
* **Publish Directory:** `frontend/build/web`
* **Rewrite (SPA):** `/*` → `/index.html`

O script `scripts/render-build.sh`, versionado no repositório, baixa o canal `stable` do Flutter e executa o build. O passo a passo e o conteúdo do script estão em `12-ambiente-de-desenvolvimento.md`.

Essa opção foi escolhida em vez de gerar o build localmente porque mantém o deploy automático a partir do Git e evita versionar a pasta `build/web`.

O Site Estático serve apenas arquivos. Nenhuma regra de negócio ou credencial de banco deve existir nesta camada.

---

# ☁️ Hospedagem do Backend — Render (Web Service)

**Plataforma:** Render
**Tipo de serviço:** Web Service

O Render será utilizado para hospedar o backend NestJS.

```text
Internet
   │
   ▼
Render — Web Service
   │
   └── NestJS
```

### Motivos da escolha

* Configuração simplificada.
* Deploy integrado ao Git.
* Suporte a aplicações Node.js/NestJS.
* HTTPS.
* Variáveis de ambiente.
* Logs da aplicação.
* Health checks.
* Possibilidade de escalar posteriormente.
* Permite começar com baixo custo.

A utilização do Render reduz a necessidade de administrar manualmente servidores e infraestrutura.

---

# 🗃️ Hospedagem do Banco — Azure SQL Database

**Plataforma:** Microsoft Azure
**Serviço:** Azure SQL Database (camada *serverless*)
**Banco:** SQL Server

O SQL Server será hospedado no Azure SQL Database.

```text
NestJS
   │
 Prisma
   │
   ▼
Azure SQL Database
   │
SQL Server
```

### Motivos da escolha

* SQL Server totalmente gerenciado, com o mesmo motor usado no desenvolvimento local.
* Oferta gratuita do Azure SQL Database, adequada para desenvolvimento e MVP.
* Camada *serverless* com pausa automática quando ocioso, reduzindo custo.
* Não exige administração manual do servidor de banco.
* Backups e recursos de gerenciamento oferecidos pela plataforma.
* Integração simples através da `DATABASE_URL`.
* Compatibilidade com Prisma.

### Configuração

* Cadastrar no firewall do servidor Azure SQL os IPs de saída do Web Service do Render. A opção "Permitir que serviços e recursos do Azure acessem este servidor" vale apenas para recursos dentro do Azure e não libera o Render.
* `DATABASE_URL` no formato:

```text
sqlserver://<servidor>.database.windows.net:1433;database=otzar;user=<usuario>;password=<senha>;encrypt=true;trustServerCertificate=false
```

O Azure SQL Database foi escolhido inicialmente visando **reduzir o custo de desenvolvimento e validação do MVP**, mantendo SQL Server como banco principal.

---

# 🔐 Comunicação

A comunicação entre Flutter e backend será realizada através de **HTTPS**.

```text
Flutter (Site Estático no Render / App Mobile)
   │
   │ HTTPS
   ▼
NestJS (Web Service no Render)
   │
   │ Prisma
   ▼
SQL Server (Azure SQL Database)
```

O Site Estático e o Web Service são serviços distintos, com domínios distintos. O backend deve permitir a origem do frontend por meio de configuração de CORS.

O frontend não deverá acessar diretamente o banco de dados.

Toda operação que envolva dados persistentes deverá passar pela API do NestJS.

---

# 🔑 Variáveis de Ambiente

Informações sensíveis ou específicas do ambiente não devem ser armazenadas diretamente no código-fonte.

Exemplos:

```env
DATABASE_URL=
JWT_SECRET=
API_URL=
```

As variáveis deverão ser configuradas de acordo com o ambiente:

```text
Desenvolvimento
        ↓
Homologação
        ↓
Produção
```

Credenciais, tokens, senhas e chaves privadas **não devem ser versionados no Git**.

---

# 📦 Resumo da Stack

| Camada             | Tecnologia       | Função                               |
| ------------------ | ---------------- | ------------------------------------ |
| Frontend           | **Flutter**      | Interface Web e Mobile               |
| Linguagem Frontend | **Dart**         | Desenvolvimento Flutter              |
| Comunicação        | **HTTPS / REST** | Comunicação entre frontend e backend |
| Backend            | **NestJS**       | API e regras de negócio              |
| Linguagem Backend  | **TypeScript**   | Desenvolvimento do backend           |
| ORM                | **Prisma**       | Acesso ao banco e migrations         |
| Banco de dados     | **SQL Server 2025** | Persistência dos dados            |
| Hospedagem Frontend| **Render**       | Site Estático com o `build/web`      |
| Hospedagem Backend | **Render**       | Web Service com o NestJS             |
| Hospedagem Banco   | **Azure SQL Database** | SQL Server gerenciado          |

---

# 🏗️ Arquitetura Final

```mermaid
flowchart LR
    A["Flutter Web"]
    M["Flutter Mobile"]
    B["Render<br/>Site Estático"]
    C["Render<br/>Web Service"]
    D["NestJS"]
    E["Prisma"]
    F["Azure SQL Database<br/>SQL Server"]

    A --> B
    B -->|"HTTPS / REST"| C
    M -->|"HTTPS / REST"| C
    C --> D
    D --> E
    E --> F
```

### Responsabilidade de cada camada

```text
Flutter
→ Interface e experiência do usuário

HTTPS / REST
→ Comunicação entre frontend e backend

NestJS
→ API, autenticação e regras de negócio

Prisma
→ Acesso e gerenciamento das operações no banco

SQL Server 2025
→ Persistência dos dados

Render — Site Estático
→ Hospedagem do Flutter Web (build/web)

Render — Web Service
→ Hospedagem e execução do backend

Azure SQL Database
→ Hospedagem e gerenciamento do SQL Server
```

---

# 💰 Estratégia Inicial de Custos

A infraestrutura foi escolhida inicialmente visando permitir o desenvolvimento e validação do MVP com **baixo custo, priorizando os planos gratuitos disponíveis**.

```text
Render — Site Estático (Flutter Web)
   ↓
Render — Web Service (NestJS)
   ↓
Prisma — ORM
   ↓
Azure SQL Database — SQL Server
```

Nos planos gratuitos, o Web Service do Render hiberna após período de inatividade e o Azure SQL Database *serverless* é pausado quando ocioso. A primeira requisição após a ociosidade é mais lenta. O Site Estático não hiberna.

Quando o tempo de resposta passar a atrapalhar o uso diário, o primeiro investimento deve ser um plano pago do **Web Service**, sem alterar frontend, ORM ou banco.

Conforme o Otzar crescer, os serviços poderão ser migrados ou atualizados individualmente sem necessidade de alterar a arquitetura principal da aplicação.

A separação entre **NestJS, Prisma e SQL Server** também permite trocar o provedor de hospedagem do banco ou do backend sem alterar a responsabilidade dessas camadas.
