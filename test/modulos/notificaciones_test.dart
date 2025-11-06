import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sututeh_app/modulos/notificaciones/paginas/notificaciones_pagina.dart';

void main() {
  testWidgets('NotificacionesPagina muestra un widget principal', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: NotificacionesPagina()));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}
