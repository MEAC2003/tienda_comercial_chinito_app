// product_card.dart
import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String title;
  final Color circleColor;
  final VoidCallback onSelect;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.onSelect,
    required this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      child: Column(
        children: [
          // Imagen del producto
          ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(AppSize.defaultRadius * 1.2)),
            child: Image.network(
              imageUrl,
              height: 187.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback image if network image fails
                return Container(
                  height: 187.h,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50.w,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 187.h,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          // Contenido del producto
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: AppSize.defaultPadding * 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Precio
                Row(
                  children: [
                    Text(
                      'S/. ',
                      style: AppStyles.h4(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      price,
                      style: AppStyles.h4(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 15.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                        color: circleColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.defaultPadding * 0.5),
                // Título del producto
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSize.defaultPadding * 0.7),
                // Botón Seleccionar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSelect,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.primaryGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultRadius),
                      ),
                    ),
                    child: Text(
                      'Seleccionar',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
