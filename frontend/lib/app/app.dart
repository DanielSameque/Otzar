import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';
import 'theme/app_text_theme.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_notifier.dart';

class OtzarApp extends ConsumerWidget {
  const OtzarApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = createTextTheme(context, 'Inter', 'Inter');

    return MaterialApp.router(
      title: 'Otzar',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(textTheme),
      darkTheme: AppTheme.dark(textTheme),
      themeMode: ref.watch(themeModeProvider),
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
