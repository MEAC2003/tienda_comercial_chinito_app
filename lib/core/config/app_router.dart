import 'package:go_router/go_router.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/screens/screen.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/screens/home.dart';
// import 'package:tienda_comercial_chinito_app/onboarding.dart';

class AppRouter {
  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String onboardingScreen = '/onboarding-screen';

  static final router = GoRouter(
    initialLocation: signIn,
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
      // GoRoute(
      //   path: onboardingScreen,
      //   builder: (context, state) => const OnboardingScreen(),
      // ),
    ],
  );
}
