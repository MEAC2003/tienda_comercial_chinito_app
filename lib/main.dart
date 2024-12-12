import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/core/theme/app_theme.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/datasources/supabase_action_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/datasources/supabase_users_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/domain/repositories/action_repository_impl.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/domain/repositories/users_repository_impl.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/users_provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/datasources/supabase_dashboard_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/domain/repositories/dashboard_repository_impl.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:tienda_comercial_chinito_app/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/datasources/supabase_product_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/home/domain/repositories/product_repository_impl.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/providers/product_provider.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/datasources/supabase_users_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/settings/domain/repositories/users_repository_impl.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/providers/users_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/navigation_provider.dart';
import 'package:tienda_comercial_chinito_app/services/notification_service.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );
  await ScreenUtil.ensureScreenSize();
  final authDataSource = SupabaseAuthDataSourceImpl();
  final authRepository = AuthRepositoryImpl(authDataSource);
  final authProvider = AuthProvider(authRepository);
  final productDataSource = SupabaseProductDataSourceImpl();
  final productRepository = ProductRepositoryImpl(productDataSource);
  final dashboard = DashboardRepositoryImpl(SupabaseDashboardDataSourceImpl());
  final adminUsersRepository = AdminUsersRepositoryImpl(
    AdminSupabaseUsersDataSource(Supabase.instance.client),
  );

  final actionRepository = ActionRepositoryImpl(
    SupabaseActionDataSourceImpl(),
  );
  await authProvider.initializeUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository)),
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) => UserProvider(
            UsersRepositoryImpl(
              SupabaseUsersDataSource(Supabase.instance.client),
            ),
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (context, authProvider, previousUserProvider) =>
              previousUserProvider!..updateAuthProvider(authProvider),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(productRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(dashboard),
        ),
        ChangeNotifierProxyProvider<AuthProvider, AdminUserProvider>(
          create: (context) => AdminUserProvider(
            adminUsersRepository,
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (context, authProvider, previousUserProvider) =>
              previousUserProvider!..updateAuthProvider(authProvider),
        ),
        ChangeNotifierProvider(
          create: (_) => ActionProvider(actionRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => FutureBuilder<GoRouter>(
        future: AppRouter.getRouter(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          return MaterialApp.router(
            routerConfig: snapshot.data,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
