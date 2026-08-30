# API

## Objetivo

A API é responsável por disponibilizar as funcionalidades do Otzar para o Front-end e demais clientes.

## Princípios

* A API deve respeitar o Domain Model e as Regras de Negócio.
* A API não deve conter regras exclusivas da interface.
* A API é o ponto onde as regras de negócio são efetivamente aplicadas. Toda validação definida em `04-regras-de-negocio.md` deve ocorrer no Back-end.
* Nenhuma requisição deve ser considerada válida por já ter passado por uma validação no frontend.
* Operações devem retornar respostas consistentes e previsíveis.
* Erros devem possuir mensagens claras e códigos HTTP apropriados.
* Dados sensíveis nunca devem ser expostos nas respostas.

## Estrutura

A API deve ser organizada por recursos/domínios do sistema, mantendo separação clara entre:

* Autenticação
* Usuários
* Clientes
* Projetos
* Versões
* Tarefas
* Sprints
* Tickets
* Documentos
* Comentários
* Tags
* Categorias

## Padrões

* Utilizar HTTP/REST.
* Utilizar JSON para entrada e saída de dados.
* Utilizar métodos HTTP de acordo com sua finalidade.
* Utilizar códigos HTTP apropriados.
* Identificadores devem ser consistentes em toda a API.
* Paginação deve ser utilizada em consultas que possam retornar grandes volumes.
* Filtros, ordenação e busca devem ser suportados quando necessário.

## Segurança

* Endpoints protegidos devem exigir autenticação.
* Autorizações devem ser verificadas no Back-end.
* Usuários só podem acessar recursos aos quais possuem permissão.
* Senhas nunca devem ser retornadas pela API.

## Documentação

Cada recurso da API deve possuir documentação contendo:

* Endpoint
* Método HTTP
* Parâmetros
* Corpo da requisição
* Resposta
* Códigos de erro
* Regras de autorização

A documentação da API deve ser atualizada sempre que seu comportamento for alterado.
