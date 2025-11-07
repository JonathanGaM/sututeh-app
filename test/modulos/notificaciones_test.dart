import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sututeh_app/modulos/notificaciones/paginas/notificaciones_pagina.dart';

void main() {
  testWidgets('🧪 NotificacionesPagina se construye correctamente', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: NotificacionesPagina()));

    // 🔹 1. Verifica que haya un Scaffold
    expect(find.byType(Scaffold), findsOneWidget);

    // 🔹 2. Estado inicial: muestra un loader
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 🔹 3. Simula el fin de la carga asincrónica
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 🔹 4. Ahora debe seguir existiendo el Scaffold (aunque esté vacío o con texto)
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
