import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otzar/Controller/theme_controller.dart';
import 'package:otzar/Service/routes.dart';
import 'package:otzar/src/theme/app_text_theme.dart';
import 'package:otzar/src/theme/app_theme.dart';

class StartWidget extends ConsumerWidget {
  const StartWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = createTextTheme(context, 'Inter', 'Inter');

    return MaterialApp.router(
      title: 'Otzar',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(textTheme),
      darkTheme: AppTheme.dark(textTheme),
      themeMode: ref.watch(themeControllerProvider),
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
