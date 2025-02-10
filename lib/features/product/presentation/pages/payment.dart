import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../widgets/nav.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedIndex = 1; // Default selected index

  // Function to Show Popup Message
  void _showPopupMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners for dialog
          ),
          child: Stack(
            children: [
              // Background Image for the Popup
              Positioned(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Clip image to fit rounded corners
                  child: Image.asset(
                    'assets/Sucessfully.png', // Replace with your image
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/Shipping.png', // Replace with your actual background image
              fit: BoxFit.cover,
            ),
          ),
          // "Continue" Button Positioned at Bottom
          Positioned(
            bottom: 20, // Position it above the bottom navigation bar
            left: 30,
            right: 30,
            child: SizedBox(
              width: double.infinity, // Full width button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 236, 22, 112), // Button color
                  padding: const EdgeInsets.symmetric(vertical: 14 , horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                onPressed: () {
                  _showPopupMessage(context); // Show popup on tap
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 16 , fontWeight: FontWeight.bold) ,
                ),
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar (keeps the floating button working)
      bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
         int selectedIndex = 2;
          if (state is HomeState) {
            selectedIndex = 0;
          } else if (state is TrendingState) {
            selectedIndex = 1;
          } else if (state is ProudctsState) {
            selectedIndex = 2;
          }
          return BottomNavigationBarComponent(selectedIndex: selectedIndex);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 18),
        child: circularShoppingCartIcon(
          context,
          'assets/shopping.png', // Path to your shopping cart icon
          2,
          selectedIndex,
          () {
            // Update selected index and navigate to the product page
            setState(() {
              selectedIndex = 2;
            });
            Navigator.pushNamed(context, '/product');
          },
        ),
      ),
    );
  }
}
