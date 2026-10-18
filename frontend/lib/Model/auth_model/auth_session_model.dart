/// Sessão em memória da jornada de autenticação.
///
/// Não guarda token e não persiste. Some quando o processo encerra.
class AuthSessionModel {
  const AuthSessionModel({required this.email});

  final String email;
}
