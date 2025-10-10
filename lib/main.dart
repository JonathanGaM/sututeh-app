import 'package:flutter/material.dart';
import 'dart:async'; // 👈 necesario para Timer
import 'modulos/carga/paginas/carga_pagina.dart';
import 'modulos/autenticacion/paginas/login_pagina.dart';

void main() {
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
      home: const SplashWrapper(), // 👈 envolvemos splash + redirección
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
    Timer(const Duration(seconds: 15), () {
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
