import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the localization class
import 'package:provider/provider.dart';
import 'package:flutter_stylish/main.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black.withOpacity(0.8), // Set black transparent background
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black54, // Black transparent color
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  AppLocalizations.of(context)!.languages, // Use localization for "Languages"
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.public, color: Colors.white), // Earth icon for Arabic
              title: Text(
                AppLocalizations.of(context)!.arabic, // Use localization for Arabic
                style: const TextStyle(
                  color: Colors.white, // Make text white for visibility
                ),
              ),
              onTap: () {
                // Change the locale to Arabic
                Provider.of<LocalizationProvider>(context, listen: false)
                    .setLocale(const Locale('ar'));
                Navigator.pop(context); // Close the drawer after selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.public, color: Colors.white), // Earth icon for English
              title: Text(
                AppLocalizations.of(context)!.english, // Use localization for English
                style: const TextStyle(
                  color: Colors.white, // Make text white for visibility
                ),
              ),
              onTap: () {
                // Change the locale to English
                Provider.of<LocalizationProvider>(context, listen: false)
                    .setLocale(const Locale('en'));
                Navigator.pop(context); // Close the drawer after selection
              },
            ),
          ],
        ),
      ),
    );
  }
}
