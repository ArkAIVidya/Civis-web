import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'screens/screens.dart';
import '../data/repository/user_preferences_repository.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final prefs = ref.watch(userPreferencesRepositoryProvider);
  final isSetupComplete = prefs.isSetupComplete ?? false;

  return GoRouter(
    initialLocation: isSetupComplete ? '/landing' : '/setup',
    routes: [
      GoRoute(path: '/setup', builder: (context, state) => const SetupScreen()),
      GoRoute(
        path: '/landing',
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
      GoRoute(
        path: '/learning',
        builder: (context, state) => const LearningScreen(),
      ),
      GoRoute(
        path: '/video/:videoId',
        builder: (context, state) {
          final videoId = state.pathParameters['videoId']!;
          return VideoPlayerScreen(videoId: videoId);
        },
      ),
      GoRoute(
        path: '/study/:category',
        builder: (context, state) {
          final category = state.pathParameters['category']!;
          return StudyScreen(category: category);
        },
      ),
      GoRoute(
        path: '/random',
        builder: (context, state) {
          return const RandomQuestionScreen();
        },
      ),
    ],
  );
}
