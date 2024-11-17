import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Ajustes',
          style: AppStyles.h2(
              color: AppColors.darkColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPaddingHorizontal * 1.5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(color: AppColors.darkColor50, thickness: 0.5),
              SizedBox(height: AppSize.defaultPadding / 1.5),
              SizedBox(height: AppSize.defaultPadding / 1.5),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  final bool isSignedIn = authProvider.isAuthenticated;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      isSignedIn ? 'Cerrar Sesión' : 'Iniciar Sesión',
                      style: AppStyles.h3(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () async {
                      if (isSignedIn) {
                        // Guardar el contexto en una variable local
                        final scaffoldContext = context;

                        // Realizar el signOut
                        await context.read<AuthProvider>().signOut();

                        // Verificar si el contexto todavía está montado
                        if (scaffoldContext.mounted) {
                          ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                            const SnackBar(content: Text('Sesión cerrada')),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          context.go(AppRouter.signIn);
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
