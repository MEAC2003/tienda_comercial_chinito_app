import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _markOnboardingComplete(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    if (context.mounted) {
      context.go(AppRouter.signIn);
    }
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
              onTap: () => _markOnboardingComplete(context),
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
}

// Helper function to check if onboarding is needed
Future<bool> checkIfOnboardingNeeded() async {
  final prefs = await SharedPreferences.getInstance();
  return !(prefs.getBool('hasSeenOnboarding') ?? false);
}
