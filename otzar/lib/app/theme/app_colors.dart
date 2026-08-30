import 'package:flutter/material.dart';

/// Cores base da identidade visual do Otzar.
///
/// Todo o restante da paleta é derivado destas cores pelo algoritmo do
/// Material 3. Para trocar a identidade visual, altere [seed] ou substitua os
/// esquemas por uma paleta exportada do Material Theme Builder.
abstract final class AppColors {
  static const Color seed = Color.fromARGB(255, 247, 247, 247);

  static final ColorScheme light = ColorScheme.fromSeed(seedColor: seed);

  static final ColorScheme dark = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.dark,
  );
}
