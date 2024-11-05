import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the generated localization class
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SnackbarMessage {

void SuccessSnackBar({required String message, required BuildContext context})
{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor:  Colors.green,
    )); 
  
}

void ErrorSnackBar({required String message, required BuildContext context})
{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
    )); 
  
}
void PopupSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    elevation: 0,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: AppLocalizations.of(context)!.errorTitle, // Use the localized title
      message:AppLocalizations.of(context)!.noInternetMessage, // Error message passed to the Snackbar (can be localized)
      contentType: ContentType.failure, // Error content type
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
}