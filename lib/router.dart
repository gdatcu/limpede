import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/screens.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(
    Supabase.instance.client.auth.onAuthStateChange,
  ),
  redirect: (BuildContext context, GoRouterState state) {
    final session = Supabase.instance.client.auth.currentSession;
    final location = state.matchedLocation;
    final isAuthProcessing = location == '/login' || location.contains('login-callback');

    if (session == null && !isAuthProcessing) {
      return '/login';
    }
    if (session != null && isAuthProcessing) {
      return '/';
    }
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/login-callback',
      builder: (BuildContext context, GoRouterState state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    ),
    GoRoute(
      path: '/lesson/:id',
      builder: (BuildContext context, GoRouterState state) {
        final lessonId = state.pathParameters['id'] ?? 'default';
        final targetLanguage = state.uri.queryParameters['language'] ?? 'Spanish';
        final isSrsReview = state.uri.queryParameters['isSrsReview'] == 'true';
        return LessonScreen(
          lessonId: lessonId,
          targetLanguage: targetLanguage,
          isSrsReview: isSrsReview,
        );
      },
    ),
  ],
);

