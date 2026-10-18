import 'package:flutter/material.dart';
import 'package:otzar/View/Componentes/app_empty_view.dart';

/// Tela provisória das seções do MVP ainda não implementadas.
///
/// Existe apenas para validar a navegação da fundação e deve ser substituída
/// pela Page real de cada módulo.
class SectionPlaceholderPage extends StatelessWidget {
  const SectionPlaceholderPage({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return AppEmptyView(message: description, icon: Icons.construction_outlined);
  }
}
