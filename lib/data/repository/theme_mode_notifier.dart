import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'user_preferences_repository.dart';

part 'theme_mode_notifier.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    return ref.watch(userPreferencesRepositoryProvider).themeMode;
  }

  Future<void> setMode(ThemeMode mode) async {
    await ref.read(userPreferencesRepositoryProvider).setThemeMode(mode);
    state = mode;
  }
}
