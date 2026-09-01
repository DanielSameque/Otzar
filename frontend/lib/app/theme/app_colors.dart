import 'package:flutter/material.dart';

/// Esquemas de cores do Otzar exportados do Material Theme Builder.
///
/// Para trocar a identidade visual, substitua [lightScheme] e [darkScheme]
/// por uma nova paleta exportada. As Features nunca escrevem cores diretamente:
/// obtêm tudo de `Theme.of(context)`.
abstract final class AppColors {
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5b5c5c),
      surfaceTint: Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff747474),
      onPrimaryContainer: Color(0xfffefcfc),
      secondary: Color(0xff5f5e5e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe4e2e1),
      onSecondaryContainer: Color(0xff656464),
      tertiary: Color(0xff5e5b5d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff777375),
      onTertiaryContainer: Color(0xfffffbff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff444748),
      outline: Color(0xff747878),
      outlineVariant: Color(0xffc4c7c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc7c6c6),
      primaryFixed: Color(0xffe3e2e2),
      onPrimaryFixed: Color(0xff1b1c1c),
      primaryFixedDim: Color(0xffc7c6c6),
      onPrimaryFixedVariant: Color(0xff464747),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c5),
      onSecondaryFixedVariant: Color(0xff474746),
      tertiaryFixed: Color(0xffe7e1e3),
      onTertiaryFixed: Color(0xff1d1b1d),
      tertiaryFixedDim: Color(0xffcac5c7),
      onTertiaryFixedVariant: Color(0xff494648),
      surfaceDim: Color(0xffddd9d8),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc7c6c6),
      surfaceTint: Color(0xffc7c6c6),
      onPrimary: Color(0xff303031),
      primaryContainer: Color(0xff919190),
      onPrimaryContainer: Color(0xff161718),
      secondary: Color(0xffc8c6c5),
      onSecondary: Color(0xff303030),
      secondaryContainer: Color(0xff474746),
      onSecondaryContainer: Color(0xffb7b5b4),
      tertiary: Color(0xffcac5c7),
      onTertiary: Color(0xff323031),
      tertiaryContainer: Color(0xff948f91),
      onTertiaryContainer: Color(0xff181718),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc4c7c7),
      outline: Color(0xff8e9192),
      outlineVariant: Color(0xff444748),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff5e5e5e),
      primaryFixed: Color(0xffe3e2e2),
      onPrimaryFixed: Color(0xff1b1c1c),
      primaryFixedDim: Color(0xffc7c6c6),
      onPrimaryFixedVariant: Color(0xff464747),
      secondaryFixed: Color(0xffe4e2e1),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c5),
      onSecondaryFixedVariant: Color(0xff474746),
      tertiaryFixed: Color(0xffe7e1e3),
      onTertiaryFixed: Color(0xff1d1b1d),
      tertiaryFixedDim: Color(0xffcac5c7),
      onTertiaryFixedVariant: Color(0xff494648),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  static ColorScheme get light => lightScheme();

  static ColorScheme get dark => darkScheme();
}
