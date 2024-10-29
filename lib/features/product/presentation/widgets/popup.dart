/*import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: const Row(
          children: [
            Icon(
              Icons.signal_wifi_statusbar_connected_no_internet_4_sharp, // Icon indicating no internet
              color: Color.fromARGB(255, 70, 68, 68), // Color of the icon
            ),
            SizedBox(width: 8), // Space between icon and text
            Expanded(
              child: Text('No Internet Connection'), // Error message
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}*/
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the generated localization class
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void showErrorSnackbar(BuildContext context, String message) {
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
