import 'package:flutter/material.dart';
import 'dart:async'; // 👈 necesario para Timer
import 'package:firebase_core/firebase_core.dart';  // 👈 AGREGAR
import 'firebase_options.dart';  // 👈 AGREGAR
import 'modulos/carga/paginas/carga_pagina.dart';
import 'modulos/autenticacion/paginas/login_pagina.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Ignorar si ya existe la app
    print('Firebase ya inicializado: $e');
  }
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SUTUTEH App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const SplashWrapper(), // 👈 Tu splash se mantiene igual
    );
  }
}

// Pantalla inicial que muestra splash y redirige después de 15s
class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPagina()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CargaPagina();
  }
}