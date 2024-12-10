import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/auth/domain/enums/user_role.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _SignInView(),
    );
  }
}

class _SignInView extends StatefulWidget {
  const _SignInView();

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<_SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final authProvider = context.read<AuthProvider>();
    final result = await authProvider.signInWithEmail(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (result.success) {
      await authProvider.initializeUser();
      if (authProvider.hasRole(UserRole.admin.toString().split('.').last)) {
        context.go(AppRouter.home);
      } else {
        context.go(AppRouter.home);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.error ?? 'Error de autenticación')),
      );
    }
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      child: const Text('¿Olvidaste tu contraseña?'),
      onPressed: () async {
        final email = _emailController.text;
        if (email.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Por favor, ingresa tu email')),
          );
          return;
        }
        final success = await context.read<AuthProvider>().resetPassword(email);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Se ha enviado un email para restablecer tu contraseña')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(context.read<AuthProvider>().errorMessage ??
                    'Error al restablecer la contraseña')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppSize.defaultPadding * 2),
            Image.asset(
              AppAssets.logo,
              width: 120.w,
            ),
            SizedBox(height: AppSize.defaultPadding),
            Text(
              'Iniciar sesión',
              style: AppStyles.h1(
                color: AppColors.darkColor,
                fontWeight: FontWeight.w900,
              ).copyWith(letterSpacing: -1.5),
            ),
            Text(
              'Ingresa tus datos para continuar',
              style: AppStyles.h4(
                color: AppColors.darkColor50,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            CustomTextField(
              controller: _emailController,
              icon: const Icon(Icons.email_outlined),
              hintText: 'Enter email',
              obscureText: false,
            ),
            CustomTextField(
              controller: _passwordController,
              icon: const Icon(Icons.lock_person_outlined),
              hintText: 'Password',
              obscureText: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPaddingHorizontal * 1.5,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: _buildForgotPasswordButton(),
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            CustomCTAButton(
              text: 'Iniciar sesión',
              onPressed: () => _handleSignIn(context),
            ),
            const OrAccess(),
            SocialMediaButton(
              imgPath: AppAssets.googleIcon,
              text: ' Iniciar sesión con Google',
              onPressed: () async {
                final authProvider = context.read<AuthProvider>();
                final result = await authProvider.signInWithGoogle();

                //implementar esto if (authProvider.isAuthenticated &&
                //     authProvider.hasRole(UserRole.admin.name)) {
                //   initialLocation = dashboard;
                // } else if (authProvider.isAuthenticated &&
                //     authProvider.hasRole(UserRole.pending.name)) {
                //   initialLocation = userPending;
                // } else if (authProvider.isAuthenticated &&
                //     authProvider.hasRole(UserRole.user.name)) {
                //   initialLocation = home;
                // } else {
                //   initialLocation =
                //       home; // Por defecto, envía a "home" si no se cumplen condiciones previas
                // }
                if (result.success) {
                  if (authProvider.hasRole(UserRole.admin.name)) {
                    context.go(AppRouter.dashboard);
                  } else if (authProvider.hasRole(UserRole.pending.name)) {
                    context.go(AppRouter.userPending);
                  } else if (authProvider.hasRole(UserRole.user.name)) {
                    context.go(AppRouter.home);
                  } else {
                    context.go(AppRouter.home);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(result.error ??
                            'Error de autenticación con Google')),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes una cuenta?',
                    style: AppStyles.h4(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRouter.signUp),
                    child: Text(
                      'Regístrate',
                      style: AppStyles.h4(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
