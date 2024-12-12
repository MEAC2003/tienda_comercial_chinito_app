import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static const _lastNotificationKey = 'last_notification_';
  static const _minimumInterval = Duration(minutes: 10);

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {}

  static Future<void> init() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
    }
  }

  static Future<void> showNotification(String title, String body,
      {String? productId}) async {
    // Si hay productId, verificar si podemos mostrar la notificación
    if (productId != null) {
      if (!await _canShowNotification(productId)) {
        return;
      }
      await _updateLastNotificationTime(productId);
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      enableVibration: true,
      enableLights: true,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    try {
      await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecond,
        title,
        body,
        platformDetails,
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  static Future<void> showNotificationSchedule(
      String title, String body, DateTime scheduleDate) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(scheduleDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<bool> _canShowNotification(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final lastNotificationTime =
        prefs.getInt('${_lastNotificationKey}$productId');

    if (lastNotificationTime == null) return true;

    final lastDateTime =
        DateTime.fromMillisecondsSinceEpoch(lastNotificationTime);
    final now = DateTime.now();

    return now.difference(lastDateTime) > _minimumInterval;
  }

  static Future<void> _updateLastNotificationTime(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${_lastNotificationKey}$productId',
        DateTime.now().millisecondsSinceEpoch);
  }

  static Future<void> checkStockAndNotify(int currentStock, String productId,
      String productName, int threshold) async {
    if (!await _canShowNotification(productId)) {
      return;
    }

    if (currentStock <= threshold) {
      String message = currentStock == 0
          ? 'No hay stock disponible!'
          : 'Stock bajo: quedan $currentStock unidades';

      await showNotification('Alerta de Stock', '$productName: $message',
          productId: productId);
    }
  }
}
