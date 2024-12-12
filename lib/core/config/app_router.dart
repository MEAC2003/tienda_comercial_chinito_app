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
import 'package:tienda_comercial_chinito_app/features/onboarding/onboarding_helper.dart';
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
  static const String userPending = '/user-pending';
  static const String adminRoles = '/admin-roles';
  static const String adminAddCategory = '/admin-add-category';
  static const String adminAddTypeGarment = '/admin-add-type-garment';
  static const String adminAddZone = '/admin-add-zone';
  static const String adminAddSupplier = '/admin-add-supplier';
  static const String adminAddSchool = '/admin-add-school';
  static const String adminAddSize = '/admin-add-size';
  static const String adminInventoryMovements = '/admin-inventory-movements';
  static const String adminInventoryMovementsDetail =
      '/admin-inventory-movements-detail';
  static const String adminViewProduct = '/admin-view-product';
  static const String adminViewCategory = '/admin-view-category';
  static const String adminViewTypeGarment = '/admin-view-type-garment';
  static const String adminViewZone = '/admin-view-zone';
  static const String adminViewSupplier = '/admin-view-supplier';
  static const String adminViewSchool = '/admin-view-school';
  static const String adminViewSize = '/admin-view-size';
  static const String adminDetailProduct = '/admin-detail-product';
  static const String adminProductUpdate = '/admin-product-update';
  static const String adminDetailSupplier = '/admin-detail-supplier';
  static const String adminSupplierUpdate = '/admin-supplier-update';
  static const String adminDetailCategory = '/admin-detail-category';
  static const String adminCategoryUpdate = '/admin-category-update';
  static const String adminDetailTypeGarment = '/admin-detail-type-garment';
  static const String adminTypeGarmentUpdate = '/admin-type-garment-update';
  static const String adminDetailZone = '/admin-detail-zone';
  static const String adminZoneUpdate = '/admin-zone-update';
  static const String adminDetailSchool = '/admin-detail-school';
  static const String adminSchoolUpdate = '/admin-school-update';
  static const String adminDetailSize = '/admin-detail-size';
  static const String adminSizeUpdate = '/admin-size-update';
  static const String pruebas = '/pruebas';

  static Future<GoRouter> getRouter(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final isOnboardingComplete = await OnboardingHelper.isOnboardingComplete();

    String initialLocation = home;

    if (!isOnboardingComplete) {
      initialLocation = onboarding;
    } else {
      if (authProvider.isAuthenticated &&
          authProvider.hasRole(UserRole.admin.name)) {
        initialLocation = dashboard;
      } else if (authProvider.isAuthenticated &&
          authProvider.hasRole(UserRole.pending.name)) {
        initialLocation = userPending;
      } else if (authProvider.isAuthenticated &&
          authProvider.hasRole(UserRole.user.name)) {
        initialLocation = home;
      } else if (!authProvider.isAuthenticated) {
        initialLocation = signIn;
      } else {
        initialLocation = home;
      }
    }
    print('Navegando a $initialLocation');
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
        GoRoute(
          path: userPending,
          builder: (context, state) => const UserPendingScreen(),
        ),
        GoRoute(
          path: adminRoles,
          builder: (context, state) => const AdminRolesScreen(),
        ),
        GoRoute(
          path: adminAddCategory,
          builder: (context, state) => const AddCategoryScreen(),
        ),
        GoRoute(
          path: adminAddTypeGarment,
          builder: (context, state) => const AdminAddTypeGarmentScreen(),
        ),
        GoRoute(
          path: adminAddSchool,
          builder: (context, state) => const AddSchoolScreen(),
        ),
        GoRoute(
          path: adminAddSize,
          builder: (context, state) => const AdminAddSizeScreen(),
        ),
        GoRoute(
          path: adminAddSupplier,
          builder: (context, state) => const AddSupplierScreen(),
        ),
        GoRoute(
          path: adminAddZone,
          builder: (context, state) => const AddZoneScreen(),
        ),
        GoRoute(
          path: adminInventoryMovements,
          builder: (context, state) => const AdminInventoryMovementsScreen(),
        ),
        GoRoute(
          path: '$adminInventoryMovementsDetail/:id',
          builder: (context, state) {
            final movementId = state.pathParameters['id']!;
            return AdminInventoryMovementsDetailScreen(movementId: movementId);
          },
        ),
        GoRoute(
          path: adminViewProduct,
          builder: (context, state) => const AdminViewProductScreen(),
        ),
        GoRoute(
          path: adminViewSupplier,
          builder: (context, state) => const AdminViewSupplierScreen(),
        ),
        GoRoute(
          path: adminViewCategory,
          builder: (context, state) => const AdminViewCategoryScreen(),
        ),
        GoRoute(
          path: adminViewTypeGarment,
          builder: (context, state) => const AdminViewTypeGarmentScreen(),
        ),
        GoRoute(
          path: adminViewSchool,
          builder: (context, state) => const AdminViewSchoolScreen(),
        ),
        GoRoute(
          path: adminViewSize,
          builder: (context, state) => const AdminViewSizeScreen(),
        ),
        GoRoute(
          path: adminViewZone,
          builder: (context, state) => const AdminViewZoneScreen(),
        ),
        GoRoute(
          path: '$adminDetailProduct/:id',
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return AdminDetailProductScreen(productId: productId);
          },
        ),
        GoRoute(
          path: '$adminProductUpdate/:id',
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return AdminProductUpdate(productId: productId);
          },
        ),
        GoRoute(
          path: '$adminDetailSupplier/:id',
          builder: (context, state) {
            final supplierID = state.pathParameters['id']!;
            return AdminDetailSupplierScreen(supplierId: supplierID);
          },
        ),
        GoRoute(
          path: '$adminSupplierUpdate/:id',
          builder: (context, state) {
            final supplierID = state.pathParameters['id']!;
            return AdminSupplierUpdateScreen(supplierId: supplierID);
          },
        ),
        GoRoute(
          path: '$adminDetailCategory/:id',
          builder: (context, state) {
            final categoryID = state.pathParameters['id']!;
            return AdminDetailCategoryScreen(categoryId: categoryID);
          },
        ),
        GoRoute(
          path: '$adminCategoryUpdate/:id',
          builder: (context, state) {
            final categoryID = state.pathParameters['id']!;
            return AdminCategoryUpdateScreen(categoryId: categoryID);
          },
        ),
        GoRoute(
          path: '$adminDetailZone/:id',
          builder: (context, state) {
            final zoneID = state.pathParameters['id']!;
            return AdminDetailZoneScreen(zoneId: zoneID);
          },
        ),
        GoRoute(
          path: '$adminZoneUpdate/:id',
          builder: (context, state) {
            final zoneID = state.pathParameters['id']!;
            return AdminZoneUpdateScreen(zoneId: zoneID);
          },
        ),
        GoRoute(
          path: '$adminDetailSize/:id',
          builder: (context, state) {
            final sizeId = state.pathParameters['id']!;
            return AdminDetailSizeScreen(sizeId: sizeId);
          },
        ),
        GoRoute(
          path: '$adminSizeUpdate/:id',
          builder: (context, state) {
            final sizeId = state.pathParameters['id']!;
            return AdminSizeUpdateScreen(sizeId: sizeId);
          },
        ),
        GoRoute(
          path: '$adminDetailSchool/:id',
          builder: (context, state) {
            final schoolId = state.pathParameters['id']!;
            return AdminDetailSchoolScreen(schoolId: schoolId);
          },
        ),
        GoRoute(
          path: '$adminSchoolUpdate/:id',
          builder: (context, state) {
            final schoolId = state.pathParameters['id']!;
            return AdminSchoolUpdateScreen(schoolId: schoolId);
          },
        ),
        GoRoute(
          path: '$adminDetailTypeGarment/:id',
          builder: (context, state) {
            final typeGarmentId = state.pathParameters['id']!;
            return AdminDetailTypeGarmentScreen(typeGarmentId: typeGarmentId);
          },
        ),
        GoRoute(
          path: '$adminTypeGarmentUpdate/:id',
          builder: (context, state) {
            final typeGarmentId = state.pathParameters['id']!;
            return AdminTypeGarmentUpdateScreen(typeGarmentId: typeGarmentId);
          },
        ),
      ],
    );
  }
}
