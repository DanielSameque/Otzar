# Domain Model

## Visão Geral

O domínio do Otzar é composto por entidades que representam projetos, pessoas, tarefas, tickets, documentação e acompanhamento do desenvolvimento.

A **Tarefa** é a entidade central do sistema de desenvolvimento. O **Ticket** é a entidade central do atendimento ao cliente. Os demais módulos existem para organizar, complementar ou relacionar informações a essas entidades.

O sistema é **single-tenant**: existe uma única organização. Não há entidade Empresa nem isolamento por múltiplas empresas. Usuários, clientes, projetos, tarefas, tickets e documentos compartilham o mesmo espaço global.

Todos os módulos devem respeitar este modelo.

---

# Relacionamentos

```text
Usuários
Clientes
Categorias
Tags

Projetos
    ├── Membros (Usuários)
    ├── Clientes (opcional, N:N)
    ├── Versões
    └── Tarefas (opcional)

Sprints
    └── Tarefas de quaisquer projetos (opcional)

Tarefas
    ├── Sprint (opcional)
    ├── Projeto (opcional)
    ├── Versão (opcional)
    ├── Responsável (Usuário)
    ├── Clientes (opcional, N:N)
    ├── Categoria (opcional)
    ├── Tags (N:N)
    ├── Comentários
    ├── Anexos
    ├── Documentos (N:N)
    ├── Tickets (N:N)
    └── Subtarefas

Tickets
    ├── Responsável (Usuário)
    ├── Cliente (opcional)
    ├── Projeto (opcional)
    ├── Categoria (opcional)
    ├── Tags (N:N)
    ├── Comentários
    ├── Anexos
    ├── Documentos (N:N)
    └── Tarefas (N:N)

Base de Conhecimento
    └── Documentos Markdown
            ├── Projetos (N:N)
            ├── Tarefas (N:N)
            └── Tickets (N:N)
```

Uma **Sprint pode conter tarefas de diferentes projetos**.

Uma **Tarefa pode existir sem projeto**.

O Backlog é **único e global**.

A Base de Conhecimento é **um único acervo Markdown** do sistema, com vínculos N:N.

---

# Conceito de Backlog

O Backlog **não é uma entidade persistida no banco de dados**.

Existe **um único Backlog** no sistema. Ele representa a visualização de **todas** as tarefas que **não possuem uma Sprint associada**, independentemente de projeto.

Uma tarefa pertence ao Backlog quando:

* SprintId é nulo.

O projeto da tarefa, quando existente, pode ser utilizado apenas como **filtro** ou agrupamento. Filtrar por projeto não cria outro Backlog.

Ao associar uma Sprint à tarefa, ela deixa automaticamente de aparecer no Backlog.

Ao remover a Sprint, ela retorna automaticamente ao Backlog.

---

# Conceito de Base de Conhecimento

A Base de Conhecimento **não é uma entidade duplicada por projeto**.

É o módulo de acesso ao **único acervo de documentos Markdown** do sistema.

Um documento:

* Pertence ao acervo global.
* Pode existir sem projeto, tarefa ou ticket.
* Pode estar vinculado a vários projetos, várias tarefas e vários tickets (N:N).

Não existe um segundo repositório de “documentação de tarefa” separado da Base de Conhecimento.

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
* Pode ser responsável por vários tickets.
* Pode criar documentos.
* Pode comentar tarefas e tickets.
* Pode ser mencionado em tarefas e tickets.

---

## Cliente

Representa um cliente atendido pela organização.

A associação de clientes a projetos, tarefas e tickets **não é obrigatória**. O cadastro e os vínculos de cliente entram no produto junto com o módulo Clientes (após o MVP).

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

* Pode estar relacionado a vários projetos (N:N).
* Pode estar relacionado a várias tarefas (N:N).
* Pode estar relacionado a vários tickets.

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

* Pode possuir zero ou mais clientes (N:N). O vínculo com cliente não é obrigatório.
* Possui membros.
* Possui várias versões.
* Pode possuir várias tarefas.
* Pode estar relacionado a vários documentos (N:N).

Um projeto pode possuir tarefas sem Sprint associada. Essas tarefas continuam no Backlog global.

---

## Versão

Representa um ciclo de release ou identificação de evolução de um **projeto**.

Não é um campo livre em Sprint ou Tarefa. Sprint não possui versão própria, porque pode reunir tarefas de projetos diferentes.

### Atributos

* Id
* ProjetoId
* Nome
* Descrição
* Status
* DataCriação
* DataRelease (opcional)

### Relacionamentos

* Pertence a exatamente um projeto.
* Pode estar associada a várias tarefas daquele projeto.

---

## Sprint

Representa um ciclo de desenvolvimento.

### Atributos

* Id
* Nome
* Objetivo
* Status
* DataInício
* DataFim

### Relacionamentos

* Pode conter tarefas de diferentes projetos.
* Possui várias tarefas.
* Uma tarefa pertence a no máximo uma Sprint.
* Não possui Versão.

---

## Tarefa

Representa qualquer atividade executada pela equipe de desenvolvimento.

É a entidade central do domínio de desenvolvimento.

### Atributos

* Id
* Código
* Título
* Descrição
* VersaoId (opcional)
* MensagemVersão (opcional)
* Status
* Prioridade
* ProjetoId (opcional)
* SprintId (opcional)
* ResponsávelId
* CategoriaId (opcional)
* ParentTaskId (opcional)
* DataCriação
* DataInício
* DataPrevista
* DataConclusão
* TempoEstimado
* TempoRealizado

Categoria, tags e clientes existem no modelo, mas o vínculo no MVP é adiado junto com os módulos correspondentes.

### Relacionamentos

* Pode pertencer a um projeto.
* Pode pertencer a uma Sprint.
* Pode estar associada a uma Versão do seu projeto.
* Pode possuir zero ou mais clientes (N:N).
* Pode possuir uma tarefa pai.
* Pode possuir várias subtarefas.
* Pode possuir várias tags (N:N).
* Possui vários comentários.
* Possui vários anexos.
* Pode estar relacionada a vários documentos (N:N).
* Pode estar relacionada a vários tickets (N:N).

Quando `VersaoId` estiver preenchido, a versão deve pertencer ao mesmo projeto da tarefa. Tarefa sem projeto não pode ter versão.

`MensagemVersão` registra o texto de changelog da tarefa naquela versão.

---

## Ticket

Representa um chamado de suporte ou atendimento ao cliente.

É entidade própria, distinta de Tarefa. Não deve ser modelado apenas como tarefa com categoria “Suporte”.

### Atributos

* Id
* Código
* Título
* Descrição
* Status
* Prioridade
* ClienteId (opcional)
* ProjetoId (opcional)
* ResponsávelId
* CategoriaId (opcional)
* DataCriação
* DataInício
* DataPrevista
* DataConclusão
* TempoGasto

### Relacionamentos

* Pode possuir um cliente.
* Pode pertencer a um projeto.
* Pode possuir um responsável.
* Pode possuir várias tags (N:N).
* Possui vários comentários.
* Possui vários anexos.
* Pode estar relacionado a vários documentos (N:N).
* Pode estar relacionado a várias tarefas (N:N).

### Código do Ticket

* O código do ticket deve ser gerado automaticamente.
* O código deve ser único em todo o sistema.
* O código não deve ser alterado ao longo do ciclo de vida do ticket.

---

## Documento

Representa um arquivo Markdown do acervo único da Base de Conhecimento.

### Atributos

* Id
* Título
* Caminho
* Conteúdo
* AutorId
* DataCriação
* ÚltimaAlteração
* Tags

### Relacionamentos

* Pode estar relacionado a vários projetos (N:N).
* Pode estar relacionado a várias tarefas (N:N).
* Pode estar relacionado a vários tickets (N:N).
* Não “pertence” exclusivamente a um projeto ou a uma tarefa.

---

## Comentário

Representa uma conversa relacionada a uma tarefa ou a um ticket.

### Atributos

* Id
* AutorId
* Conteúdo
* DataCriação
* TarefaId (opcional)
* TicketId (opcional)

Um comentário pertence a uma tarefa **ou** a um ticket.

---

## Tag

Representa uma classificação personalizada, global no sistema.

### Exemplos

* Bug
* Melhoria
* Fiscal
* Financeiro
* Urgente

Tarefas, tickets e documentos podem possuir várias tags.

---

## Categoria

Representa o tipo de trabalho, global no sistema.

As categorias são personalizáveis.

### Exemplos

* Desenvolvimento
* Suporte
* Pesquisa
* Documentação
* Testes

Categoria **não substitui** o módulo de Tickets. “Suporte” como categoria classifica trabalho; o atendimento ao cliente usa a entidade Ticket.

---

# Regras do Domínio

## Organização

* O Otzar atende uma única organização. Não há entidade Empresa nem partição de dados por empresa.
* Identificadores de negócio (código de tarefa, código de ticket) são únicos em todo o sistema.

## Projeto

* Um projeto pode possuir zero ou mais clientes. Cliente não é obrigatório.
* Um projeto pode possuir várias tarefas.
* Um projeto pode estar relacionado a vários documentos (N:N).
* Um projeto possui várias versões.
* Um projeto não possui uma Base de Conhecimento exclusiva.

## Versão

* Toda versão pertence a exatamente um projeto.
* Uma tarefa só pode ser associada a uma versão do mesmo projeto.
* Sprint não possui versão.

## Sprint

* Uma Sprint pode conter tarefas de diferentes projetos.
* Uma Sprint pode possuir várias tarefas.
* Uma tarefa pertence a no máximo uma Sprint.

## Tarefa

* Uma tarefa pode ou não pertencer a um projeto.
* Uma tarefa pode ou não pertencer a uma Sprint.
* Se SprintId for nulo, a tarefa pertence automaticamente ao Backlog global.
* Uma tarefa pode possuir uma tarefa pai.
* Uma tarefa pode possuir várias subtarefas.
* Uma subtarefa também é uma tarefa e segue as mesmas regras da entidade principal.
* Uma tarefa pode estar relacionada a vários documentos (N:N).
* Uma tarefa pode possuir vários comentários.
* Uma tarefa pode possuir vários anexos.
* Uma tarefa pode possuir várias tags.
* Uma tarefa pode possuir zero ou mais clientes.
* Uma tarefa pode estar relacionada a vários tickets.

### Código da Tarefa

* O código da tarefa deve ser gerado automaticamente.
* O código deve ser único em todo o sistema, independentemente de a tarefa possuir ou não um projeto.
* O código não deve ser alterado caso a tarefa seja vinculada ou desvinculada de um projeto.
* O código deve identificar a tarefa de forma única durante todo o seu ciclo de vida.

## Ticket

* Ticket não é uma Tarefa.
* Um ticket pode existir com ou sem projeto e com ou sem cliente.
* Um ticket pode estar relacionado a várias tarefas e a vários documentos.

## Documento

* Existe um único acervo Markdown.
* Um documento pode existir sem vínculos.
* Os vínculos com projetos, tarefas e tickets são N:N.
* Relacionar um documento a uma tarefa ou ticket não cria uma cópia do documento.

## Backlog

* Existe um único Backlog, global.
* Filtros (projeto, responsável, status e outros) não fragmentam o Backlog em instâncias distintas.

---

# Princípios do Domínio

* A tarefa é a entidade central do desenvolvimento.
* O ticket é a entidade central do suporte.
* Uma tarefa pode existir independentemente de um projeto.
* O Backlog é uma visualização global, não uma entidade.
* Subtarefas são tarefas.
* A documentação é um acervo único, conectado ao trabalho por vínculos N:N.
* Sempre que possível, uma informação deve existir apenas uma vez no domínio.
* O sistema não modela múltiplas empresas.
* A IA utilizará este modelo como fonte de verdade para compreender o funcionamento do Otzar.
