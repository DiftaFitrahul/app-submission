import 'package:flutter/material.dart';
import 'package:story_app/features/common/utils/common.dart';

String failureMessage(BuildContext context, String message) {
  switch (message) {
    case "No internet":
      return AppLocalizations.of(context)!.noInternet;
    case "Connection error":
      return AppLocalizations.of(context)!.connectionError;
    default:
      return AppLocalizations.of(context)!.errorOccured;
  }
}
