import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'content_model.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int currentPage = 0; // To track the current page index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Skip and Page indicator (e.g., 1/3) in the same row at the top
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page indicator (e.g., 1/3) with dynamic color
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: '${currentPage + 1}', // Current page number
                          style: const TextStyle(
                            color: Colors.black, // Current page is always black
                          ),
                        ),
                        const TextSpan(
                          text: '/', // Static slash
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text:
                              '${contents.length}', // Total pages (always grey)
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Skip button on the right
                 
                  const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  
                ],
              ),
            ),
          ),

          // PageView for onboarding content
          PageView.builder(
            controller: _pageController,
            itemCount: contents.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index; // Update the current page index
              });
            },
            itemBuilder: (context, index) {
              final content = contents[index];
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image (Changed to Image.asset for PNG files)
                    Image.asset(
                      content.image,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.8,
                      fit: BoxFit.contain,
                    ),

                    // Title
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        content.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Description
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        content.discription,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 122, 122, 122),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // SmoothPageIndicator aligned at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
              child: SmoothPageIndicator(
                controller: _pageController, // Your page controller
                count: contents.length, // Total pages
                effect: CustomizableEffect(
                  activeDotDecoration: DotDecoration(
                    width: 40, // Line-like active dot
                    height: 8,
                    color: Colors.black, // Active dot color
                    borderRadius: BorderRadius.circular(4),
                  ),
                  dotDecoration: DotDecoration(
                    width: 12, // Circular dot
                    height: 12,
                    color: Colors.grey, // Inactive dot color
                    borderRadius: BorderRadius.circular(6),
                  ),
                  spacing: 16, // Spacing between dots
                ),
              ),
            ),
          ),

          // Bottom navigation buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Show Prev button on all pages except the first
                  if (currentPage != 0)
                    TextButton(
                      onPressed: () {
                        // Navigate to the previous page
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        'Prev',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  else
                    const SizedBox(), // Empty space to maintain alignment

                  // Show Next or Get Started button on the right
                  TextButton(
                    onPressed: () {
                      if (currentPage == contents.length - 1) {
                        // Navigate to /home page when Get Started is pressed
                        Navigator.pushReplacementNamed(context, '/sign_up');
                      } else {
                        // Navigate to the next page
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      currentPage == contents.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 236, 22, 112),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
