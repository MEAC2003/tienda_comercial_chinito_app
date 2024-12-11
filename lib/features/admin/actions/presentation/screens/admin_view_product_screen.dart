import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/providers/product_provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

enum FilterTypes {
  schools,
  typeGarment,
  sex,
  ageGroup,
  size,
  stock,
  none,
}

class AdminViewProductScreen extends StatefulWidget {
  const AdminViewProductScreen({super.key});

  @override
  State<AdminViewProductScreen> createState() => _AdminViewProductScreenState();
}

class _AdminViewProductScreenState extends State<AdminViewProductScreen> {
  FilterTypes _selectedFilters = FilterTypes.none;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProduct();
    });
  }

  Widget _buildFilterOptions() {
    switch (_selectedFilters) {
      case FilterTypes.schools:
        return _buildSchoolFilterOptions();
      case FilterTypes.typeGarment:
        return _buildTypeGarmentFilterOptions();
      case FilterTypes.sex:
        return _buildSexFilterOptions();
      case FilterTypes.ageGroup:
        return _buildLevelFilterOptions();
      case FilterTypes.size:
        return _buildSizeFilterOptions();
      case FilterTypes.stock:
        return _buildStockFilterOptions();
      case FilterTypes.none:
        return const SizedBox.shrink();
    }
  }

  // Implement all filter option methods from CatalogScreen
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
                        _selectedFilters = FilterTypes.schools;
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
                        _selectedFilters = FilterTypes.typeGarment;
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
                        _selectedFilters = FilterTypes.sex;
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
                        _selectedFilters = FilterTypes.ageGroup;
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
                        _selectedFilters = FilterTypes.size;
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
                        _selectedFilters = FilterTypes.stock;
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Productos',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppRouter.adminAddProduct),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<ProductProvider>().refreshProducts(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search TextField
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 240, 243, 243),
                          Color.fromARGB(255, 243, 241, 241),
                          Color.fromARGB(255, 231, 231, 231),
                        ],
                        stops: [0.03, 0.12, 1.0],
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
                        hintStyle: AppStyles.h4(color: AppColors.darkColor50),
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSize.defaultPadding * 2),

                  // Header and Filter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Productos',
                        style: AppStyles.h2(
                          color: AppColors.darkColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () => _showFilterModal(context),
                      ),
                    ],
                  ),

                  if (_selectedFilters != FilterTypes.none)
                    Row(
                      children: [
                        Expanded(child: _buildFilterOptions()),
                      ],
                    ),

                  SizedBox(height: AppSize.defaultPadding * 1.5),

                  // Products Grid
                  Consumer<ProductProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final products = provider.filteredProducts;

                      if (products.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 64,
                                color: AppColors.darkColor50,
                              ),
                              SizedBox(height: AppSize.defaultPadding),
                              Text(
                                'No hay productos disponibles',
                                style: AppStyles.h4(color: AppColors.darkColor),
                              ),
                            ],
                          ),
                        );
                      }

                      return GridView.builder(
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
                          final product = products[index];
                          return ProductCard(
                            textButton: 'Ver detalles',
                            color: AppColors.primarySkyBlue,
                            imageUrl: product.imageUrl.isNotEmpty
                                ? product.imageUrl[0]
                                : AppAssets.uniforme,
                            price: product.salePrice.toString(),
                            title: product.name,
                            circleColor:
                                product.currentStock > product.minimumStock
                                    ? Colors.green
                                    : product.currentStock <=
                                                product.minimumStock &&
                                            product.currentStock >= 1
                                        ? Colors.orange
                                        : Colors.red,
                            onSelect: () {
                              context.push(
                                  '${AppRouter.adminDetailProduct}/${product.id}');
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
