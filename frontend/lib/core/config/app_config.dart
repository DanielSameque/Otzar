/// Configuração do ambiente da aplicação.
///
/// Os valores são injetados no build, nunca versionados:
///
/// ```powershell
/// flutter run -d chrome --dart-define=API_URL=http://localhost:3000
/// ```
abstract final class AppConfig {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:3000',
  );
}
