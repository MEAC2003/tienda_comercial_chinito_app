import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/widgets/widgets.dart';

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 7,
        mainAxisExtent:
            320, // Ajusta esta altura según el tamaño de tu ProductCard
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          imageUrl: product['imageUrl'],
          price: product['price'],
          title: product['title'],
          circleColor: product['circleColor'],
          onSelect: () {
            // Navegar a la pantalla de detalles del producto
            GoRouter.of(context).push(
              AppRouter.productDetails,
            );
          },
        );
      },
    );
  }
}
