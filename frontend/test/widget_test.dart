import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otzar/app/app.dart';
import 'package:otzar/features/auth/domain/auth_session.dart';
import 'package:otzar/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('depois do splash mostra o login', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: OtzarApp()));
    await tester.pump(const Duration(milliseconds: 1700));
    await tester.pump();

    expect(find.text('Bem-vindo'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('sair da senha com mais de 3 caracteres completa o código', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: OtzarApp()));
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.enterText(find.widgetWithText(TextField, 'Senha'), '1234');
    await tester.pump();

    expect(find.textContaining('await otzar.signIn'), findsNothing);

    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.textContaining('await otzar.signIn'), findsOneWidget);
  });

  testWidgets('com sessão inicia na seção Projetos', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authSessionProvider.overrideWith(_SignedInSession.new)],
        child: const OtzarApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Projetos'), findsOneWidget);
    expect(
      find.text('A gestão de projetos ainda não foi implementada.'),
      findsOneWidget,
    );
  });
}

class _SignedInSession extends AuthSessionNotifier {
  @override
  AuthSession? build() => const AuthSession(email: 'dev@otzar.dev');
}
