import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class CustomActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.defaultRadius * 1.5),
          ),
          padding: EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
        ),
        child: Text(
          text,
          style: AppStyles.h3(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
