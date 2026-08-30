import 'package:flutter/material.dart';

import '../../../../core/widgets/app_empty_view.dart';

/// Tela provisória das seções do MVP ainda não implementadas.
///
/// Existe apenas para validar a navegação da fundação e deve ser substituída
/// pela View real de cada Feature.
class SectionPlaceholderView extends StatelessWidget {
  const SectionPlaceholderView({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return AppEmptyView(message: description, icon: Icons.construction_outlined);
  }
}
