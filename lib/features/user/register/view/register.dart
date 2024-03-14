import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/utils/common.dart';
import '../../../../utils/global_dialog.dart';
import '../../../../constant/color.dart';
import '../../../common/widget/dropdown_locale.dart';
import '../../shared/view/auth_button.dart';
import '../../shared/view/auth_field.dart';
import '../bloc/register_bloc.dart';

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
                title: AppLocalizations.of(context)!.titleSuccessDialog,
                subtitle: AppLocalizations.of(context)!.subtitleSuccessDialog,
                buttonTitle: AppLocalizations.of(context)!.buttonSuccessDialog,
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
                    const SizedBox(height: 50),
                    Align(
                        alignment: Alignment.centerRight,
                        child: DropDownLocale()),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.titlePageRegister,
                      style: const TextStyle(
                          color: darkBlue,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.subtitlePageAuth,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xff524B6B)),
                    ),
                    AuthField(
                      label: AppLocalizations.of(context)!.labelFieldFullname,
                      controller: _fullNameController,
                      hintText: "Brandone louis ",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.nameEmpty;
                        }

                        return null;
                      },
                    ),
                    AuthField(
                      label: "Email",
                      controller: _emailController,
                      hintText: "Brandonelouis@gmail.com ",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.emailEmpty;
                        }
                        if (!EmailValidator.validate(value)) {
                          return AppLocalizations.of(context)!.emailNotValid;
                        }
                        return null;
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: _passwordShowNotifier,
                        builder: (context, isSecure, _) {
                          return AuthField(
                            label: AppLocalizations.of(context)!
                                .labelFieldPassword,
                            controller: _passwordController,
                            hintText: AppLocalizations.of(context)!
                                .labelFieldPassword,
                            obscureText: isSecure,
                            textInputAction: TextInputAction.next,
                            trailingIcon: IconButton(
                                onPressed: () {
                                  _passwordShowNotifier.value = !isSecure;
                                },
                                icon: isSecure
                                    ? const Icon(CupertinoIcons.eye_slash)
                                    : const Icon(CupertinoIcons.eye)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .passwordEmpty;
                              }
                              if (value.length < 8) {
                                return AppLocalizations.of(context)!
                                    .passwordNotLongEnough;
                              }
                              return null;
                            },
                          );
                        }),
                    ValueListenableBuilder(
                        valueListenable: _confirmPasswordShowNotifier,
                        builder: (context, isSecure, _) {
                          return AuthField(
                            label: AppLocalizations.of(context)!
                                .labelFieldConfirmPassword,
                            controller: _confirmPasswordController,
                            hintText: AppLocalizations.of(context)!
                                .labelFieldConfirmPassword,
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
                                return AppLocalizations.of(context)!
                                    .passwordEmpty;
                              }
                              if (value.length < 8) {
                                return AppLocalizations.of(context)!
                                    .passwordNotLongEnough;
                              }
                              if (value != _passwordController.text) {
                                return AppLocalizations.of(context)!
                                    .passwordNotSame;
                              }
                              return null;
                            },
                          );
                        }),
                    AuthButton(
                      title: AppLocalizations.of(context)!.registerTitle,
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
            text: AppLocalizations.of(context)!.haveAccount,
            style: const TextStyle(color: Color(0xff524B6B), fontSize: 14),
            children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: AppLocalizations.of(context)!.loginTitle,
            style: const TextStyle(color: Color(0xffFF9228), fontSize: 14),
          )
        ]));
  }
}
