import 'package:flutter/material.dart';
import '../../../utils/global_dialog.dart';
import '../../common/utils/common.dart';

class LocationErrorDialog {
  static void gpsDeniedDialog(
      {required BuildContext context, required VoidCallback onPressed}) {
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
              title: AppLocalizations.of(context)!.locationDeniedTitle,
              subtitleWidget: SubtitleDialog(
                  subtitle:
                      AppLocalizations.of(context)!.locationDeniedSubtitle),
              mainWidgetDialog: AlertDialogButtonComponent(
                  buttonTitle:
                      AppLocalizations.of(context)!.locationDeniedButtonTitle,
                  onPressed: onPressed),
              titleColor: const Color.fromARGB(255, 163, 25, 15),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 215),
    );
  }

  static void gpsPermanentlyDeniedDialog(
      {required BuildContext context, required VoidCallback onPressed}) {
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
              title:
                  AppLocalizations.of(context)!.locationPermanentlyDeniedTitle,
              subtitleWidget: SubtitleDialog(
                  subtitle: AppLocalizations.of(context)!
                      .locationPermanentlyDeniedSubtitle),
              mainWidgetDialog: AlertDialogButtonComponent(
                  buttonTitle: AppLocalizations.of(context)!
                      .locationPermanentlyDeniedButtonTitle,
                  onPressed: onPressed),
              titleColor: const Color.fromARGB(255, 163, 25, 15),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 215),
    );
  }
}
