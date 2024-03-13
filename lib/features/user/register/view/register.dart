import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/constant/color.dart';
import 'package:story_app/features/user/register/bloc/register_bloc.dart';
import 'package:story_app/features/user/shared/view/auth_button.dart';
import 'package:story_app/features/user/shared/view/auth_field.dart';

import '../../../../utils/global_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _passwordShowNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _confirmPasswordShowNotifier =
      ValueNotifier<bool>(true);
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          switch (state.stateStatus) {
            case RegisterStateStatus.loading:
              GlobalDialog.loadingDialog(context: context);
              break;
            case RegisterStateStatus.success:
              context.pop();
              GlobalDialog.successDialog(
                context: context,
                title: "Success!!",
                subtitle: "please login after register",
                buttonTitle: "Selesai",
                onTap: () {
                  context.pop();
                  context.pop();
                },
              );
              break;
            case RegisterStateStatus.failure:
              context.pop();
              GlobalDialog.errorDialog(
                  context: context, subtitle: state.message);
              break;
            default:
              break;
          }
        },
        child: SingleChildScrollView(
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
                        if (value == null || value.isEmpty) {
                          return "name is empty";
                        }

                        return null;
                      },
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
                    ValueListenableBuilder(
                        valueListenable: _confirmPasswordShowNotifier,
                        builder: (context, isSecure, _) {
                          return AuthField(
                            label: "Confirm Password",
                            controller: _confirmPasswordController,
                            hintText: "confirm password",
                            obscureText: isSecure,
                            trailingIcon: IconButton(
                                onPressed: () {
                                  _confirmPasswordShowNotifier.value =
                                      !isSecure;
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
                              if (value != _passwordController.text) {
                                return "password isn't same";
                              }
                              return null;
                            },
                          );
                        }),
                    AuthButton(
                      title: "Register",
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        context.read<RegisterBloc>().add(RegisterSubmitted(
                            email: _emailController.text,
                            password: _passwordController.text,
                            name: _fullNameController.text));
                      },
                    ),
                    _dontHaveAnAccount(onTap: () {
                      context.pop();
                    })
                  ],
                ),
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
