import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/util/app_routes.dart';
import 'features/authaintecation/presentation/bloc/auth_bloc.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/profile/presentation/bloc/user_bloc.dart';
import 'features/profile/presentation/bloc/user_event.dart';
import 'injection_container.dart' as di;

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

// Define LocalizationProvider directly in main.dart
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

  // Create a single instance of the router
  static final GoRouter _router = createRouter();

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
                signUpUseCase: di.sl(),
                signInUseCase: di.sl(),
                
              ),
            ),
            BlocProvider<UserBloc>(
              create: (_) => UserBloc(
                getUserProfile: di.sl(),
                updateUserProfile: di.sl(),
              )..add(FetchProfile()),
            ),
          ],
          child: MaterialApp.router(
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

            // Use the single GoRouter instance
            routerDelegate: _router.routerDelegate,
            routeInformationParser: _router.routeInformationParser,
            routeInformationProvider: _router.routeInformationProvider,
          ),
        );
      },
    );
  }
}
