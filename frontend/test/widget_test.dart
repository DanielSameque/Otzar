import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otzar/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('inicia na seção Projetos com a navegação principal', (tester) async {
    // Arrange
    SharedPreferences.setMockInitialValues({});

    // Act
    await tester.pumpWidget(const ProviderScope(child: OtzarApp()));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Projetos'), findsOneWidget);
    expect(find.text('A gestão de projetos ainda não foi implementada.'), findsOneWidget);
  });
}
