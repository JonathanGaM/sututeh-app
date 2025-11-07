import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('🧪 Pruebas Login Email/Password', () {
    testWidgets('✅ POSITIVO: Login acepta email y contraseña válidos', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      bool loginSuccess = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('email'),
                    validator: (v) =>
                        v?.contains('@') == true ? null : 'Email inválido',
                  ),
                  TextFormField(
                    key: const Key('password'),
                    obscureText: true,
                    validator: (v) => v != null && v.length >= 8
                        ? null
                        : 'Mínimo 8 caracteres',
                  ),
                  ElevatedButton(
                    key: const Key('login'),
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        loginSuccess = true;
                      }
                    },
                    child: const Text('Ingresar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Ingresar datos válidos
      await tester.enterText(
        find.byKey(const Key('email')),
        'test@sututeh.edu.mx',
      );
      await tester.enterText(find.byKey(const Key('password')), 'Password123!');

      // Presionar botón
      await tester.tap(find.byKey(const Key('login')));
      await tester.pump();

      // Verificar que no hay errores
      expect(find.text('Email inválido'), findsNothing);
      expect(find.text('Mínimo 8 caracteres'), findsNothing);
      expect(loginSuccess, true);
    });

    testWidgets('❌ NEGATIVO: Login rechaza credenciales inválidas', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('email'),
                    validator: (v) =>
                        v?.contains('@') == true ? null : 'Email inválido',
                  ),
                  TextFormField(
                    key: const Key('password'),
                    obscureText: true,
                    validator: (v) => v != null && v.length >= 8
                        ? null
                        : 'Mínimo 8 caracteres',
                  ),
                  ElevatedButton(
                    onPressed: () => formKey.currentState?.validate(),
                    child: const Text('Ingresar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Ingresar datos inválidos
      await tester.enterText(find.byKey(const Key('email')), 'emailinvalido');
      await tester.enterText(find.byKey(const Key('password')), '123');

      // Presionar botón
      await tester.tap(find.text('Ingresar'));
      await tester.pump();

      // Verificar errores
      expect(find.text('Email inválido'), findsOneWidget);
      expect(find.text('Mínimo 8 caracteres'), findsOneWidget);
    });
  });
}
