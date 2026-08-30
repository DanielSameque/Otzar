# Módulos

O Otzar é dividido em módulos funcionais. A **Tarefa** é a entidade central do desenvolvimento. O **Ticket** é a entidade central do suporte.

## Projetos

Gerenciamento de projetos, membros, configurações, versões e informações gerais.

## Tarefas

Criação, acompanhamento e organização das tarefas, incluindo status, prioridade, responsável, subtarefas e, após o MVP, cliente, tags, comentários e anexos.

## Backlog

Visualização **global e única** das tarefas que não possuem Sprint associada. O projeto, quando houver, é apenas um filtro.

## Sprints

Planejamento e acompanhamento de ciclos de desenvolvimento e suas respectivas tarefas.

## Tickets

Módulo principal de atendimento ao cliente: abertura, acompanhamento e organização dos chamados. Tickets utilizam as mesmas visualizações das tarefas (Kanban, calendário, tabela e cronograma) e não são tarefas com categoria de suporte.

## Clientes

Cadastro e gerenciamento dos clientes relacionados aos projetos, tarefas e tickets. Fora do MVP.

## Usuários

Gerenciamento dos usuários, seus perfis, cargos, status e participação nos projetos.

## Base de Conhecimento

Gerenciamento do **único acervo** de documentos Markdown do sistema. Os documentos podem ser vinculados a projetos, tarefas e tickets (N:N). Não existe módulo separado de “Documentação”.

## Versões

Gerenciamento das versões (releases) de cada projeto e associação das tarefas à versão correspondente.

## Categorias e Tags

Classificação e organização de tarefas, tickets e documentos. Fora do MVP.

## Comentários e Anexos

Recursos de colaboração e registro de informações complementares em tarefas e tickets. Fora do MVP.

---

# O que não é módulo

## Visualizações

**Kanban**, **Calendário**, **Tabela** e **Cronograma** não são módulos. São formas de exibir as tarefas e os tickets, disponíveis dentro dos módulos de Tarefas e de Tickets.

Todas operam sobre o mesmo conjunto de dados. Trocar de visualização não altera os dados nem cria um recorte próprio: apenas muda a apresentação.

O Kanban organiza os registros por status e permite alterá-lo diretamente no quadro.

---

### Regra

Cada módulo deve respeitar o **Domain Model** definido em `03-modelo-de-dados.md` e não deve criar entidades ou relacionamentos que contradigam o modelo.
