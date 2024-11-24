// widget/nav.dart
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/product_bloc.dart'; // Import the BLoC
import '../bloc/product_event.dart'; // Import the navigation events
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  final int selectedIndex;

  const BottomNavigationBarComponent({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Height for the bottom navigation bar
      color: Colors.white, // Background color
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navBarItemWithImage(context, 'assets/home.png', AppLocalizations.of(context)!.home, 0),
          navBarItem(context, Icons.favorite_outline, AppLocalizations.of(context)!.wishlist, 1),
          const SizedBox(width: 60), // Space for the shopping cart
          navBarItem(context, Icons.search, AppLocalizations.of(context)!.search, 3),
          navBarItem(context, Icons.settings_outlined, AppLocalizations.of(context)!.settings, 4),
        ],
      ),
    );
  }

  Widget navBarItem(BuildContext context, IconData iconData, String label, int index) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(context, index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: selectedIndex == index
                ? const Color.fromARGB(255, 202, 41, 103)
                : Colors.black,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selectedIndex == index
                  ? const Color.fromARGB(255, 202, 41, 103)
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0: // Home
        context.go('/home');
        break;
      case 1: // Wishlist
        context.go('/trending'); 
        break;
      case 2: // Product
        context.go('/product'); 
        break;
    }
  }

  Widget navBarItemWithImage(
    BuildContext context,
    String imagePath,
    String label,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(context, index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 24, // Set your preferred image size
            width: 24,
            color: selectedIndex == index
                ? const Color.fromARGB(255, 202, 41, 103) // Change to pink when selected
                : Colors.black, // Default color
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selectedIndex == index
                  ? const Color.fromARGB(255, 202, 41, 103) // Pink when selected
                  : Colors.black, // Default color
            ),
          ),
        ],
      ),
    );
  }
}
Widget circularShoppingCartIcon(
  BuildContext context,
  String imagePath, // Path to the image
  int index,
  int selectedIndex,
  VoidCallback onTap,
) {
  final bool isSelected = selectedIndex == index;

  return GestureDetector(
    onTap: onTap, // Use the onTap callback
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? const Color.fromARGB(255, 202, 41, 103) // Selected color
            : const Color.fromARGB(255, 255, 255, 255), // Default color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          imagePath, // The image to be used instead of the icon
          color: isSelected
              ? Colors.white // White color when selected
              : const Color.fromARGB(255, 10, 10, 10), // Default image color
          width: 28, // Adjust image size
          height: 28, // Adjust image size
        ),
      ),
    ),
  );
}



