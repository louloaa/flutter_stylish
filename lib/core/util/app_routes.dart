import 'package:go_router/go_router.dart';
import 'package:flutter_stylish/features/authaintecation/presentation/pages/sign_in.dart';
import 'package:flutter_stylish/features/authaintecation/presentation/pages/sign_up.dart';
import 'package:flutter_stylish/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:flutter_stylish/features/product/presentation/pages/home_page.dart';
import 'package:flutter_stylish/features/product/presentation/pages/product_page.dart';
import 'package:flutter_stylish/features/product/presentation/pages/trending_page.dart';
import 'package:flutter_stylish/injection_container.dart' as di;

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/sign_in',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(getProductsUseCase: di.sl()),
      ),
      GoRoute(
        path: '/trending',
        builder: (context, state) => TrendingPage(getProductsUseCase: di.sl()),
      ),
      GoRoute(
        path: '/product',
        builder: (context, state) => ProductPage(getProductsUseCase: di.sl()),
      ),
      GoRoute(
        path: '/sign_in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/sign_up',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: '/edit_profile',
        builder: (context, state) => const EditProfilePage(),
      ),
    ],
  );
}
