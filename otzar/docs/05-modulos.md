# Model Standards

## Objetivo

Este documento define os padrões obrigatórios para todas as entidades do domínio do Otzar.

Seu objetivo é manter consistência entre banco de dados, backend, frontend e documentação, servindo como fonte de verdade para o desenvolvimento do sistema.

Toda nova entidade criada deverá seguir estes padrões.

---

# Convenções Gerais

## Idioma

Todo o código-fonte será escrito em **inglês**.

A interface do usuário será em português (inicialmente).

Exemplos:

| Banco / Código | Interface |
|----------------|----------|
| Project | Projeto |
| Task | Tarefa |
| Sprint | Sprint |
| Customer | Cliente |
| User | Usuário |

---

## Convenção de nomes

### Classes

Utilizar **PascalCase**.

Exemplos:

```text
Project
Task
Sprint
Customer
User
KnowledgeDocument
```

---

### Propriedades

Utilizar **PascalCase**.

Exemplo

```text
Name
Description
CreatedAt
UpdatedAt
ProjectId
AssignedUserId
```

---

### Banco de Dados

Utilizar **PascalCase** para tabelas e colunas.

Exemplo

```text
Project

Id
Name
CreatedAt
```

---

## Chaves Primárias

Toda entidade possui:

```text
Id
```

Tipo:

```text
Guid (UUID)
```

Nunca utilizar chaves compostas.

---

## Chaves Estrangeiras

Sempre utilizar o padrão:

```text
<EntityName>Id
```

Exemplos:

```text
ProjectId
SprintId
CustomerId
AssignedUserId
CategoryId
ParentTaskId
AuthorId
```

Nunca utilizar apenas:

```text
Project
Customer
User
```

quando representar uma chave estrangeira.

---

# Auditoria

Toda entidade persistida deverá possuir os seguintes campos.

```text
CreatedAt
CreatedById

UpdatedAt
UpdatedById

DeletedAt (opcional)

DeletedById (opcional)
```

---

# Exclusão

Nunca remover registros fisicamente.

Utilizar Soft Delete.

```text
DeletedAt
DeletedById
```

Registros excluídos não devem aparecer nas consultas comuns.

---

# Status

Sempre utilizar Enum.

Nunca armazenar status como texto livre.

Exemplo

```text
Draft

Open

InProgress

Blocked

Completed

Cancelled

Archived
```

Cada entidade poderá possuir seu próprio enum.

---

# Prioridade

Utilizar Enum.

```text
Low

Medium

High

Critical
```

---

# Ordenação

Sempre que uma entidade puder ser reorganizada visualmente, utilizar:

```text
SortOrder
```

Exemplos

- Kanban
- Categorias
- Tags
- Colunas

---

# Código Público

Entidades importantes devem possuir um código amigável.

Nunca expor o Guid para o usuário.

Exemplo

```text
OTZ-145

ERP-58

SUP-103
```

Inicialmente apenas:

- Task
- Sprint
- Ticket (futuro)

---

# Datas

Sempre utilizar UTC.

Campos padrão:

```text
CreatedAt

UpdatedAt

DeletedAt
```

Campos específicos da entidade:

```text
StartDate

DueDate

CompletedAt
```

---

# Tempo

Nunca armazenar tempo formatado.

Sempre armazenar em minutos.

Exemplo

```text
EstimatedMinutes

WorkedMinutes
```

A interface será responsável pela formatação.

---

# Versionamento

Sempre utilizar:

```text
Version
```

Exemplo

```text
26.03

26.04

27.00
```

---

# Anexos

Arquivos nunca serão armazenados diretamente no banco.

Apenas metadados.

Exemplo

```text
FileName

Extension

Size

StoragePath

MimeType
```

---

# Markdown

Documentos sempre utilizarão Markdown.

Extensão:

```text
.md
```

O conteúdo será armazenado em UTF-8.

---

# Relacionamentos

Sempre representar relacionamentos através de objetos.

Exemplo

```text
Task

├── Project
├── Sprint
├── Customer
├── AssignedUser
├── Tags
└── Documents
```

---

# Subtarefas

Subtarefas são tarefas.

Nunca criar uma entidade separada.

Utilizar:

```text
ParentTaskId
```

Quando nulo, representa uma tarefa principal.

---

# Backlog

Backlog não possui tabela.

Uma tarefa pertence ao Backlog quando:

```text
SprintId == null
```

---

# Documentação

Toda entidade deverá possuir documentação contendo:

- Objetivo
- Responsabilidades
- Relacionamentos
- Regras de negócio

---

# Padrões para IA

Ao gerar código, a IA deverá seguir obrigatoriamente as seguintes regras:

- Nunca criar entidades fora do Domain Model.
- Nunca criar propriedades duplicadas.
- Sempre utilizar relacionamentos.
- Nunca armazenar textos quando existir uma entidade correspondente.
- Nunca criar lógica de negócio na interface.
- Reutilizar componentes sempre que possível.
- Respeitar todos os padrões definidos neste documento.
- Em caso de conflito entre código e documentação, a documentação é a fonte de verdade.

---

# Evolução

Novos padrões poderão ser adicionados neste documento.

Nenhum padrão existente poderá ser alterado sem atualizar toda a documentação do projeto.