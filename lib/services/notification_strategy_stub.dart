import 'package:go_router/go_router.dart';
import 'notification_strategy.dart';

NotificationStrategy getNotificationStrategy() => NotificationStrategyStub();

class NotificationStrategyStub implements NotificationStrategy {
  @override
  Future<bool> requestPermissions() async => false;

  @override
  void showNotification({
    required String title,
    required String body,
    required GoRouter? router,
  }) {
    // No-op for non-web platforms in this web-specific project
  }
}
