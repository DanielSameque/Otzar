import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// Preferência de tema do usuário, persistida localmente.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const String _storageKey = 'theme_mode';

  @override
  ThemeMode build() {
    // A preferência é lida de forma assíncrona: a aplicação inicia seguindo o
    // sistema e ajusta o tema assim que o valor salvo é recuperado.
    unawaited(_restore());
    return ThemeMode.system;
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_storageKey, mode.name);
  }

  Future<void> _restore() async {
    final preferences = await SharedPreferences.getInstance();
    final stored = preferences.getString(_storageKey);

    final mode = switch (stored) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => null,
    };

    if (mode != null) {
      state = mode;
    }
  }
}
