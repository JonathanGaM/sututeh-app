import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sututeh_app/modulos/perfil/paginas/perfil_pagina.dart';

void main() {
  testWidgets('PerfilPagina muestra un widget principal', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: PerfilPagina()));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(CircleAvatar), findsWidgets); // verifica foto de perfil
  });
}
