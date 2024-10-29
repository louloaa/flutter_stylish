import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart'; // Import the BLoC
import '../bloc/product_event.dart'; // Import the navigation events

class PaginationBar extends StatelessWidget {
  final int currentPage;
  final bool hasMore;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasMore) return const SizedBox.shrink(); // Do not display if no more products are available

    final bloc = context.read<ProductBloc>();
    return BottomNavigationBar(
      items: List.generate(5, (index) {
        return BottomNavigationBarItem(
          icon: const SizedBox.shrink(), // No icon, just an empty widget
          label: '${index + 1}', // Pagination number
        );
      }),
      currentIndex: currentPage - 1, // 0-based index for BottomNavigationBar
      onTap: (index) {
        bloc.currentPage = index + 1; // Set the current page when tapped
        bloc.add(FetchTrendingProducts()); // Fetch products for the selected page
      },
      selectedItemColor: const Color.fromARGB(255, 182, 102, 135), // Color for the selected number
      unselectedItemColor: Colors.grey, // Color for unselected numbers
      selectedLabelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Style for selected number
      unselectedLabelStyle: const TextStyle(fontSize: 16), // Style for unselected numbers
      type: BottomNavigationBarType.fixed, // Ensures all items are displayed, even if unselected
    );
  }
}
