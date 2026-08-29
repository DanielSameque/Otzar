# MVP

## Objetivo

O MVP (Minimum Viable Product) do Otzar tem como objetivo validar a arquitetura, a experiência do usuário e o fluxo principal de gerenciamento de tarefas e projetos antes da implementação dos módulos mais avançados.

O foco do MVP não é possuir todas as funcionalidades planejadas, mas entregar uma solução simples, estável e utilizável, capaz de demonstrar o principal diferencial do produto: integrar gestão de tarefas, projetos, documentação em Markdown e, futuramente, Inteligência Artificial.

---

# Escopo do MVP

O MVP será composto pelos seguintes módulos:

## 1. Autenticação

Responsável pelo acesso ao sistema.

### Funcionalidades

* Login
* Logout
* Recuperação de senha
* Perfil do usuário

---

## 2. Gestão de Projetos

Os projetos organizam as informações do sistema, mas algumas entidades, como tarefas, podem existir independentemente de um projeto.

### Funcionalidades

* Criar projeto
* Editar projeto
* Arquivar projeto
* Definir membros
* Definir responsáveis

---

## 3. Tarefas

A tarefa é a entidade central do Otzar.

As tarefas podem existir com ou sem projeto e podem ser organizadas posteriormente em Sprints.

### Funcionalidades

* Criar tarefa
* Editar tarefa
* Excluir tarefa
* Priorizar tarefa
* Alterar status
* Definir responsável
* Associar cliente
* Associar categoria
* Adicionar tags
* Criar subtarefas

---

## 4. Backlog

O Backlog é uma visualização das tarefas que não possuem uma Sprint associada.

No MVP, como Sprints ainda não fazem parte do sistema, as tarefas serão apresentadas no Backlog como sua principal visualização de planejamento.

### Funcionalidades

* Visualizar tarefas
* Filtrar tarefas
* Ordenar tarefas
* Priorizar tarefas
* Acessar e editar tarefas

---

## 5. Base de Conhecimento

Cada projeto possuirá uma documentação integrada.

### Funcionalidades

* Criar documentos Markdown
* Editar documentos
* Importar arquivos `.md`
* Visualizar documentação
* Relacionar documentos com tarefas

---

# Fluxo do MVP

```text
Login

↓

Projeto

↓

Tarefas

↓

Backlog

↓

Documentação Markdown
```

Tarefas também podem existir independentemente de um projeto.

---

# Funcionalidades fora do MVP

As funcionalidades abaixo fazem parte do Roadmap, porém não serão implementadas inicialmente.

* Sprints
* Kanban
* Calendário
* Timeline
* Gestão de Tickets
* Dashboard completo
* Time Tracking
* IA
* Integração com WhatsApp
* Automações
* Relatórios avançados

---

# Critérios de sucesso

O MVP será considerado validado quando for possível:

* Criar e gerenciar um projeto;
* Criar e gerenciar tarefas;
* Visualizar e organizar tarefas no Backlog;
* Relacionar documentos Markdown às tarefas;
* Navegar pelo sistema de forma simples e intuitiva.
* Funcionar em diferentes tamanhos de tela/dispositivos.