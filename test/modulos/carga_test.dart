import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sututeh_app/modulos/carga/paginas/carga_pagina.dart';

void main() {
  testWidgets('CargaPagina muestra un Scaffold', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CargaPagina()));
    expect(find.byType(Scaffold), findsOneWidget); // ✅ solo Scaffold
  });
}
