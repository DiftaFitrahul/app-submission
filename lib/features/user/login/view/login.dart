import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/features/common/widget/dropdown_locale.dart';

import '../../../common/utils/common.dart';
import '../../../../constant/color.dart';
import '../../../../routes/routes_name.dart';
import '../../../../utils/global_dialog.dart';
import '../../shared/view/auth_button.dart';
import '../../shared/view/auth_field.dart';
import '../bloc/login_bloc.dart';

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
              context.pushReplacementNamed(AppRouteConstants.homeRoute);
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 50),
                    Align(
                        alignment: Alignment.centerRight,
                        child: DropDownLocale()),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.titlePageLogin,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: darkBlue,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      AppLocalizations.of(context)!.subtitlePageAuth,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff524B6B),
                      ),
                    ),
                    const SizedBox(height: 80),
                    AuthField(
                      label: "Email",
                      controller: _emailController,
                      hintText: "Brandonelouis@gmail.com ",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
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
                    AuthButton(
                      title: AppLocalizations.of(context)!.loginTitle,
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        context.read<LoginBloc>().add(LoginSubmitted(
                            email: _emailController.text,
                            password: _passwordController.text));
                      },
                    ),
                    const SizedBox(height: 30),
                    _dontHaveAnAccount(onTap: () {
                      context.pushNamed(AppRouteConstants.registerRoute);
                    }),
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
            text: AppLocalizations.of(context)!.dontHaveAccount,
            style: const TextStyle(color: Color(0xff524B6B), fontSize: 14),
            children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: AppLocalizations.of(context)!.registerTitle,
            style: const TextStyle(color: Color(0xffFF9228), fontSize: 14),
          )
        ]));
  }
}
