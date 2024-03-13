import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/features/user/auth/bloc/auth_bloc.dart';
import 'package:story_app/routes/routes_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Center"),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthOut());
                  context.replaceNamed(AppRouteConstants.loginRoute);
                },
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
