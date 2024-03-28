import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/features/story/view/select_location.dart';

import '../features/story/bloc/story_bloc.dart';
import '../features/story/view/detail_story.dart';
import '../features/story/view/home_story.dart';
import '../features/story/view/post_story.dart';
import '../features/user/login/view/login.dart';
import '../features/user/settings/view/settings.dart';
import '../features/user/register/view/register.dart';
import '../features/user/auth/view/splash.dart';
import './routes_name.dart';

class AppRouter {
  static RouterConfig<Object>? routerConfig() {
    return GoRouter(initialLocation: AppRouteConstants.splashRoute, routes: [
      GoRoute(
        name: AppRouteConstants.splashRoute,
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
        name: AppRouteConstants.settingsRoute,
        path: AppRouteConstants.settingsRoute,
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.postStoryRoute,
        path: AppRouteConstants.postStoryRoute,
        builder: (context, state) => const PostStory(),
      ),
      GoRoute(
        name: AppRouteConstants.selectLocationRoute,
        path: AppRouteConstants.selectLocationRoute,
        builder: (context, state) => const SelectLocationScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.detailStoryRoute,
        path: "${AppRouteConstants.detailStoryRoute}/:id",
        builder: (context, state) {
          final id = state.pathParameters['id'];
          context.read<StoryBloc>().add(StoryDetailFetched(id: id ?? ""));
          return DetailStoryScreen(
            id: id ?? "",
          );
        },
      ),
    ]);
  }
}
