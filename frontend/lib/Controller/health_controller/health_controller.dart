import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otzar/Model/health_model/health_status_model.dart';
import 'package:otzar/Service/health_service/health_service.dart';

final healthControllerProvider = AsyncNotifierProvider<HealthController, HealthStatusModel>(
  HealthController.new,
);

class HealthController extends AsyncNotifier<HealthStatusModel> {
  @override
  Future<HealthStatusModel> build() => ref.watch(healthServiceProvider).fetchStatus();

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(healthServiceProvider).fetchStatus());
  }
}
