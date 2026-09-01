# Otzar

Monorepo do **Otzar** — plataforma de gestão de projetos, tarefas, tickets e base de conhecimento.

```text
Otzar/
├── frontend/   # Flutter (Web e mobile)
├── backend/    # API REST NestJS
└── docs/       # Mapa da documentação do monorepo
```

## Executar localmente

```powershell
# Backend
cd backend
npm install && npm run start:dev

# Frontend
cd frontend
flutter run -d chrome --dart-define=API_URL=http://localhost:3000
```

Passo a passo completo em [`frontend/docs/12-ambiente-de-desenvolvimento.md`](frontend/docs/12-ambiente-de-desenvolvimento.md).

## Documentação

Consulte [`docs/README.md`](docs/README.md) para entender onde cada tipo de documentação fica no monorepo.

| Aplicação | Documentação técnica | Documentação do produto |
| --------- | -------------------- | ----------------------- |
| Frontend | [`frontend/docs/13-fundacao.md`](frontend/docs/13-fundacao.md) | [`frontend/docs/`](frontend/docs/) |
| Backend | [`backend/docs/`](backend/docs/) | [`frontend/docs/`](frontend/docs/) |
