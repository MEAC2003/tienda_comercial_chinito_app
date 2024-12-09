import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/screens/screens.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/presentation/screens/screens.dart';
import 'package:tienda_comercial_chinito_app/features/admin/settings/presentation/screens/screens.dart';
import 'package:tienda_comercial_chinito_app/features/auth/domain/enums/user_role.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/screens/screen.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/screens/screens.dart';
import 'package:tienda_comercial_chinito_app/features/onboarding/onboarding.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/screens/screens.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';

class AppRouter {
  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String catalog = '/catalog';
  static const String productDetails = '/product-details';
  static const String onboarding = '/onboarding';
  static const String myAccount = '/my-account';
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';
  static const String dashboard = '/dashboard';
  static const String adminMyAccount = '/admin-my-account';
  static const String adminActions = '/admin-actions';
  static const String adminAddProduct = '/admin-add-product';

  static GoRouter getRouter(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String initialLocation = home;
    if (authProvider.isAuthenticated &&
        authProvider.hasRole(UserRole.admin.toString().split('.').last)) {
      initialLocation = dashboard;
    }
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        ShellRoute(
          builder: (context, state, child) => NavBar(child: child),
          routes: [
            GoRoute(
              path: home,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: catalog,
              builder: (context, state) => const CatalogScreen(),
            ),
            GoRoute(
              path: myAccount,
              builder: (context, state) {
                if (authProvider
                    .hasRole(UserRole.admin.toString().split('.').last)) {
                  return const AdminMyAccountScreen();
                }
                return const MyAccountScreen();
              },
            ),
          ],
        ),
        ShellRoute(
          builder: (context, state, child) => AdminNavBar(child: child),
          routes: [
            GoRoute(
              path: dashboard,
              builder: (context, state) => const DashboardScreen(),
            ),
            GoRoute(
              path: adminActions,
              builder: (context, state) => const AdminActionsScreen(),
            ),
            GoRoute(
              path: adminMyAccount,
              builder: (context, state) => const AdminMyAccountScreen(),
            ),
          ],
        ),
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
          path: '$productDetails/:id',
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductDetailsScreen(productId: productId);
          },
        ),
        GoRoute(
          path: catalog,
          builder: (context, state) => const CatalogScreen(),
        ),
        GoRoute(
          path: onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: myAccount,
          builder: (context, state) => const MyAccountScreen(),
        ),
        GoRoute(
          path: settings,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: editProfile,
          builder: (context, state) => const EditProfileScreen(),
        ),
        GoRoute(
          path: dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: adminMyAccount,
          builder: (context, state) => const AdminMyAccountScreen(),
        ),
        GoRoute(
          path: adminActions,
          builder: (context, state) => const AdminActionsScreen(),
        ),
        GoRoute(
          path: adminAddProduct,
          builder: (context, state) => const AddProductScreen(),
        ),
      ],
    );
  }
}
