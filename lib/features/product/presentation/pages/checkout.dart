import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/getproducts.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class CheckoutPage extends StatefulWidget {
  final GetProductsUseCase getProductsUseCase;

  const CheckoutPage({super.key, required this.getProductsUseCase});

  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<ProductBloc>().add(FetchCheckout());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(getProductsUseCase: widget.getProductsUseCase)
            ..add(FetchCheckout()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Checkout',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/arrow.png', width: 40, height: 40),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Row(
                children: [
                  Image.asset(
                    'assets/location.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Delivery Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Address & Image Row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Address Card
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Address:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/Group2.png',
                                    width: 10,
                                    height: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text('216 St Paul\'s Rd, London N1 2LL, UK',
                                  style: TextStyle(fontSize: 12)),
                              const Text('Contact: +44-784232',
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Image Card
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                child:ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/PaymentPage'); // Navigate to Payment Page
  },
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.zero, // Removes extra padding
    backgroundColor: Colors.transparent, // No background color
    elevation: 0, // Removes shadow
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Optional: Rounds button
    ),
  ),
  child: Center(
    child: Image.asset(
      'assets/Group.png',
      width: 20,
      height: 20,
      fit: BoxFit.cover,
    ),
  ),
),

                  ),
                ],
              ),
            ),

            // Shopping List Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Shopping List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Product List with Scrollbar
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return const Center(child: Text('No products available.'));
                    }

                    return Scrollbar(
                      thickness: 16,
                      radius: const Radius.circular(10),
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          child: Image.network(
                                            product.imageUrl,
                                            width: 140,
                                            height: 140,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/placeholder.png',
                                                width: 140,
                                                height: 140,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.title,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 12),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 235, 231, 231),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              child: Text(
                                                '\$${product.price.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Divider(
                                        color: Color.fromARGB(255, 235, 231, 231),
                                        thickness: 1),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Total Order (1):',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } 
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
