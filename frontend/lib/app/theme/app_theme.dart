import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Temas claro e escuro do Otzar.
///
/// As telas devem obter cores e tipografia a partir de `Theme.of(context)`.
/// Nenhuma cor deve ser escrita diretamente nas features.
abstract final class AppTheme {
  static ThemeData light(TextTheme textTheme) =>
      _themeFor(AppColors.light, textTheme);

  static ThemeData dark(TextTheme textTheme) =>
      _themeFor(AppColors.dark, textTheme);

  static ThemeData _themeFor(ColorScheme colorScheme, TextTheme textTheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      // O Otzar prioriza desktop e web, onde a densidade adaptativa aproveita
      // melhor o espaço disponível.
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarThemeData(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      inputDecorationTheme: const InputDecorationThemeData(
        border: OutlineInputBorder(),
        filled: true,
      ),
    );
  }
}
