import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/auth_provider.dart';
import '../../domain/auth_session.dart';

/// Sessão corrente. `null` mantém o usuário na jornada de login.
final authSessionProvider = NotifierProvider<AuthSessionNotifier, AuthSession?>(
  AuthSessionNotifier.new,
);

class AuthSessionNotifier extends Notifier<AuthSession?> {
  @override
  AuthSession? build() => null;

  void establish(AuthSession session) => state = session;

  void clear() => state = null;
}

/// Estado do formulário de autenticação.
class AuthFormState {
  const AuthFormState({
    this.intent = AuthIntent.signIn,
    this.email = '',
    this.password = '',
    this.passwordFocused = false,
    this.statusCode,
  });

  final AuthIntent intent;
  final String email;
  final String password;

  /// Verdadeiro enquanto a senha está sendo editada.
  ///
  /// Volta a falso quando o campo perde o foco, para a segunda metade do
  /// snippet poder ser revelada por inteiro.
  final bool passwordFocused;
  final int? statusCode;

  AuthFormState copyWith({
    AuthIntent? intent,
    String? email,
    String? password,
    bool? passwordFocused,
    int? statusCode,
    bool clearStatus = false,
  }) {
    return AuthFormState(
      intent: intent ?? this.intent,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordFocused: passwordFocused ?? this.passwordFocused,
      statusCode: clearStatus ? null : statusCode ?? this.statusCode,
    );
  }
}

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthFormState>(
  AuthViewModel.new,
);

class AuthViewModel extends Notifier<AuthFormState> {
  AuthSession? _pendingSession;

  @override
  AuthFormState build() => const AuthFormState();

  void setIntent(AuthIntent intent) {
    _pendingSession = null;
    state = state.copyWith(intent: intent, clearStatus: true);
  }

  void setEmail(String email) {
    _pendingSession = null;
    state = state.copyWith(email: email, clearStatus: true);
  }

  void setPassword(String password) {
    _pendingSession = null;
    state = state.copyWith(
      password: password,
      passwordFocused: true,
      clearStatus: true,
    );
  }

  /// O campo de senha perdeu o foco.
  void unfocusPassword() {
    if (!state.passwordFocused) {
      return;
    }

    state = state.copyWith(passwordFocused: false);
  }

  Future<void> submit() async {
    final result = await EmailPasswordAuthProvider(
      email: state.email,
      password: state.password,
      intent: state.intent,
    ).signIn();

    _pendingSession = result.session;
    state = state.copyWith(statusCode: result.statusCode);
  }

  Future<void> signInWithSocial(AuthSocial social) async {
    final result = await SocialAuthProvider(social).signIn();

    _pendingSession = null;
    state = state.copyWith(statusCode: result.statusCode);
  }

  /// Grava a sessão pendente e libera o redirect para o shell.
  void commitSession() {
    final session = _pendingSession;

    if (session == null) {
      return;
    }

    _pendingSession = null;
    ref.read(authSessionProvider.notifier).establish(session);
  }
}
