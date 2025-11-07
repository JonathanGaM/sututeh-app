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
    } catch (_) {
      // Ignora si Firebase ya está inicializado
    }
  });

  testWidgets('🔐 Login se muestra después del Splash', (tester) async {
    // 🚀 Iniciar la app completa
    app.main();
    await tester.pumpAndSettle();

    // ⏳ Esperar la pantalla de carga (5s del Timer + 2s extra por render)
    await tester.pump(const Duration(seconds: 7));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 🔎 Buscar el texto del botón principal ("Ingresar")
    expect(
      find.textContaining(RegExp(r'Ingresar', caseSensitive: false)),
      findsOneWidget,
      reason: 'No se encontró el botón principal "Ingresar" en el login.',
    );

    // 🔎 Verificar que haya los 2 campos de texto (correo y contraseña)
    expect(
      find.byType(TextFormField),
      findsNWidgets(2),
      reason: 'No se encontraron los campos de email y contraseña.',
    );

    // 💡 Verificar también el botón de Google opcionalmente
    expect(
      find.textContaining('Google'),
      findsOneWidget,
      reason: 'No se encontró el botón "Continuar con Google".',
    );
  });
}
