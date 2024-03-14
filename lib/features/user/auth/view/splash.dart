import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../constant/assets.dart';
import '../../../../routes/routes_name.dart';
import '../bloc/auth_bloc.dart';

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
        listener: (context, state) async {
          switch (state.userCurrentState) {
            case UserCurrentState.unauthenticated:
              await Future.delayed(const Duration(seconds: 2)).then((_) {
                context.pushReplacementNamed(AppRouteConstants.loginRoute);
              });
            case UserCurrentState.authenticated:
              await Future.delayed(const Duration(seconds: 2)).then((_) {
                context.pushReplacementNamed(AppRouteConstants.homeRoute);
              });
          }
        },
        child: Stack(
          children: [
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Story App',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )),
            const Align(
              alignment: Alignment(0, 0.95),
              child: Text(
                "Powered by @Difta Fitrahul Qihaj",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
