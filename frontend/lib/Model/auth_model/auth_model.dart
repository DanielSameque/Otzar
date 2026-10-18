import 'package:otzar/Model/auth_model/auth_session_model.dart';

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
class AuthResultModel {
  const AuthResultModel({required this.statusCode, this.session});

  final int statusCode;
  final AuthSessionModel? session;
}
