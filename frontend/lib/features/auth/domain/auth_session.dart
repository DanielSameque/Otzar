/// Sessão em memória da jornada de autenticação.
///
/// Não guarda token e não persiste. Some quando o processo encerra.
class AuthSession {
  const AuthSession({required this.email});

  final String email;
}
