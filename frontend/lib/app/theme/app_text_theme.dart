import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Monta a tipografia do Otzar com fontes do Google Fonts.
///
/// [bodyFont] é aplicada aos estilos de corpo e rótulo; [displayFont] aos
/// demais estilos de exibição.
TextTheme createTextTheme(
  BuildContext context,
  String bodyFont,
  String displayFont,
) {
  final baseTextTheme = Theme.of(context).textTheme;
  final bodyTextTheme = GoogleFonts.getTextTheme(bodyFont, baseTextTheme);
  final displayTextTheme = GoogleFonts.getTextTheme(displayFont, baseTextTheme);

  return displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
}
