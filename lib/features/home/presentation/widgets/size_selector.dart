import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/app_colors.dart';
import 'package:tienda_comercial_chinito_app/utils/app_size.dart';
import 'package:tienda_comercial_chinito_app/utils/app_styles.dart';

class SizeSelector extends StatefulWidget {
  final Function(String) onSizeSelected;

  const SizeSelector({
    super.key,
    required this.onSizeSelected,
  });

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  final List<String> sizes = ['S', 'M', 'X', 'XL'];
  String selectedSize = 'S';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tallas',
          style: AppStyles.h3(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: sizes.map((size) {
            return Padding(
              padding: EdgeInsets.only(left: AppSize.defaultPadding / 2),
              child: Material(
                color: Colors.transparent,
                type: MaterialType.button,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSize = size;
                    });
                    widget.onSizeSelected(size);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.defaultPaddingHorizontal,
                        vertical: AppSize.defaultPadding / 2),
                    decoration: BoxDecoration(
                      color: selectedSize == size
                          ? AppColors.primaryColor
                          : AppColors.primaryGrey,
                      borderRadius:
                          BorderRadius.circular(AppSize.defaultRadius * 2),
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: selectedSize == size
                            ? AppColors.primaryGrey
                            : AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
