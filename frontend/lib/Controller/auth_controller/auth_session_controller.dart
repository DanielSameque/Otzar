import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otzar/Model/auth_model/auth_session_model.dart';

/// Sessão corrente. `null` mantém o usuário na jornada de login.
final authSessionProvider = NotifierProvider<AuthSessionController, AuthSessionModel?>(
  AuthSessionController.new,
);

class AuthSessionController extends Notifier<AuthSessionModel?> {
  @override
  AuthSessionModel? build() => null;

  void establish(AuthSessionModel session) => state = session;

  void clear() => state = null;
}
