import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

/// Servicio ligero usado solo para las pruebas unitarias.
/// Los tokens se generan de forma ofuscada (base64) para no mostrar valores reales.
class MockAuthService {
  Future<Map<String, dynamic>?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final emailValido = emailRegex.hasMatch(email);
    final passValido = password.length >= 8;

    if (emailValido && passValido) {
      final rawToken = '$email:${DateTime.now().millisecondsSinceEpoch}';
      final encodedToken = base64Encode(utf8.encode(rawToken));

      return {
        'token': encodedToken,
        'user': {'email': email, 'id': 1},
      };
    }
    return null;
  }

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    final encodedToken = base64Encode(
      utf8.encode('google_login_${DateTime.now().millisecondsSinceEpoch}'),
    );

    return {
      'token': encodedToken,
      'user': {'email': 'jonagama6@gmail.com', 'id': 2},
    };
  }
}

void main() {
  final authService = MockAuthService();

  group('🔐 AuthService - Validación de formatos y comportamiento', () {
    test('Emails válidos y contraseñas válidas deben autenticar', () async {
      final casosValidos = [
        {'email': 'jonagam6@gmail.com', 'pass': 'jgmDoki23!'},
        {'email': '20221074@uthh.edu.mx', 'pass': 'jgmDoki23'},
        {'email': 'mifavoritoanime@gmail.com', 'pass': 'zxcv123w'},
      ];

      for (final caso in casosValidos) {
        final result = await authService.signInWithEmailPassword(
          caso['email']!,
          caso['pass']!,
        );

        expect(
          result,
          isA<Map<String, dynamic>>(),
          reason: 'Debe autenticarse: ${caso['email']} / ${caso['pass']}',
        );
        expect(
          result!['user']['email'],
          equals(caso['email']),
          reason: 'El email devuelto debe coincidir',
        );
        expect(
          result['token'],
          isNotEmpty,
          reason: 'El token debe generarse y no estar vacío',
        );
      }
    });

    test(
      'Emails inválidos deben fallar (sin @ o formato incorrecto)',
      () async {
        final casosInvalidosEmail = [
          {'email': 'usuarioejemplo.com', 'pass': 'password123'},
          {'email': 'usuario@', 'pass': 'password123'},
          {'email': '', 'pass': 'password123'},
        ];

        for (final caso in casosInvalidosEmail) {
          final result = await authService.signInWithEmailPassword(
            caso['email']!,
            caso['pass']!,
          );
          expect(
            result,
            isNull,
            reason: 'No debe autenticarse con email inválido: ${caso['email']}',
          );
        }
      },
    );

    test('Contraseñas cortas deben fallar (menos de 8 caracteres)', () async {
      final casosPassCortas = [
        {'email': 'usuario@ejemplo.com', 'pass': '123'},
        {'email': 'usuario@ejemplo.com', 'pass': 'abcd'},
        {'email': 'usuario@ejemplo.com', 'pass': ''},
      ];

      for (final caso in casosPassCortas) {
        final result = await authService.signInWithEmailPassword(
          caso['email']!,
          caso['pass']!,
        );
        expect(
          result,
          isNull,
          reason:
              'No debe autenticarse con contraseña corta: "${caso['pass']}"',
        );
      }
    });

    test(
      'Combinaciones inválidas (email y/o password) fallan correctamente',
      () async {
        final combos = [
          {'email': 'sinarroba', 'pass': '123'},
          {'email': '', 'pass': ''},
          {'email': 'ok@mail.com', 'pass': 'short'},
          {'email': 'notvalid', 'pass': 'validpass123'},
        ];

        for (final c in combos) {
          final result = await authService.signInWithEmailPassword(
            c['email']!,
            c['pass']!,
          );
          expect(
            result,
            isNull,
            reason:
                'Combinación inválida debe fallar: ${c['email']} / ${c['pass']}',
          );
        }
      },
    );

    test('Login con Google devuelve estructura esperada', () async {
      final result = await authService.signInWithGoogle();
      expect(result, isA<Map<String, dynamic>>());
      expect(result!['token'], isA<String>());
      expect(
        result['token'].length,
        greaterThan(20),
        reason: 'El token debe estar ofuscado (Base64 largo)',
      );
      expect(result['user'], isA<Map<String, dynamic>>());
      expect(result['user']['email'], contains('@'));
    });
  });
}
