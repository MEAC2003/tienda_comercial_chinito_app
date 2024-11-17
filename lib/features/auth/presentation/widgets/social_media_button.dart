import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class SocialMediaButton extends StatelessWidget {
  final String imgPath;
  final String text;
  final VoidCallback onPressed;
  const SocialMediaButton({
    super.key,
    required this.text,
    required this.imgPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.defaultPadding * 1.32.h,
          vertical: AppSize.defaultPadding),
      child: SizedBox(
        width: double.infinity,
        height: 60.h,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor:
                const WidgetStatePropertyAll(AppColors.primaryGrey),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppSize.defaultRadius * 1.6.w),
              ),
            ),
          ),
          onPressed: onPressed,
          icon: Image.asset(
            imgPath,
            width: 24.w,
            height: 24.h,
          ),
          label: Text(
            text,
            style: AppStyles.h4(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
