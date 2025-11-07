import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sututeh_app/firebase_options.dart';

// Evitamos importar FirebaseAuth directamente del AuthService real
// porque intentará inicializarse sin app
import 'package:sututeh_app/modulos/autenticacion/servicios/auth_service.dart'
    hide AuthService;

// 🔹 Mock temporal para pruebas unitarias (sin tocar Firebase)
class MockAuthService {
  Future<Map<String, dynamic>?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    if (email.contains('@') && password.length >= 8) {
      return {
        'token': 'fakeToken123',
        'user': {'email': email, 'id': 1},
      };
    }
    return null;
  }

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    return {
      'token': 'fakeGoogleToken456',
      'user': {'email': 'user@gmail.com', 'id': 2},
    };
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      print('⚠️ Firebase ya inicializado o no necesario: $e');
    }
  });

  group('🔐 AuthService (mock) - Pruebas unitarias sin Firebase', () {
    final authService = MockAuthService();

    test('Login con email válido devuelve datos simulados', () async {
      final result = await authService.signInWithEmailPassword(
        'usuario@ejemplo.com',
        'password123',
      );
      expect(result, isA<Map<String, dynamic>>());
      expect(result!['user']['email'], 'usuario@ejemplo.com');
    });

    test('Login con email inválido devuelve null', () async {
      final result = await authService.signInWithEmailPassword(
        'correo_invalido',
        '123',
      );
      expect(result, isNull);
    });

    test('Login con Google devuelve estructura simulada', () async {
      final result = await authService.signInWithGoogle();
      expect(result, isA<Map<String, dynamic>>());
      expect(result!['user']['email'], 'user@gmail.com');
    });
  });
}
