import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sututeh_app/modulos/inicio/paginas/inicio_pagina.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    try {
      await Firebase.initializeApp();
    } catch (_) {}
  });

  testWidgets('🏠 InicioPagina se muestra correctamente', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: InicioPagina()));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verificar que el Scaffold principal exista
    expect(
      find.byType(Scaffold),
      findsOneWidget,
      reason: 'No se encontró el Scaffold principal.',
    );

    // Buscar texto genérico o un elemento clave del inicio
    expect(
      find.textContaining(
        RegExp(r'Inicio|Bienvenido|Dashboard', caseSensitive: false),
      ),
      findsOneWidget,
      reason: 'No se encontró texto principal de la pantalla de inicio.',
    );
  });
}
