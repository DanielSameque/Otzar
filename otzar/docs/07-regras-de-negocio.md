# Regras de Negócio

## Tarefas

* Uma tarefa pode existir sem projeto.
* Uma tarefa pode pertencer a no máximo uma Sprint.
* Tarefas sem Sprint pertencem automaticamente ao Backlog.
* O código da tarefa é gerado automaticamente e é único em todo o sistema.
* Subtarefas seguem as mesmas regras de uma tarefa.
* Uma tarefa pode possuir um ou mais clientes.

## Sprints

* Uma Sprint pode conter tarefas de diferentes projetos.
* Uma tarefa pode pertencer a no máximo uma Sprint.

## Projetos

* Um projeto pertence a um ou mais clientes.
* Um projeto pode possuir várias versões.
* Todo projeto possui exatamente uma Base de Conhecimento.

## Documentação

* Um documento pode pertencer a um projeto ou a uma tarefa.
* Um documento pode estar relacionado a várias tarefas.
* A documentação deve permanecer vinculada ao contexto do trabalho executado.

## Consistência

* Alterações nos relacionamentos devem preservar as regras do domínio.
* As regras de negócio devem ser aplicadas independentemente da interface utilizada.
