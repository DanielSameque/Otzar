# Domain Model

## Visão Geral

O domínio do Otzar é composto por entidades que representam projetos, pessoas, tarefas, documentação e acompanhamento do desenvolvimento.

A **Tarefa** é a entidade central do sistema. Todos os demais módulos existem para organizar, complementar ou relacionar informações às tarefas.

Todos os módulos devem respeitar este modelo.

---

# Relacionamentos

```text
Empresa
    │
    ├── Usuários
    │
    ├── Clientes
    │
    └── Projetos
            │
            ├── Sprints
            │      │
            │      └── Tarefas
            │              │
            │              ├── Responsável (Usuário)
            │              ├── Cliente
            │              ├── Categoria
            │              ├── Tags
            │              ├── Comentários
            │              ├── Anexos
            │              ├── Documentos Markdown
            │              └── Subtarefas
            │
            └── Base de Conhecimento
                    │
                    └── Documentos Markdown
```

---

# Conceito de Backlog

O Backlog **não é uma entidade persistida no banco de dados**.

Ele representa uma visualização de todas as tarefas de um projeto que **não possuem uma Sprint associada**.

Uma tarefa pertence ao Backlog quando:

- ProjetoId está definido;
- SprintId é nulo.

Ao associar uma Sprint à tarefa, ela deixa automaticamente de aparecer no Backlog.

Ao remover a Sprint, ela retorna automaticamente ao Backlog.

---

# Entidades

## Usuário

Representa uma pessoa que utiliza o sistema.

### Atributos

- Id
- Nome
- Email
- Senha
- Foto
- Cargo
- Status
- DataCriação

### Relacionamentos

- Participa de vários projetos.
- Pode ser responsável por várias tarefas.
- Pode criar documentos.
- Pode comentar tarefas.
- Pode ser mencionado em tarefas.

---

## Cliente

Representa um cliente atendido pela empresa.

### Atributos

- Id
- Nome
- NomeFantasia
- Documento
- TipoPessoa
- Email
- Telefone
- Status
- Observações
- DataCriação

### Relacionamentos

- Possui vários projetos.
- Pode estar relacionado a várias tarefas.

---

## Projeto

Representa um produto, sistema ou contrato.

### Atributos

- Id
- Nome
- Descrição
- Cor
- Status
- DataCriação

### Relacionamentos

- Pertence a um cliente.
- Possui membros.
- Possui várias sprints.
- Possui várias tarefas.
- Possui documentação.

---

## Sprint

Representa um ciclo de desenvolvimento.

### Atributos

- Id
- Nome
- Objetivo
- Versão
- Status
- DataInício
- DataFim

### Relacionamentos

- Pertence a um projeto.
- Possui várias tarefas.

---

## Tarefa

Representa qualquer atividade executada pela equipe.

É a entidade central do domínio.

### Atributos

- Id
- Código
- Título
- Descrição
- Versão
- MensagemVersão
- Status
- Prioridade
- ProjetoId
- SprintId (opcional)
- ResponsávelId
- ClienteId (opcional)
- CategoriaId
- ParentTaskId (opcional)
- DataCriação
- DataInício
- DataPrevista
- DataConclusão
- TempoEstimado
- TempoRealizado

### Relacionamentos

- Pertence a um projeto.
- Pode pertencer a uma sprint.
- Pode possuir um cliente específico.
- Pode possuir uma tarefa pai.
- Pode possuir várias subtarefas.
- Possui várias tags.
- Possui vários comentários.
- Possui vários anexos.
- Possui vários documentos relacionados.

---

## Documento

Representa um arquivo Markdown.

### Atributos

- Id
- Título
- Caminho
- Conteúdo
- AutorId
- DataCriação
- ÚltimaAlteração

### Relacionamentos

- Pertence a um projeto.
- Pode estar relacionado a várias tarefas.

---

## Comentário

Representa uma conversa relacionada a uma tarefa.

### Atributos

- Id
- AutorId
- Conteúdo
- DataCriação

---

## Tag

Representa uma classificação personalizada.

### Exemplos

- Bug
- Melhoria
- Fiscal
- Financeiro
- Urgente

Uma tarefa pode possuir várias tags.

---

## Categoria

Representa o tipo de trabalho.

As categorias são personalizáveis por empresa.

### Exemplos

- Desenvolvimento
- Suporte
- Pesquisa
- Documentação
- Testes

---

# Regras do Domínio

## Projeto

- Todo projeto pertence a um cliente.
- Todo projeto possui exatamente uma base de conhecimento.
- Um projeto pode possuir várias sprints.
- Um projeto pode possuir várias tarefas.
- Um projeto pode possuir vários documentos.

---

## Sprint

- Toda sprint pertence a um projeto.
- Uma sprint pode possuir várias tarefas.
- Uma tarefa pertence a no máximo uma sprint.

---

## Tarefa

- Toda tarefa pertence obrigatoriamente a um projeto.
- Uma tarefa pode ou não pertencer a uma sprint.
- Se SprintId for nulo, a tarefa pertence automaticamente ao Backlog.
- O Código da tarefa deve ser gerado automaticamente e ser único dentro do projeto.
- Uma tarefa pode possuir uma tarefa pai.
- Uma tarefa pode possuir várias subtarefas.
- Uma subtarefa também é uma tarefa e segue as mesmas regras da entidade principal.
- Uma tarefa pode possuir vários documentos.
- Uma tarefa pode possuir vários comentários.
- Uma tarefa pode possuir vários anexos.
- Uma tarefa pode possuir várias tags.
- Uma tarefa pode possuir um cliente específico diferente do cliente do projeto.

---

## Documento

- Todo documento pertence a um projeto.
- Um documento pode estar relacionado a várias tarefas.

---

# Princípios do Domínio

- Tudo pertence a um projeto.
- A tarefa é a entidade central do sistema.
- O Backlog é uma visualização, não uma entidade.
- Subtarefas são tarefas.
- A documentação faz parte do projeto.
- O conhecimento deve estar conectado ao trabalho executado.
- Sempre que possível, uma informação deve existir apenas uma vez no domínio.
- A IA utilizará este modelo como fonte de verdade para compreender o funcionamento do Otzar.