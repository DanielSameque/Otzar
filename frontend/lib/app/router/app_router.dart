import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/health/presentation/views/health_view.dart';
import '../../features/shell/presentation/views/app_shell_view.dart';
import '../../features/shell/presentation/views/section_placeholder_view.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.projetos,
    // As rotas protegidas e o redirecionamento para o login serão configurados
    // aqui quando a Feature de Autenticação existir.
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShellView(child: child),
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
});
