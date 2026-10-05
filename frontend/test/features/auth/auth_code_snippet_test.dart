import 'package:flutter_test/flutter_test.dart';
import 'package:otzar/features/auth/domain/auth_code_snippet.dart';

void main() {
  const emailHalf = AuthCodeSnippet.halfEmail;
  const passwordHalf = AuthCodeSnippet.halfPassword;

  test('e-mail revela só a primeira metade', () {
    final text = AuthCodeSnippet.reveal(
      emailLength: AuthCodeSnippet.emailReferenceLength,
      passwordLength: 0,
    );

    expect(text, emailHalf);
    expect(text.contains('if (!res.ok)'), isFalse);
  });

  test('senha revela só a segunda metade', () {
    final text = AuthCodeSnippet.reveal(
      emailLength: 0,
      passwordLength: AuthCodeSnippet.passwordReferenceLength,
    );

    expect(text, passwordHalf);
    expect(text.contains('const otzar'), isFalse);
  });

  test('as metades se somam e apagar recua', () {
    final full = AuthCodeSnippet.reveal(
      emailLength: AuthCodeSnippet.emailReferenceLength,
      passwordLength: AuthCodeSnippet.passwordReferenceLength,
    );

    expect(full, '$emailHalf\n$passwordHalf');

    final cleared = AuthCodeSnippet.reveal(emailLength: 0, passwordLength: 0);

    expect(cleared, isEmpty);
  });

  test('o progresso é proporcional ao tamanho digitado', () {
    const length = AuthCodeSnippet.emailReferenceLength ~/ 2;
    final progress = AuthCodeSnippet.progressFor(
      length,
      AuthCodeSnippet.emailReferenceLength,
    );
    final half = AuthCodeSnippet.reveal(emailLength: length, passwordLength: 0);

    expect(half, emailHalf.substring(0, (emailHalf.length * progress).round()));
    expect(half.length, lessThan(emailHalf.length));
  });

  test('sair do campo com mais de 3 caracteres completa a metade da senha', () {
    final completed = AuthCodeSnippet.passwordRevealProgress(
      length: AuthCodeSnippet.passwordCompleteMinLength + 1,
      focused: false,
    );
    final text = AuthCodeSnippet.revealProgress(
      emailProgress: 0,
      passwordProgress: completed,
    );

    expect(completed, 1);
    expect(text, passwordHalf);
  });

  test('com o campo em foco a senha continua proporcional', () {
    const length = AuthCodeSnippet.passwordCompleteMinLength + 1;
    final editing = AuthCodeSnippet.passwordRevealProgress(
      length: length,
      focused: true,
    );

    expect(editing, lessThan(1));
    expect(
      editing,
      AuthCodeSnippet.progressFor(
        length,
        AuthCodeSnippet.passwordReferenceLength,
      ),
    );
  });

  test('sair do campo com até 3 caracteres não completa a metade da senha', () {
    final progress = AuthCodeSnippet.passwordRevealProgress(
      length: AuthCodeSnippet.passwordCompleteMinLength,
      focused: false,
    );

    expect(progress, lessThan(1));
  });

  test('o status substitui o marcador e aparece mesmo sem senha', () {
    final revealed = AuthCodeSnippet.reveal(
      emailLength: AuthCodeSnippet.emailReferenceLength,
      passwordLength: AuthCodeSnippet.passwordReferenceLength,
      statusCode: 200,
    );

    expect(revealed.contains('// status: ___'), isFalse);
    expect(revealed.endsWith('// status: 200'), isTrue);

    final forced = AuthCodeSnippet.reveal(
      emailLength: 0,
      passwordLength: 0,
      statusCode: 400,
    );

    expect(forced, '// status: 400');
  });
}
