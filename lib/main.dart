import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/theme/theme.dart';
import 'ui/router.dart';
import 'data/repository/user_preferences_repository.dart';
import 'data/repository/theme_mode_notifier.dart';
import 'services/trivia_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const CivisApp(),
    ),
  );
}

class CivisApp extends ConsumerWidget {
  const CivisApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final currentThemeMode = ref.watch(themeModeProvider);

    // Initialize trivia notification service
    ref.listenManual(triviaNotificationServiceProvider, (_, service) {
      service.init(router);
    }, fireImmediately: true);

    return MaterialApp.router(
      title: 'Civis',
      theme: civisTheme(false),
      darkTheme: civisTheme(true),
      themeMode: currentThemeMode,
      routerConfig: router,
    );
  }
}
