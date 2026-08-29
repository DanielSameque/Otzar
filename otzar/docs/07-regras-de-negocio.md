# Regras de Negócio

## Organização

* O Otzar opera para uma única organização. Não há multi-empresa.
* Códigos de tarefa e de ticket são únicos em todo o sistema.

## Tarefas

* Uma tarefa pode existir sem projeto.
* Uma tarefa pode pertencer a no máximo uma Sprint.
* Tarefas sem Sprint pertencem automaticamente ao Backlog global único.
* O código da tarefa é gerado automaticamente e é único em todo o sistema.
* Subtarefas seguem as mesmas regras de uma tarefa.
* Uma tarefa pode possuir zero ou mais clientes. O vínculo com cliente não é obrigatório e fica fora do MVP.
* Categoria e tags de tarefa existem no domínio, mas a associação fica fora do MVP, junto com os módulos correspondentes.
* Uma tarefa só pode ser associada a uma Versão do mesmo projeto. Sem projeto, não há versão.

## Tickets

* Ticket é entidade distinta de Tarefa.
* Um ticket pode existir com ou sem projeto e com ou sem cliente.
* O código do ticket é gerado automaticamente e é único em todo o sistema.
* Um ticket pode estar relacionado a várias tarefas e a vários documentos.

## Sprints

* Uma Sprint pode conter tarefas de diferentes projetos.
* Uma tarefa pode pertencer a no máximo uma Sprint.
* Sprint não possui versão.

## Projetos

* Um projeto pode possuir zero ou mais clientes. Cliente não é obrigatório.
* A regra de vincular cliente ao projeto entra no produto junto com o módulo Clientes (após o MVP).
* Um projeto pode possuir várias versões.
* Um projeto não possui Base de Conhecimento exclusiva.

## Versões

* Toda versão pertence a um projeto.
* Várias tarefas do mesmo projeto podem compartilhar a mesma versão.
* `MensagemVersão` na tarefa descreve a contribuição daquela tarefa na versão.

## Documentação

* Existe um único acervo Markdown (Base de Conhecimento).
* Um documento pode existir sem vínculos.
* Vínculos com projetos, tarefas e tickets são N:N.
* Relacionar um documento não duplica o conteúdo.
* A documentação deve permanecer conectada ao trabalho executado por meio desses vínculos.

## Backlog

* Existe um único Backlog, global.
* Filtros não criam backlogs adicionais.

## Consistência

* Alterações nos relacionamentos devem preservar as regras do domínio.
* As regras de negócio devem ser aplicadas independentemente da interface utilizada.
