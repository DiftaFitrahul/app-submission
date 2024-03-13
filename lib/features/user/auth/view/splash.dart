import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() async {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (mounted) context.push(AppRouteConstants.loginRoute);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.star),
      ),
    );
  }
}
