import 'auth_session.dart';

/// Intenção do formulário de autenticação.
enum AuthIntent { signIn, signUp, resetPassword }

/// Provedor social exibido na tela. O fluxo OAuth ainda não existe.
enum AuthSocial {
  google,
  facebook,
  github;

  String get label => switch (this) {
    AuthSocial.google => 'Google',
    AuthSocial.facebook => 'Facebook',
    AuthSocial.github => 'GitHub',
  };
}

/// Resultado de uma tentativa de autenticação.
///
/// [statusCode] é o único feedback exibido na jornada (linha `// status:`).
/// [session] existe apenas quando a tentativa libera a entrada no shell.
class AuthResult {
  const AuthResult({required this.statusCode, this.session});

  final int statusCode;
  final AuthSession? session;
}

/// Ponto de extensão da autenticação.
///
/// E-mail/senha e os botões sociais implementam este contrato. OAuth real
/// entra depois, trocando o stub sem mudar a tela.
abstract class AuthProvider {
  Future<AuthResult> signIn();
}

/// Stub local de e-mail e senha. Não chama a API.
class EmailPasswordAuthProvider implements AuthProvider {
  const EmailPasswordAuthProvider({
    required this.email,
    required this.password,
    required this.intent,
  });

  final String email;
  final String password;
  final AuthIntent intent;

  @override
  Future<AuthResult> signIn() async {
    final normalizedEmail = email.trim();
    final hasEmail = normalizedEmail.contains('@');

    if (intent == AuthIntent.resetPassword) {
      if (!hasEmail) {
        return const AuthResult(statusCode: 400);
      }

      return const AuthResult(statusCode: 202);
    }

    if (!hasEmail || password.trim().isEmpty) {
      return const AuthResult(statusCode: 400);
    }

    final statusCode = intent == AuthIntent.signUp ? 201 : 200;

    return AuthResult(
      statusCode: statusCode,
      session: AuthSession(email: normalizedEmail),
    );
  }
}

/// Stub dos provedores sociais. Não inicia OAuth.
class SocialAuthProvider implements AuthProvider {
  const SocialAuthProvider(this.social);

  final AuthSocial social;

  @override
  Future<AuthResult> signIn() async {
    return const AuthResult(statusCode: 501);
  }
}
