import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/constant/color.dart';
import 'package:story_app/features/user/auth/bloc/auth_bloc.dart';
import 'package:story_app/features/user/login/bloc/login_bloc.dart';
import 'package:story_app/features/user/register/bloc/register_bloc.dart';
import 'package:story_app/features/user/register/view/register.dart';
import 'package:story_app/features/user/shared/view/auth_button.dart';
import 'package:story_app/features/user/shared/view/auth_field.dart';
import 'package:story_app/routes/routes_name.dart';
import 'package:story_app/utils/global_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _passwordShowNotifier = ValueNotifier<bool>(true);

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          switch (state.stateStatus) {
            case LoginStateStatus.loading:
              GlobalDialog.loadingDialog(context: context);
              break;
            case LoginStateStatus.success:
              context.pop();
              context.pushNamed(AppRouteConstants.homeRoute);
              break;
            case LoginStateStatus.failure:
              context.pop();
              GlobalDialog.errorDialog(
                  context: context, subtitle: state.message ?? "Error Occured");
              break;
            default:
              break;
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Welcome Back",
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
                    label: "Email",
                    controller: _emailController,
                    hintText: "Brandonelouis@gmail.com ",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "email is empty";
                      }
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
                            if (value.length < 8) {
                              return "password at least 8 character";
                            }
                            return null;
                          },
                        );
                      }),
                  AuthButton(
                    title: "Login",
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      context.read<LoginBloc>().add(LoginSubmitted(
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                  ),
                  _dontHaveAnAccount(onTap: () {
                    context.pushNamed(AppRouteConstants.registerRoute);
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dontHaveAnAccount({required VoidCallback onTap}) {
    return RichText(
        text: TextSpan(
            text: 'Anda belum memiliki akun? ',
            style: const TextStyle(color: Color(0xff524B6B), fontSize: 14),
            children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: 'Daftar',
            style: const TextStyle(color: Color(0xffFF9228), fontSize: 14),
          )
        ]));
  }
}
