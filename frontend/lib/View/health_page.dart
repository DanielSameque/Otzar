import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otzar/Controller/health_controller/health_controller.dart';
import 'package:otzar/Model/health_model/health_status_model.dart';
import 'package:otzar/Service/app_config.dart';
import 'package:otzar/Service/http_exceptions.dart';
import 'package:otzar/View/Componentes/app_error_view.dart';
import 'package:otzar/View/Componentes/app_loading.dart';

/// Verifica se o frontend consegue se comunicar com a API.
class HealthPage extends ConsumerWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final health = ref.watch(healthControllerProvider);

    return health.when(
      loading: () => const AppLoading(message: 'Consultando a API...'),
      error: (error, _) => AppErrorView(
        message: error is AppException
            ? error.message
            : 'Falha inesperada ao consultar a API.',
        onRetry: () => ref.read(healthControllerProvider.notifier).refresh(),
      ),
      data: (status) => _HealthDetails(
        status: status,
        onRefresh: () => ref.read(healthControllerProvider.notifier).refresh(),
      ),
    );
  }
}

class _HealthDetails extends StatelessWidget {
  const _HealthDetails({required this.status, required this.onRefresh});

  final HealthStatusModel status;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final databaseIsUp = status.database == 'up';

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  leading: Icon(Icons.cloud_done_outlined),
                  title: Text('API respondendo'),
                ),
                const Divider(height: 1),
                _HealthTile(label: 'Endereço', value: AppConfig.apiUrl),
                _HealthTile(label: 'Status', value: status.status),
                _HealthTile(
                  label: 'Banco de dados',
                  value: databaseIsUp ? 'conectado' : 'indisponível',
                  highlight: !databaseIsUp,
                ),
                _HealthTile(label: 'Consultado em', value: status.timestamp.toLocal().toString()),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.tonalIcon(
                      onPressed: onRefresh,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Consultar novamente'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HealthTile extends StatelessWidget {
  const _HealthTile({required this.label, required this.value, this.highlight = false});

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      title: Text(label, style: theme.textTheme.bodySmall),
      subtitle: Text(
        value,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: highlight ? theme.colorScheme.error : null,
        ),
      ),
    );
  }
}
