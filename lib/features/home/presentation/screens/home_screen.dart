import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/providers/product_provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/features/shared/navigation_provider.dart';
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

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  @override
  void initState() {
    super.initState();
    // Reset filter when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).resetFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = authProvider.currentUser?.userMetadata?['full_name'] ?? '';
    final firstName = userName.split(' ')[0];
    final isSignedIn = authProvider.isAuthenticated;
    final productProvider = Provider.of<ProductProvider>(context);
    final List<String> myCategories = productProvider.isLoading
        ? ['Todo']
        : ['Todo', ...productProvider.typeGarmentName];
    return SafeArea(
      child: SingleChildScrollView(
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
                          ),
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
                    width: double.infinity,
                    height: 146.h,
                    margin:
                        EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSize.defaultRadius * 1.5),
                      child: Image.asset(
                        AppAssets.banner,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
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
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 22,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<NavigationProvider>(context,
                                  listen: false)
                              .setIndex(1);
                          Provider.of<ProductProvider>(context, listen: false)
                              .resetFilter();
                          context.go(AppRouter.catalog);
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
                    categories: myCategories,
                    initialCategory: 'Todo',
                    onCategorySelected: (selectedCategory) {
                      productProvider.filterByTypeGarment(selectedCategory);
                    },
                  ),
                  SizedBox(
                    height: AppSize.defaultPadding,
                  ),
                  SizedBox(
                    child:
                        SingleChildScrollView(child: Consumer<ProductProvider>(
                      builder: (context, productProvider, child) {
                        if (productProvider.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final products = productProvider.filteredProducts;

                        // Show empty message only when filtering and no results
                        if (productProvider.isFiltering && products.isEmpty) {
                          return SizedBox(
                            width: double.infinity,
                            height: 100.h, // Adjust height as needed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'No hay productos disponibles en esta categoría',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.h4(
                                    color: AppColors.darkColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return Column(
                          children: [
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 7,
                                mainAxisExtent: 320,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final producto = products[index];
                                return ProductCard(
                                  imageUrl: producto.imageUrl.isNotEmpty
                                      ? producto.imageUrl[0]
                                      : AppAssets.uniforme,
                                  price: producto.salePrice.toString(),
                                  title: producto.name
                                      .split(' ')
                                      .map((word) =>
                                          word[0].toUpperCase() +
                                          word.substring(1).toLowerCase())
                                      .join(' '),
                                  circleColor: producto.currentStock >
                                          producto.minimumStock
                                      ? Colors.green
                                      : producto.currentStock <=
                                                  producto.minimumStock &&
                                              producto.currentStock >= 1
                                          ? Colors.orange
                                          : Colors.red,
                                  onSelect: () {
                                    context.push(
                                        '${AppRouter.productDetails}/${producto.id}');
                                  },
                                );
                              },
                            )
                          ],
                        );
                      },
                    )),
                  ),
                  SizedBox(
                    height: AppSize.defaultPadding * 4,
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
