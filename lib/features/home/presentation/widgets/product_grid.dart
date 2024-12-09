import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/widgets/widgets.dart';

class ProductGrid extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String title;
  final Color circleColor;
  final VoidCallback onSelect;

  const ProductGrid({
    super.key,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.onSelect,
    required this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 2,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 7,
        mainAxisExtent: 320,
      ),
      itemBuilder: (context, index) {
        return ProductCard(
          imageUrl: imageUrl,
          price: price,
          title: title,
          circleColor: circleColor,
          onSelect: onSelect,
        );
      },
    );
  }
}
