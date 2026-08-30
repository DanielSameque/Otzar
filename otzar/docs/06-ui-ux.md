# UI/UX

## Princípios

* Interface simples, objetiva e consistente.
* A **Tarefa** deve ser o elemento central da experiência de desenvolvimento.
* O **Ticket** deve ser o elemento central da experiência de suporte.
* Priorizar produtividade e redução de cliques.
* Informações importantes devem estar visíveis sem navegação desnecessária.
* Desktop e web devem ser priorizados, mantendo responsividade para diferentes telas.
* A interface deve seguir padrões consistentes de navegação, ações, formulários e feedback.

## Navegação

A navegação principal deve organizar o sistema por contexto:

* Projetos
* Tarefas
* Backlog (único e global)
* Sprints
* Tickets
* Clientes
* Base de Conhecimento
* Usuários

O Backlog não é por projeto. Filtro por projeto, quando existir, ocorre dentro do mesmo Backlog.

O Kanban não é um item de navegação. Ele é uma visualização, acessada dentro de Tarefas e de Tickets.

## Visualizações

Tarefas e tickets podem ser exibidos como **Kanban**, **Calendário**, **Tabela** ou **Cronograma**.

* A visualização é escolhida dentro da própria tela, por um seletor visível.
* Trocar de visualização não altera os dados nem navega para outro módulo.
* Filtros e ordenação permanecem aplicados ao trocar de visualização.
* A preferência de visualização do usuário deve ser mantida ao retornar à tela.

## Tarefas

A visualização e edição de tarefas devem facilitar:

* Identificação rápida da tarefa.
* Status e prioridade.
* Responsável.
* Projeto, Sprint e Versão.
* Cliente (após o MVP).
* Subtarefas.
* Comentários e anexos (após o MVP).
* Documentos relacionados do acervo único.

## Tickets

A visualização e edição de tickets devem facilitar:

* Identificação rápida do chamado.
* Status e prioridade.
* Responsável e cliente.
* Projeto relacionado.
* Tarefas relacionadas.
* Documentos relacionados do acervo único.

## Base de Conhecimento

A navegação da documentação deve tratar um único acervo. Vínculos com projeto, tarefa ou ticket não criam cópias do documento.

## Consistência

* Utilizar componentes reutilizáveis.
* Manter padrões visuais e comportamentais entre módulos.
* Ações destrutivas devem exigir confirmação.
* Operações devem fornecer feedback ao usuário.
* Estados de carregamento, vazio e erro devem ser tratados.

## Responsividade

A interface deve adaptar-se a diferentes tamanhos de tela sem comprometer as funcionalidades principais.
