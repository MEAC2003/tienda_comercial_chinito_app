import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/onboarding/onboarding_helper.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    print('Onboarding Screen inicializada');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Fullscreen background image
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.onboarding),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay button at bottom
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _completeOnboarding(context),
              child: Container(
                height: 70.h,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPaddingHorizontal * 3.2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.defaultRadius * 3.5),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Comenzar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _completeOnboarding(BuildContext context) async {
    print('Completando onboarding');

    // Marca como completado
    await OnboardingHelper.markOnboardingComplete();

    // Navega explícitamente al login
    context.go(AppRouter.signIn);

    print('Navegando a login después de onboarding');
  }
}
