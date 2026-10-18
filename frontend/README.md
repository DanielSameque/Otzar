# Otzar

Frontend Flutter do Otzar, uma plataforma de gestão de projetos, tarefas, tickets e base de conhecimento para equipes de desenvolvimento e suporte.

A API REST fica em `..\backend`.

## Executar

```powershell
flutter pub get
flutter run -d chrome --dart-define=API_URL=http://localhost:3000
```

Para conferir a conexão com a API, abrir o ícone de diagnóstico na barra superior.

## Arquitetura de software

Mesma arquitetura do QuickTrade Web (`WEB/quicktradeweb`):

**Repository + Service + MVC**:\
**MVC:** Modelo (Model), Visão (View) e Controlador (Controller)\
**Repository:** Acesso a dados/API\
**Service:** Lógica da operação no frontend (as regras de negócio são validadas no backend)

**SOLID:** Procurar seguir este padrão\
**OOP:** classes abstratas e interfaces\
**Observer:** Para reatividade e prevenção de if (Riverpod)\
**Full Rest:** Procurar seguir os padrões de Rest\
**AAA:** Arrange, Act, Assert. Para testes unitários.

```text
lib/
├── Model/        # Estrutura de dados (Freezed)
├── Repository/   # Acesso a dados/API
├── Service/      # Lógica da operação, rotas e infraestrutura HTTP
├── Controller/   # Estado das telas (Riverpod)
├── View/         # Pages e Componentes
└── src/theme/    # Tema, cores, tipografia e breakpoints
```

Detalhes em [Arquitetura](docs/07-arquitetura.md) e nas regras `.cursor/rules/flutter-arquitetura.mdc` e `.cursor/rules/flutter-estrutura-do-projeto.mdc`.

## Documentação

A documentação do produto está em [`docs/`](docs). A documentação técnica do backend está em [`../backend/docs/`](../backend/docs). O mapa completo do monorepo está em [`../docs/README.md`](../docs/README.md).

- [Visão geral](docs/01-visao-geral.md)
- [Arquitetura](docs/07-arquitetura.md) e [fundação do frontend](docs/13-fundacao.md)
- [Fundação do backend](../backend/docs/arquitetura/fundacao.md)
- [Escopo do MVP](docs/10-mvp.md)
- [Ambiente de desenvolvimento](docs/12-ambiente-de-desenvolvimento.md)
