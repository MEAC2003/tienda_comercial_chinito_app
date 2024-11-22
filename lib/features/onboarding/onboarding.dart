import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Imagen superior
            Container(
              height: size.height * 0.58,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.onboarding),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: AppSize.defaultPadding),

            // Contenido central
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPadding * 1.5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "¡Bienvenido al Control de Inventario!",
                    style: AppStyles.h1(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppSize.defaultPadding * 0.5),
                  Padding(
                    padding: EdgeInsets.only(
                      right: AppSize.defaultPadding * 2,
                    ),
                    child: Text(
                      "Mantén el control total de tus productos y recursos",
                      style: AppStyles.h4(
                        color: AppColors.darkColor50,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Navegación inferior
            Padding(
              padding: EdgeInsets.only(left: AppSize.defaultPadding * 1.5),
              child: Row(
                children: [
                  // Indicadores de página
                  Row(
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin:
                            EdgeInsets.only(right: AppSize.defaultPadding / 2),
                        width: index == 0 ? 12.w : 6.w,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: index == 0
                              ? Colors.black
                              : Colors.grey.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Botón Comenzar
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, AppRouter.signIn);
                    },
                    child: Container(
                      height: 70.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.defaultPaddingHorizontal * 3.2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
