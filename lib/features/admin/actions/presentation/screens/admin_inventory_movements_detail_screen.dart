import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminInventoryMovementsDetailScreen extends StatelessWidget {
  final String movementId;
  const AdminInventoryMovementsDetailScreen({
    super.key,
    required this.movementId,
  });

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
          'Detalle de Movimiento',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _InventaryMovementDetailView(movementId: movementId),
    );
  }
}

class _InventaryMovementDetailView extends StatelessWidget {
  const _InventaryMovementDetailView({
    required this.movementId,
  });

  final String movementId;

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionProvider>(
      builder: (context, provider, _) {
        final movement = provider.getMovementById(movementId);
        final user = provider.getUserById(movement?.userId ?? '');

        if (movement == null) {
          return Center(
            child: Text(
              'Movimiento no encontrado',
              style: AppStyles.h3(color: AppColors.darkColor),
            ),
          );
        }

        return FutureBuilder<Products?>(
          future: provider.getProductById(movement.productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final product = snapshot.data;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPaddingHorizontal * 1.5,
                  vertical: AppSize.defaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Card with movement type
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
                        padding: EdgeInsets.all(AppSize.defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Estado',
                                  style: AppStyles.h4(
                                    color: AppColors.darkColor50,
                                  ),
                                ),
                                SizedBox(height: AppSize.defaultPadding * 0.5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (movement.movementTypeId == 1
                                            ? Colors.green
                                            : Colors.red)
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    movement.movementTypeId == 1
                                        ? 'ENTRADA'
                                        : 'SALIDA',
                                    style: AppStyles.h2(
                                      color: movement.movementTypeId == 1
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              movement.movementTypeId == 1
                                  ? Icons.add_circle_outline
                                  : Icons.remove_circle_outline,
                              size: 48,
                              color: movement.movementTypeId == 1
                                  ? Colors.green.withOpacity(0.5)
                                  : Colors.red.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: AppSize.defaultPadding * 2),

                    // Movement Details Section
                    Text(
                      'Detalles del Movimiento',
                      style: AppStyles.h2(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding),

                    // Movement Information
                    _DetailItem(
                      title: 'ID de Movimiento',
                      value: movement.id ?? 'N/A',
                    ),
                    _DetailItem(
                      title: 'Fecha y Hora',
                      value: provider.formatDate(movement.createdAt),
                    ),
                    _DetailItem(
                      title: 'Tipo de Movimiento',
                      value:
                          movement.movementTypeId == 1 ? 'Entrada' : 'Salida',
                    ),
                    _DetailItem(
                      title: 'Cantidad',
                      value: '${movement.quantity} unidades',
                    ),

                    // Product Information
                    SizedBox(height: AppSize.defaultPadding),
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
                      value: movement.productId,
                    ),
                    _DetailItem(
                      title: 'Nombre del Producto',
                      value: product?.name ?? 'Producto no encontrado',
                    ),
                    _DetailItem(
                      title: 'Stock Actual',
                      value: '${product?.currentStock ?? 'N/A'} unidades',
                    ),
                    _DetailItem(
                      title: 'Stock Mínimo',
                      value: '${product?.minimumStock ?? 'N/A'} unidades',
                    ),
                    _DetailItem(
                      title: 'Precio de Venta',
                      value: 'S/ ${product?.salePrice ?? 'N/A'}',
                    ),

                    // Additional Information
                    SizedBox(height: AppSize.defaultPadding),
                    Text(
                      'Información Adicional',
                      style: AppStyles.h2(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding),
                    _DetailItem(
                      title: 'ID de Usuario',
                      value: movement.userId,
                    ),
                    _DetailItem(
                      title: 'Usuario',
                      //Nombre en mayuscula y minuscula
                      value: (user?.fullName ?? 'Usuario no encontrado')
                          .split(' ')
                          .map((word) =>
                              word.substring(0, 1).toUpperCase() +
                              word.substring(1).toLowerCase())
                          .join(' '),
                    ),
                    //Correo
                    _DetailItem(
                      title: 'Correo',
                      value: user?.email ?? 'Correo no encontrado',
                    ),
                  ],
                ),
              ),
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
