# Checklist de progresso — estudos Otzar

Marque cada item com `[x]` conforme for concluindo.

**Como usar:** copie o arquivo ou edite direto neste doc. Uma caixa por vez — não precisa “terminar a semana” para avançar um tópico.

**Sequência de aprendizado:**

1. Lógica de programação
2. Dart
3. Flutter
4. Aplicação prática no projeto Otzar

**Método em 3 camadas** (use em quase todo item):

1. **Entender** o conceito
2. **Localizar** esse conceito no projeto Otzar
3. **Alterar** algo pequeno na prática

**Rotina sugerida (1h30/dia):**


| Tempo  | Atividade            |
| ------ | -------------------- |
| 30 min | Dart                 |
| 30 min | Flutter              |
| 30 min | Otzar (projeto real) |


Documento complementar (Cursor, IA, domínio e stack): [plano-de-estudo.md](plano-de-estudo.md).

---



## Antes de começar

- [ ] Li o [README do monorepo](../README.md)
- [ ] Li o [mapa da documentação](README.md)
- [ ] Sei a diferença entre `frontend/` (Flutter) e `backend/` (NestJS)
- [ ] Defini onde vou estudar (horário / dias da semana)
- [ ] Entendi o método das 3 camadas (entender → localizar → alterar)

---



## Semana 1 — Conhecer o território

Meta: conceitos básicos de programação, Dart e Flutter, sem pressão de “entregar feature”.

### Lógica de programação

- [ ] Sei o que é um algoritmo (passo a passo para resolver um problema)
- [ ] Entendo sequência, decisão e repetição
- [ ] Sei o que é variável e para que serve
- [ ] Sei o que é função (entrada → processamento → saída)
- [ ] Consigo explicar, com palavras minhas, o que o computador “faz” ao rodar um programa



### Dart — fundamentos

- [ ] Instalei o SDK / ambiente Flutter e rodei um “Hello”
- [ ] Variáveis e tipos básicos (`int`, `double`, `String`, `bool`)
- [ ] `if` / `else` e condições
- [ ] Funções (parâmetros e retorno)
- [ ] Classes e objetos (o que é uma “entidade” no código)
- [ ] Listas (`List`)
- [ ] Mapas (`Map`)
- [ ] `Future` e `async` / `await` (o que é código assíncrono)



### Flutter — primeiro contato

- [ ] Sei o que é um widget (bloco de UI)
- [ ] Diferencio widget de “tela” / “página”
- [ ] Rodei o app Flutter do Otzar localmente (ou o exemplo oficial, se ainda não tiver setup)
- [ ] Abri o código e reconheci pastas principais do `frontend/`



### Método 3 camadas — prática da semana 1

Escolha **um** conceito da lista acima e faça o ciclo completo:

- [ ] **Entendi** o conceito (anotei em 3–5 linhas)
- [ ] **Localizei** no Otzar (arquivo / trecho aproximado)
- [ ] **Alterei** algo mínimo (texto na tela, print, comentário útil, etc.) e vi o resultado



### Checklist de fechamento — Semana 1

- [ ] Consigo explicar variável, função, classe, lista e mapa sem consultar
- [ ] Consigo dizer, em uma frase, o que é `async`/`await`
- [ ] Consigo apontar um widget no código do frontend

---



## Semana 2 — Praticar Dart com o domínio do Otzar

Meta: usar Dart pensando nas entidades do produto: **Cliente**, **Projeto**, **Ticket**, **Tarefa**.

### Domínio (produto)

- [ ] Li a [visão geral](../frontend/docs/01-visao-geral.md)
- [ ] Li o [glossário](../frontend/docs/02-glossario.md)
- [ ] Entendo: **Ticket ≠ Tarefa**
- [ ] Sei o que é um Projeto no Otzar
- [ ] Sei o que é Cliente (no sentido do domínio do produto)



### Exercícios de Dart (conceitos do projeto)

- [ ] Modelei mentalmente uma classe `Cliente` (quais campos fariam sentido?)
- [ ] Modelei mentalmente uma classe `Projeto`
- [ ] Modelei mentalmente uma classe `Tarefa`
- [ ] Modelei mentalmente uma classe `Ticket`
- [ ] Criei (em exercício ou no projeto) uma `List` de tarefas ou tickets
- [ ] Usei um `Map` (ex.: id → nome, status → contagem)
- [ ] Escrevi uma função que filtra uma lista (ex.: só tarefas “em andamento”)
- [ ] Usei `if` para regras simples (ex.: ticket fechado não pode reabrir sem condição X — mesmo que inventada para treino)



### Localizar no projeto

- [ ] Encontrei no código ou na docs onde **Projeto** aparece
- [ ] Encontrei onde **Tarefa** aparece
- [ ] Encontrei onde **Ticket** aparece
- [ ] Li o [modelo de dados](../frontend/docs/03-modelo-de-dados.md) (mesmo que por cima)



### Método 3 camadas — prática da semana 2

- [ ] **Entendi** um conceito de domínio (ex.: diferença ticket × tarefa)
- [ ] **Localizei** no código ou na documentação
- [ ] **Alterei** algo pequeno relacionado (texto, label, comentário, dado mock)



### Checklist de fechamento — Semana 2

- [ ] Explico Cliente, Projeto, Ticket e Tarefa em linguagem simples
- [ ] Consigo imaginar essas entidades como classes Dart
- [ ] Já abri pelo menos 2 arquivos de domínio/docs e anotei o que aprendi

---



## Semana 3 — Flutter: pequenas telas

Meta: montar (ou estudar) o fluxo de navegação mental do produto.

Fluxo alvo:

**Login → Dashboard → Projetos → Tarefas → Ticket**

### Conceitos Flutter

- [ ] `StatelessWidget` vs ideia de tela com estado (mesmo que básico)
- [ ] Layout simples: `Column`, `Row`, `Text`, `ElevatedButton` / botões
- [ ] Navegação entre telas (conceito de “ir para outra página”)
- [ ] Formulário simples (campo de texto + botão) — ex.: login fake
- [ ] Lista na tela (lista de projetos ou tarefas)



### Telas (checklist por tela)

Trate cada tela assim: **entender → localizar no Otzar (se existir) → criar versão mínima / anotar o que falta**.

#### Login

- [ ] Entendi o objetivo da tela
- [ ] Localizei no projeto (ou anotei que ainda não existe / está incompleta)
- [ ] Fiz uma versão mínima (mesmo que só UI estática)



#### Dashboard

- [ ] Entendi o objetivo da tela
- [ ] Localizei no projeto
- [ ] Fiz uma versão mínima ou descrevi o que ela deveria mostrar



#### Projetos

- [ ] Entendi o objetivo da tela
- [ ] Localizei no projeto
- [ ] Fiz uma versão mínima (lista / cards simples)



#### Tarefas

- [ ] Entendi o objetivo da tela
- [ ] Localizei no projeto
- [ ] Fiz uma versão mínima



#### Ticket

- [ ] Entendi o objetivo da tela
- [ ] Localizei no projeto
- [ ] Fiz uma versão mínima (detalhe de um ticket)



### Arquitetura (primeiro contato, sem se perder)

- [ ] Li a [fundação do frontend](../frontend/docs/13-fundacao.md) (leitura guiada)
- [ ] Ouvi falar de MVVM no Otzar (View → ViewModel → …)
- [ ] Sei que o frontend **não** acessa o banco direto



### Método 3 camadas — prática da semana 3

- [ ] **Entendi** um widget ou padrão de navegação
- [ ] **Localizei** no `frontend/`
- [ ] **Alterei** texto, cor, título ou um botão e validei na tela



### Checklist de fechamento — Semana 3

- [ ] Desenho o fluxo Login → … → Ticket no papel ou no Mermaid mental
- [ ] Consigo criar uma tela Flutter vazia com título e um botão
- [ ] Sei onde procurar telas/features no repositório

---



## Semana 4 — Primeiras contribuições no projeto real

Meta: contribuir de forma pequena, segura e documentada.

### Ambiente

- [ ] Backend sobe localmente
- [ ] Frontend sobe localmente
- [ ] Segui o [ambiente de desenvolvimento](../frontend/docs/12-ambiente-de-desenvolvimento.md)
- [ ] Sei o que é `API_URL` / `--dart-define` (ideia geral)



### Boas práticas no Otzar

- [ ] Sei que documentação faz parte da tarefa ([regra de docs](README.md))
- [ ] Li o escopo do [MVP](../frontend/docs/10-mvp.md)
- [ ] Sei pedir ajuda ao Cursor em Ask mode antes de editar (quando só quero entender)
- [ ] Reviso o diff antes de aceitar mudanças da IA



### Contribuições (comece pequeno)

Marque o que já fez; pode repetir o ciclo várias vezes.

- [ ] Corrigi texto / label / tipografia inconsistente
- [ ] Melhorei um trecho de UI simples
- [ ] Atualizei ou criei um pedaço de documentação
- [ ] Localizei e li o endpoint `GET /health` ([doc](../backend/docs/endpoints/health.md))
- [ ] Fiz uma alteração mínima guiada (com revisão)
- [ ] Escrevi uma spec curta (objetivo + fora de escopo + aceite) antes de pedir ao Agent



### Método 3 camadas — prática da semana 4

- [ ] **Entendi** a tarefa (o “porquê”)
- [ ] **Localizei** arquivos e docs relacionados
- [ ] **Alterei** com mudança pequena + atualizei docs se necessário



### Checklist de fechamento — Semana 4

- [ ] Já contribuí pelo menos uma vez no repositório real
- [ ] Consigo explicar o que mudei e por quê
- [ ] Sei onde documentar a próxima mudança

---



## Progresso geral (visão rápida)

Use esta seção como painel: marque só quando a semana estiver “boa o suficiente” para avançar.

- [ ] Semana 1 concluída — território conhecido
- [ ] Semana 2 concluída — domínio + Dart praticados
- [ ] Semana 3 concluída — fluxo de telas entendido / prototipado
- [ ] Semana 4 concluída — primeira contribuição real

---



## Diário rápido (opcional)

Anote data e o que fez (1 linha). Ajuda a manter ritmo.


| Data | O que estudei (30+30+30) | Conceito | Onde localizei no Otzar | O que alterei |
| ---- | ------------------------ | -------- | ----------------------- | ------------- |
|      |                          |          |                         |               |
|      |                          |          |                         |               |
|      |                          |          |                         |               |
|      |                          |          |                         |               |
|      |                          |          |                         |               |


---



## Lembretes didáticos

- **Errar faz parte.** Preferir mudança pequena e reversível.
- **Não pule a camada 2.** Entender sem localizar no projeto deixa o aprendizado abstrato demais.
- **Não pule a camada 3.** Só ler sem alterar quase não grava.
- Se travar: volte um passo (ex.: lista antes de Future; widget estático antes de navegação).
- Em dúvida de produto: comece pelo [glossário](../frontend/docs/02-glossario.md).

