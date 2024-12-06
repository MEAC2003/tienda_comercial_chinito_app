import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class CustomListTile extends StatelessWidget {
  final Icon leadingIcon;
  final String title;
  final Icon trailingIcon;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leadingIcon,
      title: Text(
        title,
        style: AppStyles.h3(
          fontWeight: FontWeight.w600,
          color: AppColors.darkColor,
        ),
      ),
      trailing: trailingIcon,
      onTap: onTap,
    );
  }
}
