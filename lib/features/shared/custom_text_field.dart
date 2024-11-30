import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final bool? obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText,
    required this.icon,
    this.controller,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.defaultPaddingHorizontal * 1.5,
          vertical: AppSize.defaultPadding * 0.75),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(AppSize.defaultRadius),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPaddingHorizontal),
              child: icon,
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(right: AppSize.defaultPaddingHorizontal),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                    ),
                  ),
                  child: SizedBox(
                    height: 56.h,
                    child: TextFormField(
                      controller: controller,
                      style: AppStyles.h4(
                        fontWeight: FontWeight.w600,
                      ),
                      obscureText: obscureText ?? false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintText: hintText,
                      ),
                      validator: validator,
                      readOnly: readOnly, // Añade esta línea
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
