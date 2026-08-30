import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/health_status.dart';
import '../../data/repositories/health_repository.dart';

final healthViewModelProvider = AsyncNotifierProvider<HealthViewModel, HealthStatus>(
  HealthViewModel.new,
);

class HealthViewModel extends AsyncNotifier<HealthStatus> {
  @override
  Future<HealthStatus> build() => ref.watch(healthRepositoryProvider).fetch();

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(healthRepositoryProvider).fetch());
  }
}
