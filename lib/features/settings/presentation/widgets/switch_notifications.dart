import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class SwitchNotifications extends StatelessWidget {
  const SwitchNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          const Icon(Icons.notifications_none),
          SizedBox(width: AppSize.defaultPaddingHorizontal * 0.2),
          Text(
            'Notifications',
            style: AppStyles.h3(
              fontWeight: FontWeight.w600,
              color: AppColors.darkColor,
            ),
          ),
        ],
      ),
      value: false,
      onChanged: (value) {},
    );
  }
}
