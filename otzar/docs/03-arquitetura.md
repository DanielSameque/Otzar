# Arquitetura

O Otzar utiliza uma arquitetura baseada em **MVVM + Service + Repository**, com foco em separação de responsabilidades, testabilidade e simplicidade.

## Fluxo

```text
View
  ↓
ViewModel
  ↓
Service
  ↓
Repository
  ↓
ApiClient
  ↓
REST API