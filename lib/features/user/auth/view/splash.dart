import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/features/user/auth/bloc/auth_bloc.dart';
import 'package:story_app/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state.userCurrentState) {
            case UserCurrentState.unauthenticated:
              context.pushNamed(AppRouteConstants.loginRoute);
            case UserCurrentState.authenticated:
              context.pushNamed(AppRouteConstants.homeRoute);
          }
        },
        child: const Center(
          child: Icon(Icons.star),
        ),
      ),
    );
  }
}
