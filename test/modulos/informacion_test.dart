import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sututeh_app/modulos/informacion/paginas/acerca_de_pagina.dart';

void main() {
  testWidgets('AcercaDePagina muestra un Scaffold', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AcercaDePagina()));
    expect(find.byType(Scaffold), findsOneWidget); // ✅ Scaffold
  });
}
