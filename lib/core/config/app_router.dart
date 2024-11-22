import 'package:go_router/go_router.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/screens/screen.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/screens/screens.dart';
import 'package:tienda_comercial_chinito_app/features/onboarding/onboarding.dart';

class AppRouter {
  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String catalog = '/catalog';
  static const String productDetails = '/product-details';
  static const String onboarding = '/onboarding';

  static final router = GoRouter(
    initialLocation: onboarding,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: productDetails,
        builder: (context, state) => const ProductDetailsScreen(),
      ),
      GoRoute(
        path: catalog,
        builder: (context, state) => const CatalogScreen(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
}
