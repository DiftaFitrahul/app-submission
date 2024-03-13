import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/features/story/view/detail_story.dart';
import 'package:story_app/features/story/view/home_story.dart';
import 'package:story_app/features/user/login/view/login.dart';
import 'package:story_app/features/user/register/view/register.dart';
import 'package:story_app/features/user/auth/view/splash.dart';
import 'package:story_app/routes/routes_name.dart';

class AppRouter {
  static RouterConfig<Object>? routerConfig() {
    return GoRouter(initialLocation: AppRouteConstants.loginRoute, routes: [
      GoRoute(
        path: AppRouteConstants.splashRoute,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.loginRoute,
        path: AppRouteConstants.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.registerRoute,
        path: AppRouteConstants.registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.homeRoute,
        path: AppRouteConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.detailStoryRoute,
        path: AppRouteConstants.detailStoryRoute,
        builder: (context, state) => const DetailStoryScreen(),
      ),
    ]);
  }
}
