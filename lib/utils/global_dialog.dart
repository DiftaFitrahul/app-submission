import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constant/color.dart';

class GlobalDialog {
  static void errorDialog(
      {required BuildContext context, required String subtitle}) {
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionBuilder: (ctx, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialogComponent(
              title: 'Error!!',
              subtitleWidget: SubtitleDialog(subtitle: subtitle),
              mainWidgetDialog: AlertDialogButtonComponent(
                  buttonTitle: 'Kembali',
                  onPressed: () {
                    context.pop();
                  }),
              titleColor: const Color.fromARGB(255, 163, 25, 15),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 215),
    );
  }

  static void loadingDialog({required BuildContext context}) {
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionBuilder: (ctx, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialogComponent(
              title: 'Memproses Data',
              mainWidgetDialog: Center(
                child: LoadingAnimationWidget.prograssiveDots(
                  color: darkBlue,
                  size: 65,
                ),
              ),
              titleColor: const Color(0xff524B6B),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 215),
    );
  }

  static void successDialog(
      {required BuildContext context,
      required String title,
      required String subtitle,
      required String buttonTitle,
      required VoidCallback onTap}) {
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionBuilder: (ctx, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialogComponent(
              title: title,
              subtitleWidget: SubtitleDialog(subtitle: subtitle),
              mainWidgetDialog: AlertDialogButtonComponent(
                  buttonTitle: buttonTitle, onPressed: onTap),
              titleColor: const Color(0xff524B6B),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 215),
    );
  }
}

class AlertDialogComponent extends StatelessWidget {
  final String title;
  final Widget? subtitleWidget;
  final Widget mainWidgetDialog;
  final Color titleColor;
  const AlertDialogComponent(
      {super.key,
      required this.title,
      this.subtitleWidget,
      required this.titleColor,
      required this.mainWidgetDialog});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: titleColor,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 255),
      content: subtitleWidget,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      actions: [mainWidgetDialog],
      actionsPadding: const EdgeInsets.only(bottom: 25),
    );
  }
}

class SubtitleDialog extends StatelessWidget {
  final String subtitle;
  const SubtitleDialog({
    super.key,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Color(0xff524B6B)),
    );
  }
}

class AlertDialogButtonComponent extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback? onPressed;
  const AlertDialogButtonComponent(
      {super.key, required this.buttonTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor: MaterialStateProperty.all<Color>(darkBlue),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return darkBlue;
                }
                return null;
              },
            )),
        child: Text(
          buttonTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
