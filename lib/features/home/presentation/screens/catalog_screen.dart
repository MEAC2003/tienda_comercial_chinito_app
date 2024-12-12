import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/providers/product_provider.dart';
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

enum FilterType {
  schools,
  typeGarment,
  sex,
  ageGroup,
  size,
  stock,
  none,
}

class _CatalogView extends StatefulWidget {
  const _CatalogView();

  @override
  State<_CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<_CatalogView> {
  FilterType _selectedFilter = FilterType.none;

  Widget _buildFilterOptions() {
    switch (_selectedFilter) {
      case FilterType.schools:
        return _buildSchoolFilterOptions();
      case FilterType.typeGarment:
        return _buildTypeGarmentFilterOptions();
      case FilterType.sex:
        return _buildSexFilterOptions();
      case FilterType.ageGroup:
        return _buildLevelFilterOptions();
      case FilterType.size:
        return _buildSizeFilterOptions();
      case FilterType.stock:
        return _buildStockFilterOptions();
      case FilterType.none:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSexFilterOptions() {
    final productProvider = Provider.of<ProductProvider>(context);
    return FilterCategories(
      key: ValueKey(productProvider.resetKey), // Cambia la clave al resetear.
      categories: ['Todo', ...productProvider.sexName],
      initialCategory: 'Todo',
      onCategorySelected: (selectedCategory) {
        if (selectedCategory == 'Todo') {
          productProvider.resetFilter(); // Resetea el filtro.
        } else {
          productProvider.filterBySex(selectedCategory);
        }
      },
    );
  }

  Widget _buildTypeGarmentFilterOptions() {
    final productProvider = Provider.of<ProductProvider>(context);
    return FilterCategories(
      key: ValueKey(productProvider.resetKey),
      categories: ['Todo', ...productProvider.typeGarmentName],
      initialCategory: 'Todo',
      onCategorySelected: (selectedCategory) {
        if (selectedCategory == 'Todo') {
          // Reset the filter or show all products
          productProvider.resetFilter();
        } else {
          productProvider.filterByTypeGarment(selectedCategory);
        }
      },
    );
  }

  Widget _buildSchoolFilterOptions() {
    final productProvider = Provider.of<ProductProvider>(context);
    return FilterCategories(
      key: ValueKey(productProvider.resetKey),
      categories: ['Todo', ...productProvider.schoolsName],
      initialCategory: 'Todo',
      onCategorySelected: (selectedCategory) {
        if (selectedCategory == 'Todo') {
          // Reset the filter or show all products
          productProvider.resetFilter();
        } else {
          productProvider.filterBySchool(selectedCategory);
        }
      },
    );
  }

  Widget _buildLevelFilterOptions() {
    final productProvider = Provider.of<ProductProvider>(context);
    return FilterCategories(
      key: ValueKey(productProvider.resetKey),
      categories: ['Todo', ...productProvider.categoriesName],
      initialCategory: 'Todo',
      onCategorySelected: (selectedCategory) {
        if (selectedCategory == 'Todo') {
          // Reset the filter or show all products
          productProvider.resetFilter();
        } else {
          productProvider.filterByCategory(selectedCategory);
        }
      },
    );
  }

  Widget _buildSizeFilterOptions() {
    final productProvider = Provider.of<ProductProvider>(context);
    return FilterCategories(
      key: ValueKey(productProvider.resetKey),
      categories: ['Todo', ...productProvider.sizesName],
      initialCategory: 'Todo',
      onCategorySelected: (selectedCategory) {
        if (selectedCategory == 'Todo') {
          // Reset the filter or show all products
          productProvider.resetFilter();
        } else {
          productProvider.filterBySize(selectedCategory);
        }
      },
    );
  }

  Widget _buildStockFilterOptions() {
    final productProvider = Provider.of<ProductProvider>(context);
    return FilterCategories(
      key: ValueKey(productProvider.resetKey),
      categories: ['Todo', ...productProvider.getStockOptions()],
      initialCategory: 'Todo',
      onCategorySelected: (selectedCategory) {
        if (selectedCategory == 'Todo') {
          productProvider.resetFilter();
        } else {
          productProvider.filterByStock(selectedCategory);
        }
      },
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: DraggableScrollableSheet(
          initialChildSize: 0.59,
          minChildSize: 0.4,
          maxChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) => Container(
            padding: const EdgeInsets.all(16),
            child: ListView(
              controller: scrollController,
              children: [
                Text(
                  'Filtrar por',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSize.defaultPadding),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Colegios'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedFilter = FilterType.schools;
                        context.read<ProductProvider>().resetFilter();
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.checkroom),
                  title: const Text('Tipo de Prenda'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedFilter = FilterType.typeGarment;
                        context.read<ProductProvider>().resetFilter();
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Sexo'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedFilter = FilterType.sex;
                        context.read<ProductProvider>().resetFilter();
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.face),
                  title: const Text('Edad'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedFilter = FilterType.ageGroup;
                        context.read<ProductProvider>().resetFilter();
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.straighten),
                  title: const Text('Talla'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedFilter = FilterType.size;
                        context.read<ProductProvider>().resetFilter();
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.inventory),
                  title: const Text('Stock'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedFilter = FilterType.stock;
                        context.read<ProductProvider>().resetFilter();
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<ProductProvider>().refreshProducts(),
      child: SafeArea(
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
                        onChanged: (value) {
                          context.read<ProductProvider>().searchProducts(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Buscar productos...',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Catálogo',
                          style: AppStyles.h2(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () => _showFilterModal(context),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding,
                    ),
                    if (_selectedFilter != FilterType.none)
                      Row(
                        children: [
                          Expanded(
                            child: _buildFilterOptions(),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: AppSize.defaultPadding * 1.5,
                    ),
                    SizedBox(
                      child: SingleChildScrollView(
                          child: Consumer<ProductProvider>(
                        builder: (context, productProvider, child) {
                          if (productProvider.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final products = productProvider.filteredProducts;

                          if (products.isEmpty) {
                            if (productProvider.isSearching) {
                              return SizedBox(
                                width: double.infinity,
                                height: 100.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No se encontraron productos que coincidan con tu búsqueda',
                                      textAlign: TextAlign.center,
                                      style: AppStyles.h4(
                                        color: AppColors.darkColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (productProvider.isFiltering) {
                              return SizedBox(
                                width: double.infinity,
                                height: 100.h,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
