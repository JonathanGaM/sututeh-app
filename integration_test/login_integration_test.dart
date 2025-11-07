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

    // ⏳ Espera la pantalla de carga (Splash)
    await tester.pump(const Duration(seconds: 7));
    await tester.pumpAndSettle();

    // 📩 Credenciales (puedes pasarlas por --dart-define o dejar temporales)
    const String email = String.fromEnvironment(
      'TEST_EMAIL',
      defaultValue: 'jonagama6@gmail.com',
    );
    const String password = String.fromEnvironment(
      'TEST_PASS',
      defaultValue: 'jgmDoki23!',
    );

    // ✏️ Rellenar campos de login
    await tester.enterText(find.byType(TextFormField).at(0), email);
    await tester.enterText(find.byType(TextFormField).at(1), password);

    // ▶️ Presionar botón Ingresar
    await tester.tap(find.textContaining('Ingresar'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // 🔎 Esperar que aparezca el texto del AppBar en InicioPagina
    final inicioText = find.textContaining(
      RegExp(r'SUTUTEH', caseSensitive: false),
    );

    // Esperar un poco más para animaciones de carga o red
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // ✅ Verificar que estamos en la pantalla de inicio
    expect(
      inicioText,
      findsWidgets,
      reason: 'No se mostró la pantalla de inicio después del login.',
    );

    print('✅ Login exitoso y navegación a InicioPagina confirmada.');
  });
}
