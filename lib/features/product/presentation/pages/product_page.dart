import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/util/snackbar_message.dart';
import '../../domain/usecases/getproducts.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/nav.dart';
import '../widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductPage extends StatefulWidget {
  final GetProductsUseCase getProductsUseCase;

  const ProductPage({super.key, required this.getProductsUseCase});

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  final PageController _pageController =
      PageController(); // Controller for PageView
  final SnackbarMessage snackbarMessage = SnackbarMessage();
  // Add your image paths here (can be network images or assets)
  final List<String> imagePaths = [
    'assets/photo1.png',
    'assets/photo2.png',
    'assets/photo3.png',
    'assets/photo4.png',
    'assets/photo5.png',
    // Add more images if needed
  ];
  int selectedIndex = 0;
  // bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            // Space at the top of the view (you can adjust this height)
            const SizedBox(height: 50), // Keeps space at the top

            // Top navigation icons (without vertical padding)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20), // Horizontal padding only
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/arrow.png'),
                  Image.asset(
                    'assets/shop.png',
                    fit: BoxFit.fill,
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // PageView should take up the remaining space without adding extra space
            Stack(
              children: [
                // The PageView for photo pagination
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: _pageController, // Controls page view swipes
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              15), // Rounded corners for images
                          child: Image.asset(
                            imagePaths[index],
                            fit: BoxFit
                                .fill, // Ensure the image fills the container
                            height: 250, // Fixed height for the image
                            width: 380, // Fixed width for the image
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Align the SmoothPageIndicator properly without adding space
                Align(
                  alignment:
                      Alignment.bottomCenter, // Align at the bottom center
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 230), // Add space for the indicator
                    child: SmoothPageIndicator(
                      controller: _pageController, // PageView controller
                      count: imagePaths.length, // Number of images
                      effect: SlideEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Colors.red, // Active dot color (red)
                        dotColor:
                            Colors.grey.withOpacity(0.5), // Inactive dot color
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ),

Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .nikeSneakers, // Localized string
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ), // Customize text style
                  ),
                  const SizedBox(height: 3), // Add spacing between the texts
                  Text(
                    AppLocalizations.of(context)!
                        .productDetails, // Localized string
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ), // Customize text style
                  ),
                  const SizedBox(height: 3),
                  // ReadMoreText widget with localized text
                  ReadMoreText(
                    AppLocalizations.of(context)!
                        .readMoreText, // Localized string
                    trimLines: 6, // Show 6 lines when collapsed
                    trimMode: TrimMode.Line, // Collapses by lines
                    trimCollapsedText:
                        AppLocalizations.of(context)!.more, // Localized "More"
                    trimExpandedText:
                        AppLocalizations.of(context)!.less, // Localized "Less"
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ), // Style of the main text
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 236, 111, 111),
                    ), // Style for "More"
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 236, 111, 111),
                    ), // Style for "Less"
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      child: Image.asset(
                        'assets/red.png',
                        height: 80,
                        width: 360,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    bottom: 13,
                    right: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .deliveryIn, // Localized string
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              AppLocalizations.of(context)!
                                  .deliveryTime, // Localized string
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),



            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Sort action
                    },
                    style: ElevatedButton.styleFrom(
                      padding: Directionality.of(context) == TextDirection.rtl
                          ? const EdgeInsets.symmetric(
                              horizontal: 34, vertical: 12) // Arabic padding
                          : const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14), // Default padding
                      backgroundColor: Colors.white, // Button background color
                      foregroundColor: Colors.black, // Text color
                      elevation: 0,
                      side: const BorderSide(
                        color: Color.fromARGB(255, 230, 230, 230),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('assets/eye.png'),
                        const SizedBox(width: 5),
                        Text(
                          AppLocalizations.of(context)!
                              .viewSimilar, // Localized string
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/Checkout'); // Navigate to CheckoutPage
  },
  style: ElevatedButton.styleFrom(
    padding: Directionality.of(context) == TextDirection.rtl
        ? const EdgeInsets.symmetric(horizontal: 24, vertical: 8) // Arabic padding
        : const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
    backgroundColor: Colors.white, // Button background color
    foregroundColor: Colors.black, // Text color
    elevation: 0,
    side: const BorderSide(
      color: Color.fromARGB(255, 230, 230, 230),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  child: Row(
    children: [
      Image.asset('assets/Frame.png'),
      const SizedBox(width: 5),
      Text(
        AppLocalizations.of(context)!.addToCompare, // Localized string
        style: const TextStyle(fontSize: 15),
      ),
    ],
  ),
)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .similarTo, // Localized string
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .itemsCount, // Localized string
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Sort action
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor:
                              Colors.white, // Button background color
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
                            Text(
                              AppLocalizations.of(context)!
                                  .sort, // Localized string
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(
                                width: 5), // Space between text and icon
                            const Icon(Icons.swap_vert,
                                size: 18), // Icon second
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
                          backgroundColor:
                              Colors.white, // Button background color
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
                            Text(
                              AppLocalizations.of(context)!
                                  .filter, // Localized string
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(
                                width: 5), // Space between text and icon
                            const Icon(Icons.filter_alt_outlined,
                                size: 18), // Icon second
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: BlocProvider(
                create: (context) =>
                    ProductBloc(getProductsUseCase: widget.getProductsUseCase)
                      ..add(FetchAllProducts()),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductLoaded) {
                      // Increase the height of SizedBox for a larger card
                      return SizedBox(
                        height:
                            200, // Increase height to fit a bigger product card
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          //  itemCount: state.product.length < 2 ? state.product.length : 2, // Limit to 2 items
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return SizedBox(
                              width: 196, // Increase width of each product card
                              child: ProductCard(
                                  product:
                                      product), // Assume ProductCard has a flexible layout
                            );
                          },
                        ),
                      );
                    } else if (state is ProductError) {
                      // Show error message SnackBar if there is an error
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        snackbarMessage.PopupSnackBar(
                            context, 'No Internet Connection');
                      });
                      return Center(
                          child:
                              Text(AppLocalizations.of(context)!.errorMessage));
                    }

                    return Container(); // Fallback widget if state doesn't match
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
          'assets/shopping.png', // Path to your image asset
          0,
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
