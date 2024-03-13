import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:story_app/constant/color.dart';
import 'package:story_app/features/user/shared/view/auth_button.dart';
import 'package:story_app/features/user/shared/view/auth_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _passwordShowNotifier = ValueNotifier<bool>(true);
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Create an Account",
                  style: TextStyle(
                      color: darkBlue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Story app is a platform for uploading your story and let your friend know what you are doing now',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xff524B6B)),
                ),
                AuthField(
                  label: "Full name",
                  controller: _fullNameController,
                  hintText: "Brandone louis ",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "name is empty";

                    return null;
                  },
                ),
                AuthField(
                  label: "Email",
                  controller: _emailController,
                  hintText: "Brandonelouis@gmail.com ",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "email is empty";
                    if (!EmailValidator.validate(value)) {
                      return "email isn't valid";
                    }
                    return null;
                  },
                ),
                ValueListenableBuilder(
                    valueListenable: _passwordShowNotifier,
                    builder: (context, isSecure, _) {
                      return AuthField(
                        label: "Password",
                        controller: _passwordController,
                        hintText: "password",
                        obscureText: isSecure,
                        trailingIcon: IconButton(
                            onPressed: () {
                              _passwordShowNotifier.value = !isSecure;
                            },
                            icon: isSecure
                                ? const Icon(CupertinoIcons.eye_slash)
                                : const Icon(CupertinoIcons.eye)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "password is empty";
                          }
                          return null;
                        },
                      );
                    }),
                AuthButton(
                  title: "Register",
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                  },
                ),
                _dontHaveAnAccount(onTap: () {
                  Navigator.pop(context);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dontHaveAnAccount({required VoidCallback onTap}) {
    return RichText(
        text: TextSpan(
            text: 'Anda sudah memiliki akun? ',
            style: const TextStyle(color: Color(0xff524B6B), fontSize: 14),
            children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: 'Login',
            style: const TextStyle(color: Color(0xffFF9228), fontSize: 14),
          )
        ]));
  }
}
