import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sututeh_app/modulos/notificaciones/paginas/notificaciones_pagina.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    try {
      await Firebase.initializeApp();
    } catch (_) {}
  });

  testWidgets('🔔 NotificacionesPagina se muestra correctamente', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: NotificacionesPagina()));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verificar estructura base
    expect(
      find.byType(Scaffold),
      findsOneWidget,
      reason: 'No se encontró el Scaffold en NotificacionesPagina.',
    );

    // Verificar que haya un AppBar con el título
    expect(
      find.textContaining('Notificaciones'),
      findsOneWidget,
      reason: 'No se encontró el título "Notificaciones".',
    );

    // Verificar que haya lista (aunque esté vacía)
    expect(
      find.byType(ListView),
      findsOneWidget,
      reason: 'No se encontró la lista principal de notificaciones.',
    );
  });
}
