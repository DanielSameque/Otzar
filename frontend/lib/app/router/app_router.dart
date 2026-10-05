import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view_models/auth_view_model.dart';
import '../../features/auth/presentation/views/auth_view.dart';
import '../../features/health/presentation/views/health_view.dart';
import '../../features/shell/presentation/views/app_shell_view.dart';
import '../../features/shell/presentation/views/section_placeholder_view.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen(authSessionProvider, (_, _) => refresh.value++);

  final router = GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: refresh,
    redirect: (context, state) {
      final loggedIn = ref.read(authSessionProvider) != null;
      final onLogin = state.matchedLocation == AppRoutes.login;

      if (!loggedIn && !onLogin) {
        return AppRoutes.login;
      }

      if (loggedIn && onLogin) {
        return AppRoutes.projetos;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => _fadePage(
          key: state.pageKey,
          child: const AuthView(),
        ),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => _fadePage(
          key: const ValueKey('app-shell'),
          child: AppShellView(child: child),
        ),
        routes: [
          GoRoute(
            path: AppRoutes.projetos,
            builder: (context, state) => const SectionPlaceholderView(
              description: 'A gestão de projetos ainda não foi implementada.',
            ),
          ),
          GoRoute(
            path: AppRoutes.tarefas,
            builder: (context, state) => const SectionPlaceholderView(
              description: 'A gestão de tarefas ainda não foi implementada.',
            ),
          ),
          GoRoute(
            path: AppRoutes.backlog,
            builder: (context, state) => const SectionPlaceholderView(
              description: 'O Backlog global ainda não foi implementado.',
            ),
          ),
          GoRoute(
            path: AppRoutes.baseDeConhecimento,
            builder: (context, state) => const SectionPlaceholderView(
              description: 'A Base de Conhecimento ainda não foi implementada.',
            ),
          ),
          GoRoute(
            path: AppRoutes.diagnostico,
            builder: (context, state) => const HealthView(),
          ),
        ],
      ),
    ],
  );

  ref.onDispose(router.dispose);

  return router;
});

CustomTransitionPage<void> _fadePage({required LocalKey key, required Widget child}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
