# Ambiente de Desenvolvimento

Documentação para instalação e configuração do ambiente de desenvolvimento do **Otzar**.

---

# ⬇️ Instalação

## Git

Criar a seguinte pasta no diretório raiz:

```text
C:\GitHub
```

Clonar o repositório do Otzar dentro dessa pasta.

### Estrutura do repositório

O repositório contém as duas aplicações do Otzar:

```text
C:\GitHub\Otzar\
├── frontend\   # Frontend Flutter (Web e mobile)
└── backend\    # API REST NestJS
```

A documentação do produto fica em `frontend\docs`. A documentação técnica do backend fica em `backend\docs`. O mapa completo do monorepo está em `docs\README.md`.

---

## Flutter

Baixar e instalar o **[SDK do Flutter](https://docs.flutter.dev/get-started/install)**.

Criar a seguinte pasta:

```text
C:\Flutter
```

Descompactar o Flutter dentro dessa pasta.

Após a instalação, verificar:

```powershell
flutter --version
dart --version
```

---

## Node.js

O backend NestJS exige **Node.js 20 ou superior**.

Baixar e instalar o **[Node.js LTS](https://nodejs.org)**.

Verificar:

```powershell
node --version
npm --version
```

---

## PostgreSQL local

O backend utiliza PostgreSQL. Em desenvolvimento existem duas opções:

* **Docker** — subir o banco com o `docker-compose.yml` versionado em `backend\`.
* **Neon** — apontar a `DATABASE_URL` para o banco gerenciado, conforme `08-stack-tecnologica.md`.

Com Docker instalado:

```powershell
cd C:\GitHub\Otzar\backend
docker compose up -d
```

O container expõe o PostgreSQL em `localhost:5432` com usuário, senha e banco `otzar`.

A API sobe mesmo sem banco disponível: `GET /health` responde `database: "down"` em vez de impedir a inicialização. Isso permite desenvolver o frontend antes de configurar o PostgreSQL.

---

# ⚙️ Backend (NestJS)

Instalação, variáveis de ambiente, Prisma, scripts e deploy do backend estão documentados em [`backend/docs/ambiente-de-desenvolvimento.md`](../../backend/docs/ambiente-de-desenvolvimento.md).

Resumo para subir a API:

```powershell
cd C:\GitHub\Otzar\backend
npm install
Copy-Item .env.example .env
npm run prisma:generate
npm run start:dev
```

---

# ▶️ Executar o Otzar localmente

O ambiente completo utiliza três terminais:

```powershell
# 1. Banco de dados (opcional enquanto não houver entidades)
cd C:\GitHub\Otzar\backend
docker compose up -d

# 2. API
cd C:\GitHub\Otzar\backend
npm run start:dev

# 3. Frontend
cd C:\GitHub\Otzar\frontend
flutter run -d chrome --dart-define=API_URL=http://localhost:3000
```

A URL da API nunca fica fixa no código: é lida de `API_URL` por `lib\core\config\app_config.dart`, que assume `http://localhost:3000` quando o valor não é informado.

Para confirmar que o frontend conversa com a API, abrir o ícone de **Diagnóstico** na barra superior do aplicativo. A tela exibe o endereço consultado, o status da API e o estado da conexão com o banco.

## Geração de código do frontend

Os Models utilizam Freezed e json_serializable. Após alterar um Model:

```powershell
cd C:\GitHub\Otzar\frontend
dart run build_runner build
```

## Verificações

```powershell
cd C:\GitHub\Otzar\frontend
flutter analyze
flutter test
```

---

# 🤖 MCP Dart/Flutter

O Cursor utiliza o **Dart MCP Server** para fornecer ao Agent ferramentas de análise e interação com projetos Dart/Flutter.

O servidor é executado através do comando:

```powershell
dart mcp-server
```

## Configuração

O MCP está registrado no arquivo global do Cursor:

```text
C:\Users\Administrador\.cursor\mcp.json
```

Configuração:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

Após alterar a configuração, recarregar a janela do Cursor:

```text
Ctrl + Shift + P
→ Developer: Reload Window
```

## Validação

No Cursor, acessar:

```text
Settings
→ Tools & MCP
```

O servidor `dart` deve aparecer como **Connected**.

Também é possível validar pelo Agent solicitando uma análise do projeto:

```text
Use o Dart MCP server para analisar este projeto Flutter.
Não altere nenhum arquivo.
Informe os diagnósticos encontrados pelo Dart Analyzer.
```

### Plugin Dart & Flutter

O plugin local **Dart and Flutter** está localizado em:

```text
C:\Users\Administrador\.cursor\plugins\local\dart-flutter\agent-plugins
```

O plugin fornece as Skills do Dart/Flutter e a configuração do Dart MCP Server.

---

# 🤖 Configurar Android

## Java — Eclipse Temurin JDK 17

Instalar o **[Eclipse Temurin JDK 17](https://adoptium.net/temurin/releases/?version=17)**.

Criar a variável de ambiente do Java em **Variáveis do Sistema**:

```text
Nome:
JAVA_HOME

Valor:
C:\Program Files\Eclipse Adoptium\jdk-17.0.19.10-hotspot
```

Adicionar ao `Path`:

```text
%JAVA_HOME%\bin
```

Fechar o terminal e abrir novamente.

Testar:

```powershell
echo $env:JAVA_HOME
java -version
```

Deve aparecer uma versão do:

```text
openjdk version "17..."
```

---

## Android SDK Command Line Tools

Baixar o **[Android SDK Command Line Tools](https://developer.android.com/studio#command-tools)**.

O download fica na parte inferior da página.

Criar a estrutura:

```text
C:\Android\cmdline-tools\latest
```

Colocar o conteúdo das Command Line Tools dentro de `latest`.

A estrutura deve ficar:

```text
C:\Android
└── cmdline-tools
    └── latest
        └── bin
            ├── sdkmanager.bat
            ├── avdmanager.bat
            └── ...
```

---

## Variáveis de Ambiente

Criar em **Variáveis do Sistema**:

```text
ANDROID_HOME=C:\Android
```

Adicionar ao `Path`:

```text
C:\Android\platform-tools
C:\Android\cmdline-tools\latest\bin
```

---

## Instalar os pacotes Android

Executar:

```powershell
sdkmanager --list
sdkmanager --licenses

sdkmanager "platforms;android-36"
sdkmanager "build-tools;36.0.0"
sdkmanager "cmdline-tools;latest"
sdkmanager "platform-tools"
```

---

## Configurar o Android SDK no Flutter

Executar:

```powershell
flutter config --android-sdk C:\Android
```

Aceitar as licenças:

```powershell
flutter doctor --android-licenses
```

Verificar o ambiente:

```powershell
flutter doctor
```

### Resumo

```text
Flutter SDK
    ↓
Java 17
    ↓
Android Command Line Tools
    ↓
sdkmanager
    ↓
platform-tools + build-tools + platform
    ↓
flutter doctor
```

---

# 📱 Depurar pelo Wi-Fi no Android

## 1. Conectar o celular e o PC na mesma rede Wi-Fi

O computador e o celular devem estar na mesma rede.

---

## 2. Conectar o celular via USB

Conectar o celular ao computador via USB na primeira configuração.

Executar:

```bash
adb tcpip 5555
```

Saída esperada:

```text
restarting in TCP mode port: 5555
```

Isso ativa o modo ADB via rede na porta `5555`.

---

## 3. Descobrir o endereço IP do celular

No Android:

```text
Configurações
→ Sobre o telefone
→ Informações de status
→ Endereço IP
```

Ou:

```text
Configurações
→ Wi-Fi
→ Rede conectada
→ Avançado
→ Endereço IP
```

Exemplo:

```text
192.168.0.116
```

---

## 4. Conectar via Wi-Fi

No terminal:

```bash
adb connect 192.168.0.116:5555
```

Saída esperada:

```text
connected to 192.168.0.116:5555
```

Agora o cabo USB pode ser desconectado.

Verificar:

```bash
adb devices
```

Deve aparecer algo semelhante a:

```text
List of devices attached
192.168.0.116:5555    device
```

---

## 5. Verificar no Cursor

O dispositivo deverá aparecer no Cursor como dispositivo Flutter disponível.

Também é possível verificar pelo terminal:

```bash
flutter devices
```

O celular deverá aparecer na lista.

### Se não conectar

Verificar:

* Firewall do Windows.
* Celular e computador na mesma sub-rede.
* Depuração USB ativada.
* Autorização da depuração USB no celular.

Reiniciar o ADB:

```bash
adb kill-server
adb start-server
adb connect 192.168.0.116:5555
```

---

# 🆙 Atualizar SDK e versão do Flutter

Antes de atualizar, feche o Cursor e outros terminais que estejam utilizando o Flutter.

No **PowerShell como Administrador**, executar:

```powershell
flutter upgrade
```

## Verificar instalação

```powershell
flutter doctor
```

## Atualizar o projeto

Abra o projeto no Cursor e execute no diretório do projeto:

```powershell
flutter pub upgrade
flutter clean
flutter pub get
```

## Testar

```powershell
flutter run
```

## Comandos úteis

```powershell
flutter --version
flutter doctor -v
flutter pub outdated
```

---

# 🚀 Deploy (Flutter Web no Render)

O frontend web é publicado como **Site Estático no Render**, no mesmo painel do backend NestJS, conforme `08-stack-tecnologica.md`.

Não utilizar NGINX, Apache ou scripts de limpeza de `nginx.conf`. O Render serve os arquivos estáticos e o HTTPS.

> O deploy ainda não foi configurado. Esta seção descreve o procedimento previsto para quando a publicação for realizada.

## Build local

Para gerar o build web na pasta padrão do Flutter:

```powershell
cd C:\GitHub\Otzar\frontend
flutter build web --release --dart-define=API_URL=https://<url-da-api>
```

A saída fica em:

```text
frontend\build\web
```

Não versionar segredos no build. A URL da API e demais configurações do ambiente devem ser definidas no painel do Render ou passadas no build com `--dart-define`.

## Script de build do Render

O ambiente de build do Render **não possui o SDK do Flutter pré-instalado**. O build é gerado por um script versionado no repositório, que instala o Flutter e compila a aplicação.

Criar o arquivo `scripts/render-build.sh`, na raiz do repositório:

```bash
#!/usr/bin/env bash
set -e

FLUTTER_VERSION="stable"
FLUTTER_DIR="$HOME/flutter"

if [ ! -d "$FLUTTER_DIR" ]; then
  git clone https://github.com/flutter/flutter.git \
    --branch "$FLUTTER_VERSION" --depth 1 "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

cd frontend

flutter --version
flutter pub get
flutter build web --release --dart-define=API_URL="$API_URL"
```

Dar permissão de execução antes de commitar:

```powershell
git update-index --chmod=+x scripts/render-build.sh
```

Essa abordagem foi escolhida em vez de gerar o build localmente porque mantém o deploy automático a cada push e evita versionar a pasta `build/web`.

## Publicar o Site Estático

1. No Render, criar um serviço do tipo **Static Site** apontando para o repositório do Otzar.
2. Configurar:

```text
Build Command:      ./scripts/render-build.sh
Publish Directory:  frontend/build/web
```

3. Adicionar a regra de reescrita para SPA, necessária para as rotas do GoRouter:

```text
Source:       /*
Destination:  /index.html
Action:       Rewrite
```

4. Definir `API_URL` nas variáveis do serviço. O script repassa o valor ao build com `--dart-define`.
5. Fazer o deploy a partir da branch de produção.

## Publicar o backend

Detalhes de deploy no Render estão em [`backend/docs/ambiente-de-desenvolvimento.md`](../../backend/docs/ambiente-de-desenvolvimento.md).

Resumo:

```text
Root Directory:  backend
Build Command:   npm install && npm run prisma:generate && npm run build
Start Command:   npm run start:prod
```

Definir `DATABASE_URL`, `JWT_SECRET` e `CORS_ORIGIN` nas variáveis do serviço. O `CORS_ORIGIN` deve conter a URL do Site Estático, já que frontend e backend possuem domínios distintos.

O frontend deve chamar apenas a API REST do NestJS via HTTPS.

Nos planos gratuitos, o Web Service hiberna após inatividade e o compute do Neon é suspenso quando ocioso, deixando a primeira requisição mais lenta.
