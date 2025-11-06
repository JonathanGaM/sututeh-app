import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sututeh_app/modulos/escaner/paginas/escaner_pagina.dart';

void main() {
  testWidgets('EscanerPagina muestra un Scaffold', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: EscanerPagina()));
    expect(find.byType(Scaffold), findsOneWidget); // ✅ Scaffold
  });
}
