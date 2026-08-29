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
    ├── Projetos
    │      │
    │      ├── Base de Conhecimento
    │      │       └── Documentos Markdown
    │      │
    │      └── Documentos Markdown
    │
    └── Categorias
           │
           └── Tarefas
                  │
                  ├── Sprint (opcional)
                  ├── Responsável (Usuário)
                  ├── Clientes
                  ├── Categoria
                  ├── Tags
                  ├── Comentários
                  ├── Anexos
                  ├── Documentos Markdown
                  └── Subtarefas
```

Uma **Sprint pode conter tarefas de diferentes projetos**.

Uma **Tarefa pode existir sem projeto**.

---

# Conceito de Backlog

O Backlog **não é uma entidade persistida no banco de dados**.

Ele representa uma visualização das tarefas que **não possuem uma Sprint associada**.

Uma tarefa pertence ao Backlog quando:

* SprintId é nulo.

O projeto da tarefa, quando existente, pode ser utilizado para filtrar ou organizar o Backlog.

Ao associar uma Sprint à tarefa, ela deixa automaticamente de aparecer no Backlog.

Ao remover a Sprint, ela retorna automaticamente ao Backlog.

---

# Entidades

## Usuário

Representa uma pessoa que utiliza o sistema.

### Atributos

* Id
* Nome
* Email
* Senha
* Foto
* Cargo
* Status
* DataCriação

### Relacionamentos

* Participa de vários projetos.
* Pode ser responsável por várias tarefas.
* Pode criar documentos.
* Pode comentar tarefas.
* Pode ser mencionado em tarefas.

---

## Cliente

Representa um cliente atendido pela empresa.

### Atributos

* Id
* Nome
* NomeFantasia
* Documento
* TipoPessoa
* Email
* Telefone
* Status
* Observações
* DataCriação

### Relacionamentos

* Possui vários projetos.
* Pode estar relacionado a várias tarefas.

---

## Projeto

Representa um produto, sistema ou contrato.

### Atributos

* Id
* Nome
* Descrição
* Cor
* Status
* DataCriação

### Relacionamentos

* Pertence a um ou mais cliente.
* Possui membros.
* Possui várias tarefas.
* Possui documentação.
* Possui uma única base de conhecimento.

Um projeto pode possuir tarefas sem Sprint associada.

---

## Sprint

Representa um ciclo de desenvolvimento.

### Atributos

* Id
* Nome
* Objetivo
* Versão
* Status
* DataInício
* DataFim

### Relacionamentos

* Pode conter tarefas de diferentes projetos.
* Possui várias tarefas.
* Uma tarefa pertence a no máximo uma Sprint.

---

## Tarefa

Representa qualquer atividade executada pela equipe.

É a entidade central do domínio.

### Atributos

* Id
* Código
* Título
* Descrição
* Versão
* MensagemVersão
* Status
* Prioridade
* ProjetoId (opcional)
* SprintId (opcional)
* ResponsávelId
* CategoriaId
* ParentTaskId (opcional)
* DataCriação
* DataInício
* DataPrevista
* DataConclusão
* TempoEstimado
* TempoRealizado

### Relacionamentos

* Pode pertencer a um projeto.
* Pode pertencer a uma Sprint.
* Pode possuir um ou mais clientes.
* Pode possuir uma tarefa pai.
* Pode possuir várias subtarefas.
* Possui várias tags.
* Possui vários comentários.
* Possui vários anexos.
* Pode possuir vários documentos relacionados.

---

## Documento

Representa um arquivo Markdown.

### Atributos

* Id
* Título
* Caminho
* Conteúdo
* AutorId
* DataCriação
* ÚltimaAlteração
* tags

### Relacionamentos

* Pode pertencer a um projeto.
* Pode pertencer a uma tarefa.
* Pode estar relacionado a várias tarefas.

---

## Comentário

Representa uma conversa relacionada a uma tarefa.

### Atributos

* Id
* AutorId
* Conteúdo
* DataCriação

---

## Tag

Representa uma classificação personalizada.

### Exemplos

* Bug
* Melhoria
* Fiscal
* Financeiro
* Urgente

Uma tarefa pode possuir várias tags.

---

## Categoria

Representa o tipo de trabalho.

As categorias são personalizáveis por empresa.

### Exemplos

* Desenvolvimento
* Suporte
* Pesquisa
* Documentação
* Testes

---

# Regras do Domínio

## Projeto

* Todo projeto pertence a um ou mais cliente.
* Todo projeto possui exatamente uma base de conhecimento.
* Um projeto pode possuir várias tarefas.
* Um projeto pode possuir vários documentos.
* Um projeto possui varias versões

---

## Sprint

* Uma Sprint pode conter tarefas de diferentes projetos.
* Uma Sprint pode possuir várias tarefas.
* Uma tarefa pertence a no máximo uma Sprint.

---

## Tarefa

* Uma tarefa pode ou não pertencer a um projeto.
* Uma tarefa pode ou não pertencer a uma Sprint.
* Se SprintId for nulo, a tarefa pertence automaticamente ao Backlog.
* Uma tarefa pode possuir uma tarefa pai.
* Uma tarefa pode possuir várias subtarefas.
* Uma subtarefa também é uma tarefa e segue as mesmas regras da entidade principal.
* Uma tarefa pode possuir vários documentos.
* Uma tarefa pode possuir vários comentários.
* Uma tarefa pode possuir vários anexos.
* Uma tarefa pode possuir várias tags.
* Uma tarefa pode possuir um ou mais clientes.

### Código da Tarefa

* O código da tarefa deve ser gerado automaticamente.
* O código deve ser único em todo o sistema, independentemente de a tarefa possuir ou não um projeto.
* O código não deve ser alterado caso a tarefa seja vinculada ou desvinculada de um projeto.
* O código deve identificar a tarefa de forma única durante todo o seu ciclo de vida.

---

## Documento

* Um documento pode pertencer a um projeto.
* Um documento pode pertencer a uma tarefa.
* Um documento pode estar relacionado a várias tarefas.

---

# Princípios do Domínio

* A tarefa é a entidade central do sistema.
* Uma tarefa pode existir independentemente de um projeto.
* O Backlog é uma visualização, não uma entidade.
* Subtarefas são tarefas.
* A documentação faz parte do projeto e das tarefas.
* O conhecimento deve estar conectado ao trabalho executado.
* Sempre que possível, uma informação deve existir apenas uma vez no domínio.
* A IA utilizará este modelo como fonte de verdade para compreender o funcionamento do Otzar.
