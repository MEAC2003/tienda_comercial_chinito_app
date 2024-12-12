import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';
import 'package:tienda_comercial_chinito_app/services/notification_service.dart';

class SwitchNotifications extends StatefulWidget {
  const SwitchNotifications({super.key});

  @override
  State<SwitchNotifications> createState() => _SwitchNotificationsState();
}

class _SwitchNotificationsState extends State<SwitchNotifications> {
  bool _notificationsEnabled = false;
  final String _notificationKey = 'stock_notifications_enabled';

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
    // Initialize notifications
    NotificationService.init();
  }

  Future<void> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool(_notificationKey) ?? false;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationKey, value);

    setState(() {
      _notificationsEnabled = value;
    });

    if (value) {
      // Enable notifications
      await NotificationService.showNotification(
          'Notificaciones de Stock Activadas',
          'Te notificaremos cuando haya cambios en el stock de productos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          const Icon(Icons.notifications_none),
          SizedBox(width: AppSize.defaultPaddingHorizontal * 0.2),
          Text(
            'Notificaciones',
            style: AppStyles.h3(
              fontWeight: FontWeight.w600,
              color: AppColors.darkColor,
            ),
          ),
        ],
      ),
      value: _notificationsEnabled,
      onChanged: _toggleNotifications,
    );
  }
}
