import 'package:go_router/go_router.dart';
import 'notification_strategy_stub.dart'
    if (dart.library.html) 'notification_strategy_web.dart';

abstract class NotificationStrategy {
  factory NotificationStrategy() => getNotificationStrategy();

  Future<bool> requestPermissions();
  void showNotification({
    required String title,
    required String body,
    required GoRouter? router,
  });
}
