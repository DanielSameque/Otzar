import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otzar/Controller/auth_controller/auth_controller.dart';
import 'package:otzar/Controller/auth_controller/auth_session_controller.dart';
import 'package:otzar/Model/auth_model/auth_model.dart';
import 'package:otzar/View/auth_view/auth_componentes/auth_code_snippet.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  AuthController controller() => container.read(authControllerProvider.notifier);

  test('login válido só abre sessão no commit', () async {
    final notifier = controller();
    notifier.setEmail('dev@otzar.dev');
    notifier.setPassword('segredo');

    await notifier.submit();

    expect(container.read(authControllerProvider).statusCode, 200);
    expect(container.read(authSessionProvider), isNull);

    notifier.commitSession();

    expect(container.read(authSessionProvider)?.email, 'dev@otzar.dev');
  });

  test('criar conta devolve 201 e commit abre sessão', () async {
    final notifier = controller();
    notifier.setIntent(AuthIntent.signUp);
    notifier.setEmail('dev@otzar.dev');
    notifier.setPassword('segredo');

    await notifier.submit();

    expect(container.read(authControllerProvider).statusCode, 201);

    notifier.commitSession();

    expect(container.read(authSessionProvider)?.email, 'dev@otzar.dev');
  });

  test('e-mail inválido devolve 400 e não abre sessão', () async {
    final notifier = controller();
    notifier.setEmail('invalido');
    notifier.setPassword('segredo');

    await notifier.submit();
    notifier.commitSession();

    expect(container.read(authControllerProvider).statusCode, 400);
    expect(container.read(authSessionProvider), isNull);
  });

  test('provedor social devolve 501 e não abre sessão', () async {
    await controller().signInWithSocial(AuthSocial.github);

    expect(container.read(authControllerProvider).statusCode, 501);
    expect(container.read(authSessionProvider), isNull);
  });

  test('recuperação de senha devolve 202 e não abre sessão', () async {
    final notifier = controller();
    notifier.setIntent(AuthIntent.resetPassword);
    notifier.setEmail('dev@otzar.dev');

    await notifier.submit();
    notifier.commitSession();

    expect(container.read(authControllerProvider).statusCode, 202);
    expect(container.read(authSessionProvider), isNull);
  });

  test('sair da senha com mais de 3 caracteres completa a segunda metade', () {
    final notifier = controller();
    notifier.setPassword('1234');

    expect(container.read(authControllerProvider).passwordFocused, isTrue);

    notifier.unfocusPassword();

    final state = container.read(authControllerProvider);
    final progress = AuthCodeSnippet.passwordRevealProgress(
      length: state.password.length,
      focused: state.passwordFocused,
    );

    expect(state.passwordFocused, isFalse);
    expect(progress, 1);

    notifier.setPassword('123');

    final editing = container.read(authControllerProvider);
    expect(editing.passwordFocused, isTrue);
    expect(
      AuthCodeSnippet.passwordRevealProgress(
        length: editing.password.length,
        focused: editing.passwordFocused,
      ),
      lessThan(1),
    );
  });

  test('editar o e-mail depois do sucesso cancela a sessão pendente', () async {
    final notifier = controller();
    notifier.setEmail('dev@otzar.dev');
    notifier.setPassword('segredo');
    await notifier.submit();

    notifier.setEmail('outro@otzar.dev');
    notifier.commitSession();

    expect(container.read(authControllerProvider).statusCode, isNull);
    expect(container.read(authSessionProvider), isNull);
  });
}
