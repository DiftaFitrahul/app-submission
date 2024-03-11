import 'package:flutter/material.dart';
import 'package:story_app/features/user/login/view/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Story App",
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 255),
        ),
        home: const LoginScreen());
  }
}
