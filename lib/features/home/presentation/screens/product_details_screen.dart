import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/providers/product_provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/providers/users_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Provider.of<ProductProvider>(context, listen: false)
                .resetQuantityForProduct(productId);
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Detalle del producto',
          style: AppStyles.h3(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _ProductDetailsView(productId),
    );
  }
}

class _ProductDetailsView extends StatelessWidget {
  final String productId;
  const _ProductDetailsView(this.productId);

  void _showStockEmptyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Producto sin Stock'),
          content:
              const Text('Este producto no está disponible en este momento.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(
      BuildContext context, Function onConfirm, int quantity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Pedido'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('¿Está seguro que desea confirmar este pedido?'),
              const SizedBox(height: 8),
              Text(
                'Cantidad: $quantity',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  void _showResultDialog(BuildContext context, bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Éxito' : 'Error'),
          content: Text(
            success
                ? 'Pedido confirmado exitosamente'
                : 'Error al confirmar el pedido',
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                if (success) {
                  Navigator.pop(context); // Return to previous screen
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, UserProvider>(
      builder: (context, productProvider, userProvider, child) {
        final product = productProvider.getProductById(productId);
        final quantity = productProvider.getQuantity(productId);
        final user = userProvider.user;
        if (product == null) {
          return const Center(child: Text('Producto no encontrado'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImageCarousel(
                      imageUrls: product.imageUrl,
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding * 1.5,
                    ),
                    Text(
                      productProvider.getSchoolNameById(product.schoolId),
                      style: AppStyles.h3(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding / 2,
                    ),
                    Text(
                      product.name
                          .split(' ')
                          .map((word) =>
                              word[0].toUpperCase() +
                              word.substring(1).toLowerCase())
                          .join(' '),
                      style: AppStyles.h2(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding / 1.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'S/. ${product.salePrice.toStringAsFixed(2)}',
                          style: AppStyles.h2(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding,
                    ),
                    Text(
                      'Categoria: ${productProvider.getCategoryNameById(product.categoryId)}',
                      style: AppStyles.h3(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Talla',
                          style: AppStyles.h3(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: AppSize.defaultPadding / 1.5,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  AppSize.defaultPaddingHorizontal * 1.7,
                              vertical: AppSize.defaultPadding / 2.5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(
                                  AppSize.defaultRadius * 1.5),
                              border: Border.all(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            child: Text(
                              productProvider.getSizeNameById(product.sizeId),
                              style: AppStyles.h3(
                                color: AppColors.primaryGrey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Disponible: ${product.currentStock}',
                          style: AppStyles.h3(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                productProvider.decreaseQuantity(productId);
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                child: const Icon(
                                  Icons.remove,
                                  color: AppColors.darkColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                              height: 30.h,
                              child: Center(
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    color: AppColors.darkColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                productProvider.increaseQuantity(productId);
                              },
                              child: SizedBox(
                                width: 30.w,
                                height: 30.h,
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.darkColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.defaultPadding * 2,
                    ),
                    CustomActionButton(
                      text: 'Confirmar pedido',
                      color: product.currentStock > 0
                          ? AppColors.primaryColor
                          : Colors.grey,
                      onPressed: product.currentStock > 0
                          ? () {
                              final quantity =
                                  productProvider.getQuantity(productId);
                              if (quantity > product.currentStock) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Cantidad solicitada excede el stock disponible')),
                                );
                                return;
                              }
                              _showConfirmationDialog(context, () async {
                                try {
                                  // Show loading indicator
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );

                                  final userId = user!.id;
                                  final success = await productProvider
                                      .confirmOrder(productId, userId);

                                  // Hide loading indicator
                                  Navigator.pop(context);

                                  _showResultDialog(context, success);
                                } catch (e) {
                                  _showResultDialog(context, false);
                                }
                              }, quantity);
                            }
                          : () => _showStockEmptyDialog(context),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
