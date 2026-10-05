import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otzar/features/auth/domain/auth_code_snippet.dart';
import 'package:otzar/features/auth/domain/auth_provider.dart';
import 'package:otzar/features/auth/presentation/view_models/auth_view_model.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  AuthViewModel viewModel() => container.read(authViewModelProvider.notifier);

  test('login válido só abre sessão no commit', () async {
    final notifier = viewModel();
    notifier.setEmail('dev@otzar.dev');
    notifier.setPassword('segredo');

    await notifier.submit();

    expect(container.read(authViewModelProvider).statusCode, 200);
    expect(container.read(authSessionProvider), isNull);

    notifier.commitSession();

    expect(container.read(authSessionProvider)?.email, 'dev@otzar.dev');
  });

  test('criar conta devolve 201 e commit abre sessão', () async {
    final notifier = viewModel();
    notifier.setIntent(AuthIntent.signUp);
    notifier.setEmail('dev@otzar.dev');
    notifier.setPassword('segredo');

    await notifier.submit();

    expect(container.read(authViewModelProvider).statusCode, 201);

    notifier.commitSession();

    expect(container.read(authSessionProvider)?.email, 'dev@otzar.dev');
  });

  test('e-mail inválido devolve 400 e não abre sessão', () async {
    final notifier = viewModel();
    notifier.setEmail('invalido');
    notifier.setPassword('segredo');

    await notifier.submit();
    notifier.commitSession();

    expect(container.read(authViewModelProvider).statusCode, 400);
    expect(container.read(authSessionProvider), isNull);
  });

  test('provedor social devolve 501 e não abre sessão', () async {
    await viewModel().signInWithSocial(AuthSocial.github);

    expect(container.read(authViewModelProvider).statusCode, 501);
    expect(container.read(authSessionProvider), isNull);
  });

  test('recuperação de senha devolve 202 e não abre sessão', () async {
    final notifier = viewModel();
    notifier.setIntent(AuthIntent.resetPassword);
    notifier.setEmail('dev@otzar.dev');

    await notifier.submit();
    notifier.commitSession();

    expect(container.read(authViewModelProvider).statusCode, 202);
    expect(container.read(authSessionProvider), isNull);
  });

  test('sair da senha com mais de 3 caracteres completa a segunda metade', () {
    final notifier = viewModel();
    notifier.setPassword('1234');

    expect(container.read(authViewModelProvider).passwordFocused, isTrue);

    notifier.unfocusPassword();

    final state = container.read(authViewModelProvider);
    final progress = AuthCodeSnippet.passwordRevealProgress(
      length: state.password.length,
      focused: state.passwordFocused,
    );

    expect(state.passwordFocused, isFalse);
    expect(progress, 1);

    notifier.setPassword('123');

    final editing = container.read(authViewModelProvider);
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
    final notifier = viewModel();
    notifier.setEmail('dev@otzar.dev');
    notifier.setPassword('segredo');
    await notifier.submit();

    notifier.setEmail('outro@otzar.dev');
    notifier.commitSession();

    expect(container.read(authViewModelProvider).statusCode, isNull);
    expect(container.read(authSessionProvider), isNull);
  });
}
