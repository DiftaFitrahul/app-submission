import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/features/story/data/repository/story_repository.dart';
import 'package:story_app/features/user/auth/bloc/auth_bloc.dart';
import 'package:story_app/features/user/shared/data/repository/auth_repository.dart';
import 'package:story_app/routes/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp(
      {super.key, required this.authRepository, required this.storyRepository});
  final AuthRepository authRepository;
  final StoryRepository storyRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (context) => authRepository,
          ),
          RepositoryProvider<StoryRepository>(
            create: (context) => storyRepository,
          ),
        ],
        child: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: authRepository),
          child: MaterialApp.router(
            routerConfig: AppRouter.routerConfig(),
            title: "Story App",
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 255),
            ),
          ),
        ));
  }
}
