# MVP

## Objetivo

O MVP (Minimum Viable Product) do Otzar tem como objetivo validar a arquitetura, a experiência do usuário e o fluxo completo de gerenciamento de projetos antes da implementação dos módulos mais avançados.

O foco do MVP não é possuir todas as funcionalidades planejadas, mas entregar uma solução simples, estável e utilizável, capaz de demonstrar o principal diferencial do produto: integrar gestão de projetos, documentação em Markdown e, futuramente, Inteligência Artificial.

---

# Escopo do MVP

O MVP será composto pelos seguintes módulos:

## 1. Autenticação

Responsável pelo acesso ao sistema.

### Funcionalidades

- Login
- Logout
- Recuperação de senha
- Perfil do usuário

---

## 2. Gestão de Projetos

Cada informação do sistema pertence a um projeto.

### Funcionalidades

- Criar projeto
- Editar projeto
- Arquivar projeto
- Definir membros
- Definir responsáveis

---

## 3. Backlog

O backlog será o local onde todas as tarefas serão criadas.

As tarefas permanecerão no backlog até serem planejadas para uma Sprint.

### Funcionalidades

- Criar tarefa
- Editar tarefa
- Excluir tarefa
- Priorizar tarefa
- Organizar tarefas

---

## 4. Kanban

Após uma tarefa ser inserida em uma Sprint, ela será exibida no Kanban.

### Funcionalidades

- Arrastar cartões
- Alterar status
- Atualização em tempo real
- Filtros

---

## 5. Base de Conhecimento

Cada projeto possuirá uma documentação integrada.

### Funcionalidades

- Criar documentos Markdown
- Editar documentos
- Importar arquivos .md
- Visualizar documentação
- Relacionar documentos com tarefas

---

# Fluxo do MVP

```text
Login

↓

Projeto

↓

Backlog

↓

Tarefa

↓

Documento Markdown

↓

Kanban
```

---

# Funcionalidades fora do MVP

As funcionalidades abaixo fazem parte do roadmap, porém não serão implementadas inicialmente.

- Sprint
- Calendário
- Timeline
- Gestão de Tickets
- Dashboard completo
- Time Tracking
- IA
- Integração com WhatsApp
- Automações
- Relatórios avançados

---

# Critérios de sucesso

O MVP será considerado validado quando for possível:

- Criar um projeto;
- Criar tarefas no backlog;
- Relacionar documentos Markdown às tarefas;
- Visualizar as tarefas no Kanban;
- Navegar pelo sistema de forma simples e intuitiva.