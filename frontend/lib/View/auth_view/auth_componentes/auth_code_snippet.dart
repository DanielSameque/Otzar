/// Snippet JavaScript revelado no painel enquanto o usuário digita.
///
/// A metade do e-mail e a metade da senha avançam e recuam de forma
/// independente. Ao sair do campo, uma senha com mais de
/// [passwordCompleteMinLength] caracteres revela [halfPassword] inteira.
/// O marcador `___` vira o status HTTP quando há resultado.
abstract final class AuthCodeSnippet {
  static const int emailReferenceLength = 15;
  static const int passwordReferenceLength = 6;

  /// Acima deste tamanho, sair do campo de senha completa [halfPassword].
  static const int passwordCompleteMinLength = 2;

  static const String halfEmail = '''const otzar = {
  user: null,
  async signIn({ email, password }) {
    const res = await fetch('/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password }),
    });''';

  static const String halfPassword =
      r'''    if (!res.ok) throw new Error(`auth_failed:${res.status}`);
    const session = await res.json();
    otzar.user = session.user;
    console.log('Otzar unlocked');
    return { status: res.status, session };
  },
};
await otzar.signIn(credentials);
// status: ___''';

  static double progressFor(int length, int reference) {
    if (reference <= 0) {
      return 0;
    }

    return (length / reference).clamp(0.0, 1.0).toDouble();
  }

  /// Progresso de [halfPassword].
  ///
  /// Com o campo em foco, o avanço é proporcional a [passwordReferenceLength].
  /// Fora de foco, senhas maiores que [passwordCompleteMinLength] ficam em 1.
  static double passwordRevealProgress({
    required int length,
    required bool focused,
  }) {
    if (!focused && length > passwordCompleteMinLength) {
      return 1;
    }

    return progressFor(length, passwordReferenceLength);
  }

  static String reveal({
    required int emailLength,
    required int passwordLength,
    int? statusCode,
  }) {
    return revealProgress(
      emailProgress: progressFor(emailLength, emailReferenceLength),
      passwordProgress: progressFor(passwordLength, passwordReferenceLength),
      statusCode: statusCode,
    );
  }

  static String revealProgress({
    required double emailProgress,
    required double passwordProgress,
    int? statusCode,
  }) {
    final first = _slice(halfEmail, emailProgress);
    final second = _slice(halfPassword, passwordProgress);
    final buffer = StringBuffer();

    if (first.isNotEmpty) {
      buffer.write(first);
    }

    if (second.isNotEmpty) {
      if (buffer.isNotEmpty) {
        buffer.writeln();
      }
      buffer.write(second);
    }

    return _applyStatus(buffer.toString(), statusCode);
  }

  static String _slice(String source, double progress) {
    final bounded = progress.clamp(0.0, 1.0).toDouble();
    final count = (source.length * bounded).round();

    return source.substring(0, count);
  }

  static String _applyStatus(String text, int? statusCode) {
    if (statusCode == null) {
      return text;
    }

    final line = '// status: $statusCode';
    final marker = text.indexOf('// status:');

    if (marker >= 0) {
      return text.replaceRange(marker, text.length, line);
    }

    final partial = _trailingStatusPrefix(text);
    final trimmed = partial == 0
        ? text
        : text.substring(0, text.length - partial);
    if (trimmed.isEmpty) {
      return line;
    }

    final separator = trimmed.endsWith('\n') ? '' : '\n';

    return '$trimmed$separator$line';
  }

  /// Caracteres finais que são um prefixo incompleto de `// status:`.
  static int _trailingStatusPrefix(String text) {
    const marker = '// status:';

    for (var length = marker.length - 1; length > 0; length--) {
      if (text.endsWith(marker.substring(0, length))) {
        return length;
      }
    }

    return 0;
  }
}
