import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/providers/product_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminDetailProductScreen extends StatelessWidget {
  final String productId;
  const AdminDetailProductScreen({super.key, required this.productId});

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
        centerTitle: true,
        title: Text(
          'Detalle del Producto',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                context.push('${AppRouter.adminProductUpdate}/$productId');
              } else if (value == 'delete') {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar eliminación'),
                    content:
                        const Text('¿Estás seguro de eliminar este producto?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Eliminar'),
                      ),
                    ],
                  ),
                );

                if (shouldDelete == true) {
                  final provider = context.read<ActionProvider>();
                  final success = await provider.deleteProduct(productId);

                  if (context.mounted) {
                    if (success) {
                      // Show success message and navigate back
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Producto eliminado correctamente')),
                      );
                      await context.read<ProductProvider>().refreshProducts();
                      context.pop();
                    } else {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al eliminar el producto')),
                      );
                    }
                  }
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Editar'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Eliminar', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _ProductDetailView(productId: productId),
    );
  }
}

class _ProductDetailView extends StatelessWidget {
  final String productId;
  const _ProductDetailView({required this.productId});
  String _getStockStatusText(int currentStock, int minimumStock) {
    if (currentStock <= 0) return 'NO HAY STOCK';
    if (currentStock <= minimumStock) return 'STOCK BAJO';
    return 'STOCK SUFICIENTE';
  }

  Color _getStockStatusColor(int currentStock, int minimumStock) {
    if (currentStock <= 0) return Colors.grey;
    if (currentStock <= minimumStock) return Colors.red;
    return Colors.green;
  }

  IconData _getStockStatusIcon(int currentStock, int minimumStock) {
    if (currentStock <= 0) return Icons.remove_shopping_cart;
    if (currentStock <= minimumStock) return Icons.warning_amber_rounded;
    return Icons.check_circle_outline;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ActionProvider, ProductProvider>(
      builder: (context, provider, productProvider, _) {
        return FutureBuilder<Products?>(
          future: provider.getProductById(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final product = snapshot.data;
            if (product == null) {
              return Center(
                child: Text(
                  'Producto no encontrado',
                  style: AppStyles.h3(color: AppColors.darkColor),
                ),
              );
            }

            return FutureBuilder<Suppliers?>(
              future:
                  Future.value(provider.getSupplierById(product.supplierId)),
              builder: (context, supplierSnapshot) {
                final supplier = supplierSnapshot.data;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.defaultPaddingHorizontal * 1.5,
                      vertical: AppSize.defaultPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stock Status Card
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSize.defaultRadius),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  product.currentStock > product.minimumStock
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
                            padding: EdgeInsets.all(AppSize.defaultPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Estado de Stock',
                                      style: AppStyles.h4(
                                          color: AppColors.darkColor50),
                                    ),
                                    SizedBox(
                                        height: AppSize.defaultPadding * 0.5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStockStatusColor(
                                                product.currentStock,
                                                product.minimumStock)
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        _getStockStatusText(
                                            product.currentStock,
                                            product.minimumStock),
                                        style: AppStyles.h3(
                                          color: _getStockStatusColor(
                                              product.currentStock,
                                              product.minimumStock),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  _getStockStatusIcon(product.currentStock,
                                      product.minimumStock),
                                  size: 48,
                                  color: _getStockStatusColor(
                                          product.currentStock,
                                          product.minimumStock)
                                      .withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: AppSize.defaultPadding * 2),

                        // Product Information
                        Text(
                          'Información del Producto',
                          style: AppStyles.h2(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: AppSize.defaultPadding),

                        _DetailItem(
                          title: 'ID del Producto',
                          value: product.id ?? 'N/A',
                        ),
                        _DetailItem(
                          title: 'Nombre',
                          value: product.name,
                        ),
                        _DetailItem(
                          title: 'Categoría',
                          value: productProvider
                              .getCategoryNameById(product.categoryId),
                        ),
                        _DetailItem(
                          title: 'Tipo de Prenda',
                          value: productProvider
                              .getTypeGarmentNameById(product.typeGarmentId),
                        ),
                        _DetailItem(
                          title: 'Talla',
                          value:
                              productProvider.getSizeNameById(product.sizeId),
                        ),
                        _DetailItem(
                          title: 'Sexo',
                          value: productProvider.getSexNameById(product.sexId),
                        ),

                        SizedBox(height: AppSize.defaultPadding),
                        Text(
                          'Información de Stock',
                          style: AppStyles.h2(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: AppSize.defaultPadding),

                        _DetailItem(
                          title: 'Stock Actual',
                          value: '${product.currentStock} unidades',
                        ),
                        _DetailItem(
                          title: 'Stock Mínimo',
                          value: '${product.minimumStock} unidades',
                        ),

                        SizedBox(height: AppSize.defaultPadding),
                        Text(
                          'Información de Precios',
                          style: AppStyles.h2(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: AppSize.defaultPadding),
                        _DetailItem(
                          title: 'Precio de Venta',
                          value: 'S/ ${product.salePrice}',
                        ),

                        //Info proovedor
                        SizedBox(height: AppSize.defaultPadding),
                        if (supplier != null) ...[
                          Text(
                            'Información del Proveedor',
                            style: AppStyles.h2(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppSize.defaultPadding),
                          _DetailItem(
                            title: 'Proveedor',
                            value: supplier.id ?? 'N/A',
                          ),
                          _DetailItem(
                            title: 'Proveedor',
                            value: supplier.name,
                          ),
                          _DetailItem(
                            title: 'Descripción',
                            value: supplier.description,
                          ),
                          _DetailItem(
                            title: 'DNI',
                            value: supplier.dni,
                          ),
                          _DetailItem(
                            title: 'Teléfono',
                            value: supplier.phone,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const _DetailItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSize.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.h3(
              color: AppColors.darkColor50,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: AppSize.defaultPadding * 0.25),
          Text(
            value,
            style: AppStyles.h4(
              color: AppColors.darkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
