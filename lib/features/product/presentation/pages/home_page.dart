import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/util/snackbar_message.dart';
import 'package:stylish/features/product/domain/usecases/getproducts.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/drawer.dart';
import '../widgets/nav.dart';
import '../widgets/product_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final GetProductsUseCase getProductsUseCase;

  const HomePage({super.key, required this.getProductsUseCase});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentPage = 1; // For tracking the image in the carousel
  int selectedIndex = 0;
  final List<String> imagePaths = [
    'assets/pink.png', // Image before pink.png
    'assets/pink.png', // Center pink.png image
    'assets/pink.png', // Image after pink.png
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackbarMessage snackbarMessage = SnackbarMessage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to Scaffold
      drawer: const CustomDrawer(), // Use the CustomDrawer widget
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
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
                  suffixIcon:
                      const Icon(Icons.mic_none_outlined, color: Colors.grey),
                  hintText: AppLocalizations.of(context)!
                      .searchHint, // Use localized string
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
                    AppLocalizations.of(context)!
                        .allCategories, // Use localized string
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
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.sort,
                                style: const TextStyle(
                                    fontSize: 15)), // Use localized string
                            const SizedBox(width: 5),
                            const Icon(Icons.swap_vert, size: 18),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Filter action
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.filter,
                                style: const TextStyle(
                                    fontSize: 15)), // Use localized string
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

            // Categories with image and name below each image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/Beauty.png'),
                      const SizedBox(height: 5),
                      Text(AppLocalizations.of(context)!.beauty,
                          textAlign: TextAlign.center), // Use localized string
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/Fashion.png'),
                      const SizedBox(height: 5),
                      Text(AppLocalizations.of(context)!.fashion,
                          textAlign: TextAlign.center), // Use localized string
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/Kids.png'),
                      const SizedBox(height: 5),
                      Text(AppLocalizations.of(context)!.kids,
                          textAlign: TextAlign.center), // Use localized string
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/Mens.png'),
                      const SizedBox(height: 5),
                      Text(AppLocalizations.of(context)!.mens,
                          textAlign: TextAlign.center), // Use localized string
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/Womens.png'),
                      const SizedBox(height: 5),
                      Text(AppLocalizations.of(context)!.womens,
                          textAlign: TextAlign.center), // Use localized string
                    ],
                  ),
                ],
              ),
            ),

            // Promotional Banner with Swapping Images and Dots
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 210,
                    child: PageView.builder(
                      itemCount: imagePaths.length,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              imagePaths[index],
                              fit: BoxFit.cover,
                              height: 210,
                            ),
                            Positioned(
                              top: 40,
                              left: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .discountOffer, // Localized string
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .productPromo, // Localized string
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .allColors, // Localized string
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    OutlinedButton(
                                      onPressed:
                                          null, // No action, button is disabled
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .shopNow, // Localized string
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(width: 1),
                                          const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // Dots Indicator for the Images
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(imagePaths.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 10),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? const Color.fromARGB(255, 202, 41, 103)
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            // Deal of the Day section
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      child: Image.asset(
                        'assets/blue.png',
                        height:
                            90, // Increase the height to give more space for content
                        width: 380,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    bottom: 13,
                    right: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          // Use Flexible to prevent overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .dealOfTheDay, // Localized string
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.access_alarm,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    // Use Expanded to allow text to fit properly
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .timeRemaining, // Localized string
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow
                                          .ellipsis, // Handle text overflow gracefully
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            // Action for button press
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 4),
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .viewAll, // Localized string
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Product Carousel
            BlocProvider(
              create: (context) =>
                  ProductBloc(getProductsUseCase: widget.getProductsUseCase)
                    ..add(FetchHomeProducts()),
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    return Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: state.products.length,
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return ProductCard(product: product);
                              },
                            ),
                          ),
                        ),
                        // New Image and Text Overlay
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/offer.png', // Replace with your image path
                                height: 90,
                                width: 365,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                top: 5,
                                right: 90,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .specialOffers, // Localized string
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                6), // Adjust spacing as needed
                                        Container(
                                          width: 30, // Adjust width as needed
                                          height: 30, // Adjust height as needed
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color.fromARGB(255,
                                                  199, 192, 192), // Grey border
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            '😱', // Text inside the circle
                                            style: TextStyle(
                                              color: Colors.black, // Text color
                                              fontSize:
                                                  15, // Adjust font size as needed
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .specialOffersDescriptionLine1, // Localized string
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .specialOffersDescriptionLine2, // Localized string
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  child: Image.asset(
                                    'assets/mac.png', // Replace with your image path
                                    height: 180,
                                    width: 380,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width / 2 -
                                    30, // Center text below the image
                                bottom: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .flatAndHeels, // Localized string
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .rewardMessage, // Localized string
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right:
                                    30, // Adjust the button freely by changing the `right` and `bottom` values
                                bottom: 30,
                                child: Container(
                                  width: 120,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 202, 41, 103),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      // Add your onPressed code here
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .visitNow, // Localized string
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          int selectedIndex = 0;
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
