import 'package:flutter/material.dart';

import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class CustomTextFields extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  const CustomTextFields({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.obscureText,
    this.validator,
    this.onSaved,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.h4(
            color: AppColors.primarySkyBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
          ),
          style: AppStyles.h5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSize.defaultPadding),
      ],
    );
  }
}
