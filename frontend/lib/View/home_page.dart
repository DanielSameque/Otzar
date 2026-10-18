import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:otzar/Controller/theme_controller.dart';
import 'package:otzar/Service/routes.dart';
import 'package:otzar/View/Componentes/app_navigation.dart';

/// Layout persistente da aplicação (shell): barra superior e navegação principal.
class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.child});

  /// Tela da rota atual.
  final Widget child;

  static const double _railBreakpoint = 840;
  static const double _extendedRailBreakpoint = 1200;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = AppDestinations.indexOf(location);
    final width = MediaQuery.sizeOf(context).width;
    final showRail = width >= _railBreakpoint;

    void goTo(int index) {
      Navigator.maybePop(context);
      context.go(AppDestinations.primary[index].route);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppDestinations.titleFor(location)),
        actions: [
          IconButton(
            onPressed: () => _toggleTheme(context, ref),
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            tooltip: 'Alternar tema',
          ),
          IconButton(
            onPressed: () => context.go(AppRoutes.diagnostico),
            icon: const Icon(Icons.monitor_heart_outlined),
            tooltip: 'Diagnóstico',
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: showRail
          ? null
          : AppNavigationDrawer(selectedIndex: selectedIndex, onDestinationSelected: goTo),
      body: showRail
          ? Row(
              children: [
                AppNavigationRail(
                  selectedIndex: selectedIndex,
                  extended: width >= _extendedRailBreakpoint,
                  onDestinationSelected: goTo,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: child),
              ],
            )
          : child,
    );
  }

  void _toggleTheme(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref
        .read(themeControllerProvider.notifier)
        .setMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}
