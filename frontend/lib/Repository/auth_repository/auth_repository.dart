import 'package:otzar/Model/auth_model/auth_model.dart';
import 'package:otzar/Model/auth_model/auth_session_model.dart';

/// Ponto de extensão da autenticação.
///
/// E-mail/senha e os botões sociais implementam este contrato. OAuth real
/// entra depois, trocando o stub sem mudar a tela.
abstract class IAuthRepository {
  Future<AuthResultModel> signIn();
}

/// Stub local de e-mail e senha. Não chama a API.
class EmailPasswordAuthRepository implements IAuthRepository {
  const EmailPasswordAuthRepository({
    required this.email,
    required this.password,
    required this.intent,
  });

  final String email;
  final String password;
  final AuthIntent intent;

  @override
  Future<AuthResultModel> signIn() async {
    final normalizedEmail = email.trim();
    final hasEmail = normalizedEmail.contains('@');

    if (intent == AuthIntent.resetPassword) {
      if (!hasEmail) {
        return const AuthResultModel(statusCode: 400);
      }

      return const AuthResultModel(statusCode: 202);
    }

    if (!hasEmail || password.trim().isEmpty) {
      return const AuthResultModel(statusCode: 400);
    }

    final statusCode = intent == AuthIntent.signUp ? 201 : 200;

    return AuthResultModel(
      statusCode: statusCode,
      session: AuthSessionModel(email: normalizedEmail),
    );
  }
}

/// Stub dos provedores sociais. Não inicia OAuth.
class SocialAuthRepository implements IAuthRepository {
  const SocialAuthRepository(this.social);

  final AuthSocial social;

  @override
  Future<AuthResultModel> signIn() async {
    return const AuthResultModel(statusCode: 501);
  }
}
