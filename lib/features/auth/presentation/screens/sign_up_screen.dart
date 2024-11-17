import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _SignUpView(),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu nombre completo';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa un email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor ingresa un email válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa una contraseña';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'La contraseña debe contener al menos una letra mayúscula';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'La contraseña debe contener al menos una letra minúscula';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'La contraseña debe contener al menos un número';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'La contraseña debe contener al menos un carácter especial';
    }
    return null;
  }

  void _handleAuthResult(BuildContext context, AuthResult result) {
    if (result.success) {
      context.go(AppRouter.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              context.read<AuthProvider>().errorMessage ?? 'Error de registro'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: AppSize.defaultPadding * 2),
              Image.asset(
                AppAssets.logo,
                width: 120.w,
              ),
              SizedBox(height: AppSize.defaultPadding),
              Text('Registrarse',
                  style: AppStyles.h1(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w900,
                  )),
              Text(
                'Ingresa tus datos para continuar',
                style: AppStyles.h4(
                  color: AppColors.darkColor50,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomTextField(
                controller: _fullNameController,
                icon: const Icon(
                  Icons.person_outline,
                  color: AppColors.primaryColor,
                ),
                hintText: 'Nombre completo',
                obscureText: false,
                validator: _validateFullName,
              ),
              CustomTextField(
                controller: _emailController,
                icon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.primaryColor,
                ),
                hintText: 'Correo electrónico',
                obscureText: false,
                validator: _validateEmail,
              ),
              CustomTextField(
                controller: _passwordController,
                icon: const Icon(
                  Icons.lock_person_outlined,
                  color: AppColors.primaryColor,
                ),
                hintText: 'Contraseña',
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: AppSize.defaultPadding),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return authProvider.isLoading
                      ? const CircularProgressIndicator()
                      : CustomCTAButton(
                          text: 'Registrarse',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await authProvider.signUpWithEmail(
                                fullName: _fullNameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              _handleAuthResult(context, result);
                            }
                          },
                        );
                },
              ),
              const OrAccess(),
              SocialMediaButton(
                imgPath: AppAssets.googleIcon,
                text: ' Registrarse con Google',
                onPressed: () async {
                  final result = await authProvider.signInWithGoogle();
                  _handleAuthResult(context, result);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes una cuenta?',
                      style: AppStyles.h4(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go(AppRouter.signIn),
                      child: Text(
                        'Iniciar sesión',
                        style: AppStyles.h4(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
