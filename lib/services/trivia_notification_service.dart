import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:civis_web/data/repository/user_preferences_repository.dart';
import 'package:go_router/go_router.dart';
import 'notification_strategy.dart';

final triviaNotificationServiceProvider = Provider<TriviaNotificationService>((
  ref,
) {
  final prefs = ref.watch(userPreferencesRepositoryProvider);
  return TriviaNotificationService(prefs);
});

class TriviaNotificationService {
  final UserPreferencesRepository _prefs;
  Timer? _timer;
  bool _initialized = false;
  GoRouter? _router; // Need a router reference to navigate
  final NotificationStrategy _strategy = NotificationStrategy();

  TriviaNotificationService(this._prefs);

  void init(GoRouter router) {
    if (_initialized) return;
    _initialized = true;
    _router = router;

    // Check immediately on startup
    _checkAndShowNotification();

    // Check periodically (e.g., every minute)
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkAndShowNotification();
    });
  }

  void showManualNotification() {
    _checkAndShowNotification(force: true);
  }

  void _checkAndShowNotification({bool force = false}) async {
    if (!_prefs.isTriviaEnabled && !force) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    final lastTime = _prefs.lastTriviaTime;
    final frequencyMs = _prefs.triviaFrequencyMinutes * 60 * 1000;

    // Only show if the elapsed time is greater than the frequency (unless forced)
    if (force || (now - lastTime >= frequencyMs)) {
      bool canShow = false;

      // Check notification permissions via strategy
      canShow = await _strategy.requestPermissions();

      if (canShow) {
        // Prevent showing multiple notifications if the user hasn't clicked it
        await _prefs.setLastTriviaTime(now);

        _strategy.showNotification(
          title: 'Civis Daily Trivia',
          body: 'It\'s time for your next trivia question. Click to practice!',
          router: _router,
        );
      }
    }
  }

  void dispose() {
    _timer?.cancel();
    _initialized = false;
  }
}
