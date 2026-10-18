import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:otzar/Controller/auth_controller/auth_session_controller.dart';
import 'package:otzar/View/auth_view/auth_page.dart';
import 'package:otzar/View/health_page.dart';
import 'package:otzar/View/home_page.dart';
import 'package:otzar/View/section_placeholder_page.dart';

/// Caminhos das rotas da aplicação.
abstract final class AppRoutes {
  static const String login = '/login';
  static const String projetos = '/projetos';
  static const String tarefas = '/tarefas';
  static const String backlog = '/backlog';
  static const String baseDeConhecimento = '/base-de-conhecimento';
  static const String diagnostico = '/diagnostico';
}

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
          child: const AuthPage(),
        ),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => _fadePage(
          key: const ValueKey('app-shell'),
          child: HomePage(child: child),
        ),
        routes: [
          GoRoute(
            path: AppRoutes.projetos,
            builder: (context, state) => const SectionPlaceholderPage(
              description: 'A gestão de projetos ainda não foi implementada.',
            ),
          ),
          GoRoute(
            path: AppRoutes.tarefas,
            builder: (context, state) => const SectionPlaceholderPage(
              description: 'A gestão de tarefas ainda não foi implementada.',
            ),
          ),
          GoRoute(
            path: AppRoutes.backlog,
            builder: (context, state) => const SectionPlaceholderPage(
              description: 'O Backlog global ainda não foi implementado.',
            ),
          ),
          GoRoute(
            path: AppRoutes.baseDeConhecimento,
            builder: (context, state) => const SectionPlaceholderPage(
              description: 'A Base de Conhecimento ainda não foi implementada.',
            ),
          ),
          GoRoute(
            path: AppRoutes.diagnostico,
            builder: (context, state) => const HealthPage(),
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
