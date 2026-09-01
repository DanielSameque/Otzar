# Otzar

Frontend Flutter do Otzar, uma plataforma de gestão de projetos, tarefas, tickets e base de conhecimento para equipes de desenvolvimento e suporte.

A API REST fica em `..\backend`.

## Executar

```powershell
flutter pub get
flutter run -d chrome --dart-define=API_URL=http://localhost:3000
```

Para conferir a conexão com a API, abrir o ícone de diagnóstico na barra superior.

## Documentação

A documentação do produto está em [`docs/`](docs). A documentação técnica do backend está em [`../backend/docs/`](../backend/docs). O mapa completo do monorepo está em [`../docs/README.md`](../docs/README.md).

- [Visão geral](docs/01-visao-geral.md)
- [Arquitetura](docs/07-arquitetura.md) e [fundação do frontend](docs/13-fundacao.md)
- [Fundação do backend](../backend/docs/arquitetura/fundacao.md)
- [Escopo do MVP](docs/10-mvp.md)
- [Ambiente de desenvolvimento](docs/12-ambiente-de-desenvolvimento.md)
