import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../../config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PushHandler {
  static final FlutterLocalNotificationsPlugin noti =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel canal = AndroidNotificationChannel(
    'canal_sututeh',
    'Notificaciones SUTUTEH',
    description: 'Canal oficial del sindicato SUTUTEH',
    importance: Importance.max,
    showBadge: true,
  );

  /// ============================================================
  /// 🔥 INICIALIZAR NOTIFICACIONES (DEBES LLAMAR ESTO EN main() )
  /// ============================================================
  static Future<void> initNotifications() async {
    // 1️⃣ Crear canal obligatorio Android 13+
    await noti
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(canal);

    // 2️⃣ Inicializar notificaciones locales
    const android = AndroidInitializationSettings('@drawable/ic_stat_sututeh');
    const initSettings = InitializationSettings(android: android);

    await noti.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        _manejarClick(details.payload);
      },
    );

    // 3️⃣ Pedir permisos
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 4️⃣ Mensajes en FOREGROUND
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _mostrarNotificacion(message);
    });

    // 5️⃣ Cuando la app se abre DESDE una notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _manejarClick(jsonEncode(message.data));
    });

    // 6️⃣ Token refrescado
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await _enviarTokenAlBackend(newToken);
    });
  }

  /// ============================================================
  /// 🔥 Mostrar notificación local
  /// ============================================================
  static Future<void> _mostrarNotificacion(RemoteMessage message) async {
    final notiData = message.notification;
    final data = message.data;

    if (notiData == null) return;

    final androidDetails = AndroidNotificationDetails(
      canal.id,
      canal.name,
      channelDescription: canal.description,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/ic_stat_sututeh',
    );

    await noti.show(
      notiData.hashCode,
      notiData.title,
      notiData.body,
      NotificationDetails(android: androidDetails),
      payload: jsonEncode(data),
    );
  }

  /// ============================================================
  /// 🔥 Navegar según click
  /// ============================================================
  static void _manejarClick(String? payload) {
    if (payload == null) return;

    final data = jsonDecode(payload);

    final tipo = data['tipo'] ?? '';

    // Ejemplos:
    if (tipo == 'nueva_reunion' ||
        tipo == 'recordatorio_24h' ||
        tipo == 'recordatorio_4h') {
      navigatorKey.currentState?.pushNamed('/notificaciones');
    }
  }

  /// ============================================================
  /// 🔥 Enviar token al backend
  /// ============================================================
  static Future<void> _enviarTokenAlBackend(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');

      if (userId == null) return;

      await http.post(
        Uri.parse(ApiConfig.guardarTokenFcm),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "usuario_id": userId,
          "token": token,
          "dispositivo": "Android",
        }),
      );
    } catch (_) {}
  }
}

/// USADO PARA NAVEGAR SIN CONTEXTO
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
