import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stylish/features/auth&splash/presentation/bloc/auth_bloc.dart';
import 'package:flutter_stylish/features/auth&splash/presentation/pages/sign_in.dart';
import 'package:flutter_stylish/features/auth&splash/presentation/pages/sign_up.dart';
import 'package:flutter_stylish/features/profile/presentation/bloc/user_bloc.dart';
import 'package:flutter_stylish/features/profile/presentation/bloc/user_event.dart';
import 'package:flutter_stylish/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:provider/provider.dart';
import 'features/auth&splash/presentation/pages/onbording.dart';
import 'features/auth&splash/presentation/pages/splash_screen.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/pages/checkout.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/product/presentation/pages/payment.dart';
import 'features/product/presentation/pages/product_page.dart';
import 'features/product/presentation/pages/shopping_bag.dart';
import 'features/product/presentation/pages/trending_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'injection_container.dart' as di; // Import dependency injection

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize dependencies in injection_container.dart
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocalizationProvider(),
      child: const MyApp(),
    ),
  );
}

// Define LocalizationProvider within main.dart
class LocalizationProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en'); // Default to English
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ProductBloc>(
              create: (_) => ProductBloc(getProductsUseCase: di.sl()),
            ),
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(
                signInUseCase: di.sl(),
                signUpUseCase: di.sl(),
              ),
            ),
            BlocProvider<UserBloc>(
              create: (_) => UserBloc(
                getUserProfile: di.sl(),
                updateUserProfile: di.sl(),
              )..add(FetchProfile()), // Fetch user profile on start
            ),
          ],
          child: MaterialApp(
            title: 'App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.cairoTextTheme(),
            ),
            debugShowCheckedModeBanner: false,

            // Localization setup
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            locale: localizationProvider.locale ?? const Locale('en'),

            // Routes
            initialRoute: '/Splash_Screen',
            routes: {
              '/sign_up': (context) => const SignUpPage(),
              '/sign_in': (context) => const SignInPage(),
              '/edit_profile': (context) => const EditProfilePage(),
              '/Splash_Screen': (context) => const SplashScreen(),              
              '/OnboardingPage': (context) => const OnboardingPage(),
              '/ShoppingBagPage': (context) => const ShoppingBagPage(),
              '/PaymentPage': (context) => const PaymentPage(),
              '/home': (context) => HomePage(getProductsUseCase: di.sl()),
              '/trending': (context) => TrendingPage(getProductsUseCase: di.sl()),
              '/product': (context) => ProductPage(getProductsUseCase: di.sl()),
              '/Checkout': (context) => CheckoutPage(getProductsUseCase: di.sl()),            
            },

            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
          ),
        );
      },
    );
  }
}