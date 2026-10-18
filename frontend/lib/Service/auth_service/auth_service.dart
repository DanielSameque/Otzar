import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otzar/Model/auth_model/auth_model.dart';
import 'package:otzar/Repository/auth_repository/auth_repository.dart';

final authServiceProvider = Provider<AuthService>((ref) => const AuthService());

/// Operações da jornada de autenticação.
class AuthService {
  const AuthService();

  Future<AuthResultModel> signIn({
    required String email,
    required String password,
    required AuthIntent intent,
  }) {
    return EmailPasswordAuthRepository(
      email: email,
      password: password,
      intent: intent,
    ).signIn();
  }

  Future<AuthResultModel> signInWithSocial(AuthSocial social) {
    return SocialAuthRepository(social).signIn();
  }
}
