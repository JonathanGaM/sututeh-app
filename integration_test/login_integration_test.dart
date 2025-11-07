import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sututeh_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('🔐 Login real y navegación a InicioPagina', (tester) async {
    // 🚀 Inicia la app completa
    app.main();
    await tester.pumpAndSettle();

    // ⏳ Espera hasta que la pantalla de login esté visible
    Finder emailField = find.widgetWithText(
      TextFormField,
      'Correo Electrónico',
    );
    Finder passField = find.widgetWithText(TextFormField, 'Contraseña');
    Finder ingresarButton = find.widgetWithText(ElevatedButton, 'Ingresar');

    // 🔁 Esperar hasta 10 intentos que aparezcan los campos
    bool camposCargados = false;
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(seconds: 2));
      if (emailField.evaluate().isNotEmpty && passField.evaluate().isNotEmpty) {
        camposCargados = true;
        break;
      }
    }

    expect(
      camposCargados,
      true,
      reason: '❌ No se encontraron los campos de login.',
    );

    // 📩 Credenciales
    const String email = String.fromEnvironment(
      'TEST_EMAIL',
      defaultValue: 'jonagama6@gmail.com',
    );
    const String password = String.fromEnvironment(
      'TEST_PASS',
      defaultValue: 'jgmDoki23!',
    );

    // ✏️ Escribir datos en los campos
    await tester.enterText(emailField, email);
    await tester.enterText(passField, password);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // ▶️ Pulsar el botón "Ingresar"
    await tester.tap(ingresarButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // 🔎 Buscar texto que confirme la navegación a InicioPagina
    final inicioText = find.textContaining(
      RegExp(r'SUTUTEH', caseSensitive: false),
    );

    // Esperar un poco más por animaciones/red
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // ✅ Verificar navegación correcta
    expect(
      inicioText,
      findsWidgets,
      reason: '❌ No se mostró la pantalla de inicio después del login.',
    );

    print('✅ Login exitoso y navegación a InicioPagina confirmada.');
  });
}
