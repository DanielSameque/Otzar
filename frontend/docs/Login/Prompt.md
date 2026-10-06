# Prompt: Design e implementação da tela de autenticação do Otzar (Flutter)

## Contexto do produto

O **Otzar** (אוצר = tesouro/armazém) é uma plataforma de gestão de projetos para equipes de desenvolvimento e suporte técnico. Une projetos, tarefas, tickets e conhecimento numa interface **simples, intuitiva e flexível** — simplicidade acima de quantidade de funcionalidades; poucos cliques; visual consistente.

A experiência deve transmitir: **minimalismo + sofisticação + identidade para desenvolvedores**. Não usar visual genérico de SaaS (roxo/gradiente óbvio, cards excessivos, chips flutuantes, clutter). O nome **Otzar** é o sinal visual principal da jornada de entrada.

**Tema obrigatório: Dark** — fundo escuro, tipografia e acentos com contraste alto e elegante; atmosfera calma (superfícies em camadas sutis, sem glow exagerado).

Stack: **Flutter (Web + Mobile, mesma codebase)**. Preferir animações nativas sofisticadas (`AnimationController`, `Tween`, `AnimatedBuilder`, `Hero`, `PageRouteBuilder`). Evitar dependências pesadas sem necessidade. Código organizado e preparado para autenticação real via API NestJS — **sem implementar OAuth completo agora**.

Documentos de referência:
- `frontend/docs/01-visao-geral.md`
- `frontend/docs/08-stack-tecnologica.md`
- `frontend/docs/10-mvp.md` (Auth + Layout base / Shell)

Convenção de layout do projeto:
- Breakpoint global: **900px** (ver rule `frontend/.cursor/rules/flutter-responsive-breakpoint.mdc`).
- `width >= 900` → layout desktop/split.
- `width < 900` → layout mobile/stack.

---

## Objetivo

Criar a **jornada visual completa de autenticação** em 3 fases:
1. Splash (escrita do nome Otzar como se estivesse sendo escrito por um usuário)
2. Login / Criar conta (animações reativas à digitação)
3. Transição rápida para o **Layout base (Shell)** do MVP

Foco: **design, animações, layout responsivo e estrutura de código**. OAuth/API como stubs/interfaces.

**Feedback de erro/sucesso:** apenas na **animação de código à esquerda** (status HTTP). **Não usar SnackBar**, toast, banner flutuante ou equivalentes.

---

## Fase 1 — Inicial (Splash)

- Animação de **escrita tipográfica da palavra “Otzar”** (typewriter ou stroke reveal — a opção mais elegante no Flutter).
- Duração: **1,30 s** (1300 ms), easing suave (ex.: `Curves.easeOutCubic`).
- Tema dark; só a marca e a atmosfera — sem formulário.
- Ao terminar, transição fluida (fade/morph) para a Fase 2.

---

## Fase 2 — Intermediária (Login / Auth)

### Layout responsivo

**Desktop / Web (`width >= 900`):**
- Split ao meio.
- **Esquerda:** animação (marca + simulação de código).
- **Direita:** formulário.
- Divisória central sutil (linha fina ou contraste de superfície).

**Mobile (`width < 900`):**
- **Acima:** animação (altura limitada).
- **Abaixo:** campos.
- **Tudo cabe na viewport** no estado padrão (sem scroll desnecessário).

### Formulário de Login (direita / abaixo)

- Título: **“Bem-vindo”**.
- Campos: e-mail (ou usuário) e senha.
- Botão primário: **Entrar**.
- Link: **Esqueci minha senha**.
- Link/ação: **Criar conta**.
- Separador discreto + opções de login social (UI + estrutura, sem OAuth real):
  - Google
  - Facebook
  - GitHub
  - E-mail próprio = o formulário acima

Abstrações claras (`AuthProvider`, stubs, callbacks) para plugar OAuth depois.

### Animação A — usuário NÃO está digitando

- Nome **“Otzar”** na área de animação com **pulso leve** (scale e/ou opacity sutis, loop, amplitude baixa).

### Animação B — usuário ESTÁ digitando

- Na área esquerda (superior no mobile), **simulação de digitação do snippet JavaScript abaixo**.
- Regras:
  - Campo **e-mail** → anima a **1ª metade** do snippet (linhas 1–8).
  - Campo **senha** → anima a **2ª metade** (linhas 9–16).
  - A ordem dos campos **não importa**.
  - Progresso proporcional ao texto digitado; ao apagar, o código retrocede de forma coerente.
  - Enquanto digita, o pulso do “Otzar” pode atenuar; priorizar legibilidade do código.
- Estilo visual do painel: terminal/editor minimalista dark (mono, sintaxe sutil).

### Snippet JavaScript (obrigatório — usar este texto)

```javascript
const otzar = {
  user: null,
  async signIn({ email, password }) {
    const res = await fetch('/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password }),
    });
    // --- metade 1 termina aqui; metade 2 começa abaixo ---
    if (!res.ok) throw new Error(`auth_failed:${res.status}`);
    const session = await res.json();
    otzar.user = session.user;
    console.log('Otzar unlocked');
    return { status: res.status, session };
  },
};
await otzar.signIn(credentials);
// status: ___