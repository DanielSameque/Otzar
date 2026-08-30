import 'package:flutter/material.dart';

import '../../../../app/router/app_routes.dart';

/// Item da navegação principal do Otzar.
class AppDestination {
  const AppDestination({
    required this.route,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String route;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Navegação principal, organizada por contexto conforme `docs/06-ui-ux.md`.
///
/// Kanban e demais visualizações não são itens de navegação: são formas de
/// exibir as tarefas dentro do próprio módulo.
abstract final class AppDestinations {
  static const List<AppDestination> primary = [
    AppDestination(
      route: AppRoutes.projetos,
      label: 'Projetos',
      icon: Icons.folder_outlined,
      selectedIcon: Icons.folder,
    ),
    AppDestination(
      route: AppRoutes.tarefas,
      label: 'Tarefas',
      icon: Icons.check_circle_outline,
      selectedIcon: Icons.check_circle,
    ),
    AppDestination(
      route: AppRoutes.backlog,
      label: 'Backlog',
      icon: Icons.list_alt_outlined,
      selectedIcon: Icons.list_alt,
    ),
    AppDestination(
      route: AppRoutes.baseDeConhecimento,
      label: 'Base de Conhecimento',
      icon: Icons.menu_book_outlined,
      selectedIcon: Icons.menu_book,
    ),
  ];

  /// Índice do item correspondente à rota atual, ou `null` quando a tela não
  /// pertence à navegação principal.
  static int? indexOf(String location) {
    final index = primary.indexWhere((destination) => location.startsWith(destination.route));

    return index == -1 ? null : index;
  }

  static String titleFor(String location) {
    if (location.startsWith(AppRoutes.diagnostico)) {
      return 'Diagnóstico';
    }

    final index = indexOf(location);

    return index == null ? 'Otzar' : primary[index].label;
  }
}

/// Navegação lateral usada em telas largas.
class AppNavigationRail extends StatelessWidget {
  const AppNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.extended,
    required this.onDestinationSelected,
  });

  final int? selectedIndex;
  final bool extended;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      extended: extended,
      labelType: extended ? null : NavigationRailLabelType.all,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        for (final destination in AppDestinations.primary)
          NavigationRailDestination(
            icon: Icon(destination.icon),
            selectedIcon: Icon(destination.selectedIcon),
            label: Text(destination.label),
          ),
      ],
    );
  }
}

/// Navegação em gaveta usada em telas estreitas.
class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int? selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 24, 16, 16),
          child: Text('Otzar', style: Theme.of(context).textTheme.titleLarge),
        ),
        for (final destination in AppDestinations.primary)
          NavigationDrawerDestination(
            icon: Icon(destination.icon),
            selectedIcon: Icon(destination.selectedIcon),
            label: Text(destination.label),
          ),
      ],
    );
  }
}
