import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/core/theme/app_theme.dart';
import 'package:tienda_comercial_chinito_app/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

/// Clase para manejar errores globales de la aplicación
class AppErrorHandler {
  static Future<void> handleError(Object error, StackTrace stackTrace) async {
    debugPrint('Error: $error');
    debugPrint('StackTrace: $stackTrace');
    // Aquí puedes agregar lógica para enviar errores a un servicio de monitoreo
  }

  static Widget buildErrorWidget(BuildContext context, String message) {
    return Material(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              'Ocurrió un error inesperado',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (message.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Reiniciar la aplicación o navegar a la pantalla principal
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Configuración inicial de la aplicación
class AppInitializer {
  static Future<void> initialize() async {
    try {
      // Asegura que los bindings de Flutter estén inicializados
      WidgetsFlutterBinding.ensureInitialized();

      // Configura la orientación preferida de la app
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // Configura el estilo de la barra de estado
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );

      // Carga las variables de entorno
      await dotenv.load(fileName: '.env');

      // Inicializa Supabase
      await Supabase.initialize(
        url: dotenv.get('SUPABASE_URL'),
        anonKey: dotenv.get('SUPABASE_ANON_KEY'),
        debug: false, // Cambiar a true solo durante desarrollo
      );

      // Inicializa ScreenUtil
      await ScreenUtil.ensureScreenSize();
    } catch (e, stackTrace) {
      await AppErrorHandler.handleError(e, stackTrace);
      rethrow;
    }
  }
}

/// Proveedores de estado de la aplicación
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authDataSource = SupabaseAuthDataSourceImpl();
    final authRepository = AuthRepositoryImpl(authDataSource);
    final authProvider = AuthProvider(authRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository)),
        ChangeNotifierProvider.value(value: authProvider),
        // Agrega aquí más providers según necesites
      ],
      child: child,
    );
  }
}

void main() async {
  await runZonedGuarded(
    () async {
      try {
        // Inicializa la aplicación
        await AppInitializer.initialize();

        // Crea e inicializa el AuthProvider
        final authDataSource = SupabaseAuthDataSourceImpl();
        final authRepository = AuthRepositoryImpl(authDataSource);
        final authProvider = AuthProvider(authRepository);
        await authProvider.initializeUser();

        // Ejecuta la aplicación
        runApp(
          AppProviders(
            child: const MyApp(),
          ),
        );
      } catch (e, stackTrace) {
        debugPrint('Error fatal en la inicialización: $e');
        debugPrint('StackTrace: $stackTrace');

        runApp(
          MaterialApp(
            home: Builder(
              builder: (context) => AppErrorHandler.buildErrorWidget(
                context,
                'Error al iniciar la aplicación',
              ),
            ),
          ),
        );
      }
    },
    (error, stackTrace) async {
      await AppErrorHandler.handleError(error, stackTrace);
    },
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
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        builder: (context, widget) {
          // Configuración global de errores de widgets
          ErrorWidget.builder = (FlutterErrorDetails details) {
            return AppErrorHandler.buildErrorWidget(
              context,
              details.exception.toString(),
            );
          };

          // Aplica el widget
          return widget!;
        },
      ),
    );
  }
}
