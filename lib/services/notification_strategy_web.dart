// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use, uri_does_not_exist
import 'dart:html' as html;
import 'dart:js_util' as js_util;
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'notification_strategy.dart';

NotificationStrategy getNotificationStrategy() => NotificationStrategyWeb();

class NotificationStrategyWeb implements NotificationStrategy {
  @override
  Future<bool> requestPermissions() async {
    final isSecure = html.window.isSecureContext ?? false;
    debugPrint("NotificationStrategyWeb: isSecureContext = $isSecure");
    debugPrint(
      "NotificationStrategyWeb: Current permission = ${html.Notification.permission}",
    );

    if (!isSecure && html.window.location.hostname != 'localhost') {
      debugPrint(
        "NotificationStrategyWeb: Notifications blocked due to insecure context (not localhost/HTTPS)",
      );
      return false;
    }

    if (html.Notification.permission == 'granted') {
      return true;
    } else if (html.Notification.permission != 'denied') {
      try {
        final permission = await html.Notification.requestPermission();
        debugPrint(
          "NotificationStrategyWeb: Permission request result = $permission",
        );
        return permission == 'granted';
      } catch (e) {
        debugPrint("NotificationStrategyWeb: Error requesting permission: $e");
        return false;
      }
    }
    return false;
  }

  @override
  void showNotification({
    required String title,
    required String body,
    required GoRouter? router,
  }) async {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    final isMobile =
        userAgent.contains("mobile") ||
        userAgent.contains("android") ||
        userAgent.contains("iphone");

    debugPrint(
      "NotificationStrategyWeb: Showing notification. isMobile: $isMobile",
    );

    try {
      if (isMobile) {
        // Mobile (Chrome Android) requires Service Worker
        debugPrint("NotificationStrategyWeb: Using ServiceWorker strategy");
        final swReg = await html.window.navigator.serviceWorker?.ready;
        if (swReg != null) {
          js_util.callMethod(swReg, 'showNotification', [
            title,
            js_util.jsify({
              'dir': 'auto',
              'icon': 'favicon.png',
              'body': body,
              'badge': 'favicon.png',
              'tag': 'daily-trivia',
            }),
          ]);
          debugPrint(
            "NotificationStrategyWeb: ServiceWorker showNotification called",
          );
        } else {
          debugPrint(
            "NotificationStrategyWeb: ServiceWorker not ready, falling back",
          );
          _showStandardNotification(title, body, router);
        }
      } else {
        // Desktop (Windows/Mac) - Use standard Notification API
        debugPrint("NotificationStrategyWeb: Using Standard strategy");
        _showStandardNotification(title, body, router);
      }
    } catch (e, stack) {
      debugPrint("NotificationStrategyWeb: ERROR showing notification: $e");
      debugPrint(stack.toString());
    }
  }

  void _showStandardNotification(String title, String body, GoRouter? router) {
    final notification = html.Notification(
      title,
      dir: 'auto',
      icon: 'favicon.png',
      body: body,
    );

    notification.onClick.listen((event) {
      debugPrint("NotificationStrategyWeb: Standard notification clicked");
      event.preventDefault();
      notification.close();
      try {
        (html.window as dynamic).focus();
      } catch (e) {
        debugPrint("NotificationStrategyWeb: Could not focus window: $e");
      }
      if (router != null) {
        debugPrint("NotificationStrategyWeb: Navigating to /random");
        router.go('/random');
      }
    });
  }
}
