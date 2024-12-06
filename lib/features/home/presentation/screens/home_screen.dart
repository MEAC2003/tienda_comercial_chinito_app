import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = authProvider.currentUser?.userMetadata?['full_name'] ?? '';
    final firstName = userName.split(' ')[0];
    final isSignedIn = authProvider.isAuthenticated;
    final List<String> myCategories = [
      'Todo',
      'Camisas',
      'Buzos',
      'Pantalones',
      'Polos',
    ];
    final List<Map<String, dynamic>> products = [
      {
        "imageUrl": AppAssets.uniforme,
        "price": "29.90",
        "title": "Uniformes para colegios",
        "circleColor": Colors.green,
      },
      {
        "imageUrl": AppAssets.uniforme,
        "price": "49.90",
        "title": "Uniformes para colegios",
        "circleColor": Colors.yellow,
      },
      {
        "imageUrl": AppAssets.uniforme,
        "price": "19.90",
        "title": "Uniformes para colegios",
        "circleColor": Colors.red,
      },
    ];
    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context)
                .size
                .height, // Altura mínima igual a la pantalla
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPadding,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSize.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppSize.defaultPadding * 0.1,
                            ), // Espacio entre los textos
                            Row(
                              children: [
                                Text(
                                  isSignedIn && userName.isNotEmpty
                                      ? 'Bienvenid@, '
                                      : 'Hey, bienvenido!',
                                  style: AppStyles.h3p5(
                                    color: AppColors.darkColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (isSignedIn && userName.isNotEmpty)
                                  Text(
                                    firstName,
                                    style: AppStyles.h3p5(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              AppAssets.logo,
                              fit: BoxFit.cover,
                              width: 50.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding * 1.125,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 240, 243, 243), // 70%
                            Color.fromARGB(255, 243, 241, 241), // 25%
                            Color.fromARGB(255, 231, 231, 231), // 15%
                          ],
                          stops: [
                            0.03, // 3%
                            0.12, // 12%
                            1.0, // 100%
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultRadius),
                      ),
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: 'Search any products',
                          hintStyle: AppStyles.h4(
                            color: AppColors.darkColor50,
                          ),
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: AppSize.defaultPadding * 0.25,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSize.defaultRadius),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSize.defaultRadius),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSize.defaultRadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding * 1.5,
                    ),
                    Container(
                      width: double.infinity,
                      height: 146.h,
                      margin: EdgeInsets.symmetric(
                          vertical: AppSize.defaultPadding),
                      child: ClipRRect(
                        // Para mantener los bordes redondeados
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultRadius * 1.5),
                        child: Image.asset(
                          AppAssets.banner,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading image: $error');
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Text('Error al cargar la imagen'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding * 1.125,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Lo mas vendido',
                              style: AppStyles.h3p5(
                                color: AppColors.darkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: AppSize.defaultPaddingHorizontal * 0.2,
                            ), // Espacio entre el texto y la estrella
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 22,
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(AppRouter.myAccount);
                          },
                          child: Text(
                            'Ver más',
                            style: AppStyles.h4(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FilterCategories(
                      categories: myCategories, // Lista de categorías
                      onCategorySelected: (String selectedCategory) {
                        print('Categoría seleccionada: $selectedCategory');
                      },
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding,
                    ),
                    ProductGrid(products: products),
                    SizedBox(
                      height: AppSize.defaultPadding * 4,
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
