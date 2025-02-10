import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'onbording.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Larger Lottie Animation on the Left
            Align(
              alignment: Alignment.topLeft,
              child: Transform.scale(
                scale: 4, // Adjust the scale factor as needed
                child: SizedBox(
                  width: MediaQuery.of(context).size.width, // Full screen width
                  height: MediaQuery.of(context).size.height, // Full screen height
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Lottie.asset(
                      'assets/animation/Main Scene.json',
                      fit: BoxFit.contain, // Maintain proportions
                    ),
                  ),
                ),
              ),
            ),

            // Text on the Right
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 100.0),
                child: Text(
                  'Stylish',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 236, 22, 112),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      nextScreen: const OnboardingPage(),
      duration: 3500,
      backgroundColor: Colors.white,
    );
  }
}
