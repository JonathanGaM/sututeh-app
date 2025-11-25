import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// ignore: unused_import
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'modulos/carga/paginas/carga_pagina.dart';
import 'modulos/autenticacion/paginas/login_pagina.dart';
import 'modulos/notificaciones/paginas/notificaciones_pagina.dart';
import 'modulos/notificaciones/servicios/push_handler.dart';
// ignore: unused_import
// ignore: unused_import
import 'firebase_background.dart';

// =====================================
// 🔥 Handler definitivo en background
// =====================================

// =====================================
// 🚀 MAIN DEFINITIVO (SIN ERROR DUPLICADO)
// =====================================
void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      print("📱 Iniciando app…");

      // 🔥 Android YA INICIALIZA Firebase SOLO desde google-services.json
      // ❗ No llamar Firebase.initializeApp() otra vez para evitar duplicate-app
      if (Firebase.apps.isEmpty) {
        try {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
          print("⚠️ Firebase inicializado manualmente (caso raro)");
        } catch (e) {
          print("⚠️ Firebase ya estaba inicializado por Android");
        }
      }

      // 🔔 Registrar handler en segundo plano
      FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

      // 🔔 Inicializar notificaciones (solo una vez)
      await PushHandler.initNotifications();

      print("✅ Todo listo, lanzando aplicación");

      runApp(const MyApp());
    },
    (error, stack) {
      print("❌ ERROR FATAL NO CAPTURADO: $error");
      print("Stack: $stack");
    },
  );
}

// =====================================
// 🧱 APP
// =====================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: {'/notificaciones': (_) => const NotificacionesPagina()},
      home: const SplashWrapper(),
    );
  }
}

// =====================================
// ⏳ SPLASH
// =====================================
class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    print("🎬 SplashWrapper iniciado");

    Timer(const Duration(seconds: 5), () {
      print("⏱️ Navegando a LoginPagina...");
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPagina()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("🖼️ Renderizando CargaPagina");
    return const CargaPagina();
  }
}
