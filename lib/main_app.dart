import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/app_config.dart';
import 'package:story_app/features/location/cubit/location_cubit.dart';

import 'package:story_app/features/story/bloc/story_bloc.dart';
import 'package:story_app/features/story/data/repository/story_repository.dart';
import 'package:story_app/features/user/auth/bloc/auth_bloc.dart';
import 'package:story_app/features/user/login/bloc/login_bloc.dart';
import 'package:story_app/features/user/register/bloc/register_bloc.dart';
import 'package:story_app/features/user/shared/data/repository/auth_repository.dart';
import 'package:story_app/features/user/shared/data/repository/user_repository.dart';
import 'package:story_app/routes/routes.dart';
import 'package:story_app/features/common/utils/common.dart';
import 'package:story_app/features/common/cubit/common_cubit.dart';

class MainApp extends StatelessWidget {
  const MainApp(
      {super.key,
      required this.authRepository,
      required this.storyRepository,
      required this.userRepository});
  final AuthRepository authRepository;
  final StoryRepository storyRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter.routerConfig();

    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: authRepository)..add(AuthChecked()),
          ),
          BlocProvider<StoryBloc>(
            create: (context) => StoryBloc(storyRepository: storyRepository),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(authRepository: authRepository),
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(authRepository: authRepository),
          ),
          BlocProvider<CommonCubit>(
            create: (context) =>
                CommonCubit(userRepository: userRepository)..getUserLocale(),
          ),
          BlocProvider<LocationCubit>(
            create: (context) => LocationCubit(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: appRouter?.routerDelegate,
            routeInformationProvider: appRouter?.routeInformationProvider,
            routeInformationParser: appRouter?.routeInformationParser,
            title: AppConfig.shared.title,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('id', ''),
              Locale('en', ''),
            ],
            locale: context.watch<CommonCubit>().state,
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 255),
            ),
          );
        }));
  }
}
