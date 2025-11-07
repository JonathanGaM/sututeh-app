import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sututeh_app/main.dart' as app;
import 'package:firebase_core/firebase_core.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    try {
      await Firebase.initializeApp();
    } catch (_) {}
  });

  testWidgets('🌀 Pantalla de carga se muestra correctamente', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Esperar unos segundos para que cargue correctamente
    await tester.pump(const Duration(seconds: 2));

    // Verificar que muestra el logo o un widget principal
    expect(
      find.byType(Image),
      findsOneWidget,
      reason: 'No se encontró el logo de la pantalla de carga.',
    );
  });
}
