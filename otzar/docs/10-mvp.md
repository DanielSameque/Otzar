# MVP

## Objetivo

O MVP (Minimum Viable Product) do Otzar tem como objetivo validar a arquitetura, a experiência do usuário e o fluxo principal de gerenciamento de tarefas e projetos antes da implementação dos módulos mais avançados.

O foco do MVP não é possuir todas as funcionalidades planejadas, mas entregar uma solução simples, estável e utilizável, capaz de demonstrar o principal diferencial do produto: integrar gestão de tarefas, projetos, documentação em Markdown e, futuramente, Inteligência Artificial.

---

# Escopo do MVP

O MVP será composto pelos seguintes módulos e recursos:

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

No MVP, o projeto **não** exige cliente. Associação com clientes fica para o módulo Clientes, após o MVP.

### Funcionalidades

* Criar projeto
* Editar projeto
* Arquivar projeto
* Definir membros
* Definir responsáveis

---

## 3. Tarefas

A tarefa é a entidade central do Otzar no desenvolvimento.

As tarefas podem existir com ou sem projeto e podem ser organizadas posteriormente em Sprints.

Associação com cliente, categoria e tags **não faz parte do MVP**. Esses campos entram junto com os módulos Clientes e Categorias e Tags.

### Funcionalidades

* Criar tarefa
* Editar tarefa
* Excluir tarefa
* Priorizar tarefa
* Alterar status
* Definir responsável
* Criar subtarefas

---

## 4. Backlog

O Backlog é a visualização **global e única** das tarefas que não possuem uma Sprint associada.

No MVP, como Sprints ainda não fazem parte do sistema, todas as tarefas aparecem no Backlog. O projeto, quando houver, pode ser usado como filtro, sem criar outro Backlog.

### Funcionalidades

* Visualizar tarefas
* Filtrar tarefas
* Ordenar tarefas
* Priorizar tarefas
* Acessar e editar tarefas

---

## 5. Visualização Kanban

O Kanban **não é um módulo**: é uma visualização das tarefas organizadas por status, acessada dentro do módulo de Tarefas.

É a única visualização entregue no MVP. Calendário, Tabela e Cronograma ficam para o Roadmap.

A mudança entre Backlog, Kanban e outras visualizações futuras não altera os dados da tarefa.

### Funcionalidades

* Visualizar tarefas por status
* Alterar status da tarefa no quadro
* Filtrar e ordenar o quadro

---

## 6. Base de Conhecimento

A Base de Conhecimento é o **único acervo Markdown** do sistema. Documentos não pertencem exclusivamente a um projeto.

### Funcionalidades

* Criar documentos Markdown
* Editar documentos
* Importar arquivos `.md`
* Visualizar documentação
* Relacionar documentos com tarefas (N:N)
* Relacionar documentos com projetos (N:N)

---

# Fluxo do MVP

```text
Login

↓

Projeto (opcional)

↓

Tarefas

↓

Backlog / Kanban

↓

Base de Conhecimento (acervo Markdown único)
```

Tarefas também podem existir independentemente de um projeto. O Backlog é único e global.

---

# Funcionalidades fora do MVP

As funcionalidades abaixo fazem parte do Roadmap, porém não serão implementadas inicialmente.

* Sprints
* Versões de projeto
* Clientes (incluindo vínculo de cliente a projeto, tarefa ou ticket)
* Categorias e Tags
* Comentários
* Anexos
* Visualizações Calendário, Tabela e Cronograma
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

* Criar e gerenciar um projeto sem exigir cliente;
* Criar e gerenciar tarefas sem exigir cliente, categoria ou tags;
* Visualizar e organizar tarefas no Backlog global;
* Visualizar e mover tarefas no Kanban;
* Relacionar documentos Markdown do acervo único às tarefas;
* Navegar pelo sistema de forma simples e intuitiva;
* Funcionar em diferentes tamanhos de tela/dispositivos.
