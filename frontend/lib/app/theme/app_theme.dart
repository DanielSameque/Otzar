import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Temas claro e escuro do Otzar.
///
/// As telas devem obter cores e tipografia a partir de `Theme.of(context)`.
/// Nenhuma cor deve ser escrita diretamente nas features.
abstract final class AppTheme {
  static final ThemeData light = _themeFor(AppColors.light);

  static final ThemeData dark = _themeFor(AppColors.dark);

  static ThemeData _themeFor(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
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
