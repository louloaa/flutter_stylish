import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/getproducts.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/drawer.dart';
import '../widgets/nav.dart';
import '../widgets/pagination.dart';
import '../widgets/popup.dart';
import '../widgets/product_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TrendingPage extends StatefulWidget {
  final GetProductsUseCase getProductsUseCase;

  const TrendingPage({
    super.key,
    required this.getProductsUseCase,
  });

  @override
  TrendingPageState createState() => TrendingPageState();
}

class TrendingPageState extends State<TrendingPage> {
  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final bool _showPaginationBar = false; // To control pagination bar visibility
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // Add listener to the scroll controller to detect scrolling to the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<ProductBloc>().add(FetchTrendingProducts());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  // Assign the key to Scaffold
      drawer: const CustomDrawer(),
      resizeToAvoidBottomInset: false, // Prevents shifting when keyboard appears
      body: Column(
        children: [
          const SizedBox(height: 40), // Space at the top of the screen
          // Top navigation icons
         Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState
                          ?.openDrawer(); // Open the drawer
                    },
                    child: Image.asset('assets/list.png'),
                  ),
                  Image.asset('assets/logo.png'),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/edit_profile');
                    },
                    child: Image.asset('assets/girl.png'),
                  ),
                ],
              ),
            ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: const Icon(Icons.mic_none_outlined, color: Colors.grey),
                hintText: AppLocalizations.of(context)!.searchHint,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                filled: true,
                fillColor: const Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),

          // Items and sort/filter buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '52,082+ ${AppLocalizations.of(context)!.items}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Sort action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Colors.white, // Button background color
                        foregroundColor: Colors.black, // Text color
                        elevation: 0,
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(AppLocalizations.of(context)!.sort,
                              style: const TextStyle(fontSize: 15)),
                          const SizedBox(width: 5),
                          const Icon(Icons.swap_vert, size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10), // Space between buttons
                    ElevatedButton(
                      onPressed: () {
                        // Filter action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Colors.white, // Button background color
                        foregroundColor: Colors.black, // Text color
                        elevation: 0,
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(AppLocalizations.of(context)!.filter,
                              style: const TextStyle(fontSize: 15)),
                          const SizedBox(width: 5),
                          const Icon(Icons.filter_alt_outlined, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Expanded product grid section
          Expanded(
            child: BlocProvider(
              create: (context) => ProductBloc(getProductsUseCase: widget.getProductsUseCase)
                ..add(FetchTrendingProducts()), // Fetch the first page on initialization
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    return Column(
                      children: [
                        // Display the GridView of products
                        Expanded(
                          child: GridView.builder(
                            controller: _scrollController, // Attach scroll controller
                            padding: const EdgeInsets.all(10),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return ProductCard(product: product);
                            },
                          ),
                        ),
                        // Conditionally display pagination bar when more than 4 items are shown
                        if (_showPaginationBar)
                          PaginationBar(
                            currentPage: state.currentPage,
                            hasMore: state.hasMore,
                          ),
                      ],
                    );
                  } else if (state is ProductError) {
  // Show error message SnackBar if there is an error
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showErrorSnackbar(context, 'No Internet Connection');
  });
  return Center(child: Text(AppLocalizations.of(context)!.errorMessage));
}

                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          int selectedIndex = 1;
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
          'assets/shopping.png', // Path to your image asset
          2,
          selectedIndex, // Use a variable to track the selected state
          () {
            // Update the selectedIndex to indicate this icon is selected
            setState(() {
              selectedIndex = 2; // Update the selected index
            });
            // Navigate to the product page
            Navigator.pushNamed(context, '/product');
          },
        ),
      ),
    );
  }
}
