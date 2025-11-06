import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sututeh_app/modulos/inicio/paginas/inicio_pagina.dart';

void main() {
  testWidgets('InicioPage muestra un widget principal', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: InicioPagina()));

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
