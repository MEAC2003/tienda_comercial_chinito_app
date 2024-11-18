import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _CatalogView(),
    );
  }
}

class _CatalogView extends StatelessWidget {
  const _CatalogView();

  @override
  Widget build(BuildContext context) {
    final List<String> myCategories = [
      'Todo',
      'I.E INICIAL',
      'I.E SAN',
      'I.E ROSA',
      'I.E JUAN',
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
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPadding,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.defaultPadding * 1.5,
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
                    height: AppSize.defaultPadding * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // o el alineamiento que prefieras
                    children: [
                      Text(
                        'Catálogo',
                        style: AppStyles.h2(
                          color: AppColors.darkColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.defaultPadding,
                  ),
                  FilterCategories(
                    categories: myCategories, // Lista de categorías
                    onCategorySelected: (String selectedCategory) {
                      print('Categoría seleccionada: $selectedCategory');
                    },
                  ),
                  SizedBox(
                    height: AppSize.defaultPadding * 1.5,
                  ),
                  ProductGrid(products: products),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
