import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';
// Import your inventory movements provider and other necessary imports

enum FilterType {
  date,
  type,
  none,
}

class AdminInventoryMovementsScreen extends StatefulWidget {
  const AdminInventoryMovementsScreen({super.key});

  @override
  State<AdminInventoryMovementsScreen> createState() =>
      _AdminInventoryMovementsScreenState();
}

class _AdminInventoryMovementsScreenState
    extends State<AdminInventoryMovementsScreen> {
  FilterType _selectedFilter = FilterType.none;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActionProvider>().loadMovements();
    });
  }

  Widget _buildFilterOptions() {
    switch (_selectedFilter) {
      case FilterType.date:
        return _buildDateFilterOptions();
      case FilterType.type:
        return _buildTypeFilterOptions();
      case FilterType.none:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDateFilterOptions() {
    final provider = context.read<ActionProvider>();
    return FilterCategories(
      key: ValueKey(provider.resetKey),
      categories: ['Todo', 'Hoy', 'Esta semana', 'Este mes'],
      initialCategory: 'Todo',
      onCategorySelected: (selectedCategory) {
        final now = DateTime.now();
        switch (selectedCategory) {
          case 'Hoy':
            provider.filterByDateRange(
              DateTime(now.year, now.month, now.day),
              now,
            );
            break;
          case 'Esta semana':
            provider.filterByDateRange(
              now.subtract(const Duration(days: 7)),
              now,
            );
            break;
          case 'Este mes':
            provider.filterByDateRange(
              DateTime(now.year, now.month, 1),
              now,
            );
            break;
          case 'Todo':
            provider.resetFilters();
            break;
        }
      },
      selectedColor: AppColors.primarySkyBlue,
    );
  }

  Widget _buildTypeFilterOptions() {
    final provider = context.read<ActionProvider>();
    return FilterCategories(
      key: ValueKey(provider.resetKey),
      categories: ['Todo', 'Entrada', 'Salida'],
      initialCategory: 'Todo',
      onCategorySelected: (selectedCategory) {
        if (selectedCategory == 'Todo') {
          provider.resetFilters();
        } else {
          provider.filterByType(
            selectedCategory == 'Entrada' ? 1 : 2,
          );
        }
      },
      selectedColor: AppColors.primarySkyBlue,
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
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.5,
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
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Fecha'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedFilter = FilterType.date;
                        context.read<ActionProvider>().resetFilters();
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.swap_horiz),
                  title: const Text('Tipo de Movimiento'),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedFilter = FilterType.type;
                        context.read<ActionProvider>().resetFilters();
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
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Movimientos de Inventario',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                    borderRadius: BorderRadius.circular(AppSize.defaultRadius),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      context.read<ActionProvider>().searchMovements(value);
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

                // Header and Filter Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Movimientos',
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
                SizedBox(
                  height: AppSize.defaultPadding,
                ),
                // Filter Options
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

                Consumer<ActionProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primarySkyBlue,
                        ),
                      );
                    }

                    final movements = provider.movements;

                    if (movements.isEmpty) {
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
                              'No hay movimientos disponibles',
                              style: AppStyles.h4(color: AppColors.darkColor),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: movements.length,
                      itemBuilder: (context, index) {
                        final movement = movements[index];
                        return Card(
                          elevation: 2,
                          margin:
                              EdgeInsets.only(bottom: AppSize.defaultPadding),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSize.defaultRadius),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  movement.movementTypeId == 1
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  Colors.white,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius:
                                  BorderRadius.circular(AppSize.defaultRadius),
                            ),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.all(AppSize.defaultPadding),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: FutureBuilder<Products?>(
                                      future: provider
                                          .getProductById(movement.productId),
                                      builder: (context, snapshot) {
                                        //carga de productos
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text(
                                            'Cargando...',
                                            style: AppStyles.h4(
                                              color: AppColors.darkColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                            'Error',
                                            style: AppStyles.h4(
                                              color: AppColors.darkColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        } else if (!snapshot.hasData ||
                                            snapshot.data == null) {
                                          return Text(
                                            'No encontrado',
                                            style: AppStyles.h4(
                                              color: AppColors.darkColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        } else {
                                          return Text(
                                            'Producto: ${snapshot.data!.name}',
                                            style: AppStyles.h4(
                                              color: AppColors.darkColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: AppSize.defaultPadding),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (movement.movementTypeId == 1
                                              ? Colors.green
                                              : AppColors.primaryRed)
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(
                                          AppSize.defaultRadius),
                                    ),
                                    child: Text(
                                      movement.movementTypeId == 1
                                          ? 'ENTRADA'
                                          : 'SALIDA',
                                      style: AppStyles.h3(
                                        color: movement.movementTypeId == 1
                                            ? Colors.green
                                            : AppColors.primaryRed,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(
                                    top: AppSize.defaultPadding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Cantidad: ${movement.quantity}',
                                      style: AppStyles.h3(
                                        color: AppColors.darkColor50,
                                      ),
                                    ),
                                    Text(
                                      provider.formatDate(movement.createdAt),
                                      style: AppStyles.h3(
                                        color: AppColors.darkColor50,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: AppColors.primarySkyBlue,
                              ),
                              onTap: () {
                                context.push(
                                    '${AppRouter.adminInventoryMovementsDetail}/${movement.id}');
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: AppSize.defaultPadding * 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
