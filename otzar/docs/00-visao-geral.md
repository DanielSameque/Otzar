# Visão Geral

# Princípios do Produto

O Otzar deve seguir estes princípios:

- Simplicidade acima de quantidade de funcionalidades.
- Poucos cliques para executar qualquer ação.
- Interface consistente em todos os módulos.
- Toda informação deve poder ser localizada rapidamente.
- A documentação faz parte do projeto, não é um módulo separado.
- Todo dado deve poder ser relacionado (Ex: Projeto → Sprint → Tarefa → Documento → Ticket).

## O que é o Otzar?

**Otzar (אוצר)** significa **tesouro**, **depósito** ou **armazém**. Em diversos contextos bíblicos, a palavra é usada para um lugar onde recursos valiosos são guardados. Para um software que reúne conhecimento, projetos e informações, a associação faz bastante sentido.

O **Otzar** é uma plataforma de gestão de projetos voltada para equipes de desenvolvimento de software e suporte técnico. Seu objetivo é centralizar o gerenciamento de projetos, tarefas, tickets e conhecimento em uma única ferramenta, mantendo uma interface simples, intuitiva e flexível.

O sistema foi projetado para substituir a necessidade de utilizar diversas ferramentas separadas (como gerenciadores de projetos, sistemas de tickets e base de conhecimento), reunindo todas as principais funcionalidades em um único ambiente.

---

# Objetivo

O Otzar atende **uma única organização**. Permitir que a equipe gerencie de forma simples e eficiente um ou mais projetos, e centralizar o conhecimento, oferecendo:

- Controle de versões dos projetos (entidade Versão por projeto);
- Gerenciamento do Backlog global de tarefas;
- Planejamento e execução de Sprints;
- Visualização das tarefas em diferentes formatos;
- Gerenciamento de tickets de suporte (entidade própria, distinta de tarefa);
- Base de conhecimento em um único acervo Markdown, com vínculos N:N;
- Relatórios, indicadores e dashboards de desempenho.

O foco principal é oferecer uma experiência semelhante à flexibilidade do software Notion, porém especializada na gestão de projetos de software. E com uma facil manipulação a base de conhecimento como no software obsidian.

---

# Problemas que resolve

O Otzar busca resolver os seguintes problemas:

- Complexidade excessiva das ferramentas tradicionais de gestão de projetos.
- Necessidade de utilizar múltiplas ferramentas para organizar projetos, suporte e documentação.
- Falta de integração entre tarefas e a documentação técnica ou artigo de base de conhecimento.
- Dependência do Obsidian Publish e outros semelhantes para disponibilização pública da base de conhecimento.
- Dificuldade em acompanhar indicadores de produtividade e andamento dos projetos. Automatizando a notificação de atrasos e prazos.

---

# Principais funcionalidades

## Gestão de Projetos

- Controle de versões.
- Gerenciamento de Backlog.
- Planejamento de Sprints.
- Organização das tarefas.
- Controle de prioridades.
- Gerenciamento de responsáveis.
- Time Tracking.
- Categorias.
- Tags.
- Clientes.
- Datas de início e término.
- Dependências entre tarefas (futuramente).

### Visualizações

As tarefas poderão ser exibidas em diferentes formatos, permitindo que cada usuário escolha a forma mais adequada para seu trabalho:

- Quadro (Kanban)
- Calendário
- Cronograma (Timeline/Gantt)
- Tabela

A mudança entre as visualizações poderá ser feita a qualquer momento, sem alterar os dados. E poderá ser filtrado e ordenado por cliente, responsável, prioridade, status, entre outros.

---

## Gestão de Suporte

O atendimento ao cliente é funcionalidade principal do Otzar. Os **tickets** são uma entidade de domínio própria, não uma tarefa com categoria “Suporte”.

Os tickets utilizarão a mesma estrutura de visualizações das tarefas:

- Kanban
- Calendário
- Tabela
- Cronograma

Cada ticket poderá conter informações como:

- Responsável
- Cliente
- Prioridade
- Categoria
- Status
- Tempo gasto
- Comentários
- Anexos
- Tags

---

## Base de Conhecimento

O Otzar possuirá um único acervo de documentação Markdown (Base de Conhecimento). Documentos não são duplicados por projeto nem por tarefa.

Será possível:

- Criar documentos diretamente pelo Otzar;
- Importar arquivos Markdown existentes;
- Sincronizar documentos criados no Obsidian;
- Sincronizar documentos criados pelo Cursor;
- Publicar a documentação na web, substituindo o Obsidian Publish;
- Relacionar o mesmo documento a vários projetos, tarefas e tickets (N:N).

---

## Dashboards e Relatórios

O sistema disponibilizará dashboards para acompanhamento da equipe, contendo indicadores como:

- Produtividade por colaborador;
- Tempo médio das tarefas;
- Tempo médio dos tickets;
- Evolução das Sprints;
- Burndown Chart;
- Volume de chamados;
- Desempenho dos projetos;
- Gráficos personalizados.

---

# O que o Otzar NÃO é

O Otzar não pretende substituir ferramentas generalistas de organização pessoal.

Por isso:

- Não será um concorrente direto do Notion para uso genérico.
- Não terá todas as funcionalidades avançadas presentes em grandes plataformas como Jira, Azure DevOps ou Monday.com.
- O foco será simplicidade, produtividade e integração entre projetos, suporte e documentação.

---

# Visão Futura

Após a validação do MVP, o Otzar deverá evoluir para uma plataforma inteligente de gestão.

Funcionalidades planejadas:

- Integração com WhatsApp para abertura automática de tickets;
- Distribuição automática de atendimentos entre colaboradores;
- Criação automática de tarefas a partir dos atendimentos;
- Agente de Inteligência Artificial integrado;
- IA especialista na base de conhecimento da empresa;
- IA especialista nos projetos em andamento;
- Criação de tarefas utilizando voz ou texto;
- Assistente capaz de complementar automaticamente as informações das tarefas através de perguntas contextuais;
- Sugestão automática de documentação e soluções semelhantes com base no histórico da empresa.
- Existir a area do cliente para realizar solicitações de desenvolvimento de software e acompanhar o status das solicitações.