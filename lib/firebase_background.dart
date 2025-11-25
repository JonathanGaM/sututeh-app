import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();

  final plugin = FlutterLocalNotificationsPlugin();

  const androidDetails = AndroidNotificationDetails(
    'canal_sututeh',
    'Notificaciones SUTUTEH',
    channelDescription: 'Canal oficial del sindicato',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@drawable/ic_stat_sututeh',
  );

  await plugin.show(
    message.hashCode,
    message.notification?.title,
    message.notification?.body,
    const NotificationDetails(android: androidDetails),
    payload: jsonEncode(message.data),
  );
}
