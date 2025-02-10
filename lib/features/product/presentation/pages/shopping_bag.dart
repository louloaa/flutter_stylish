import 'package:flutter/material.dart';
import 'payment.dart';

class ShoppingBagPage extends StatelessWidget {
  const ShoppingBagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/Place Order.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Proceed to Payment Button
          Positioned(
            bottom: 40,
            right: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 236, 22, 112),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Slightly rounded corners
                ),
              ),
              onPressed: () {
                // Navigate to PaymentPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentPage()),
                );
              },
              child: const Text(
                "Proceed to Payment",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}