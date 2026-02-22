import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:civis_web/main.dart';
import 'package:civis_web/data/repository/user_preferences_repository.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const CivisApp(),
      ),
    );

    // Verify that the app builds
    expect(find.byType(CivisApp), findsOneWidget);
  });
}
