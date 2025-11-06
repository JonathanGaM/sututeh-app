import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/api_config.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // Stream para escuchar cambios de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Usuario actual
  User? get currentUser => _auth.currentUser;

  // 🔐 Login con Email y Contraseña (usando tu backend)
  Future<Map<String, dynamic>?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.loginMobile),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Guardar token localmente
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', data['token']);
        await prefs.setString('userEmail', data['user']['email']);
        await prefs.setInt('userId', data['user']['id']);
        await prefs.setInt('roleId', data['user']['roleId']);
        await prefs.setString('roleName', data['user']['roleName']);

        return data;
      } else {
        print('Error del servidor: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error en login con email: $e');
      return null;
    }
  }

  // 🔥 Login con Google (usando Firebase)
  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      UserCredential? credential;

      if (kIsWeb) {
        // Para Web
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        credential = await _auth.signInWithPopup(googleProvider);
      } else {
        // Para Android/iOS
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          print('Usuario canceló el login de Google');
          return null;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        credential = await _auth.signInWithCredential(authCredential);
      }

      // Obtener el email del usuario de Google
      final email = credential.user?.email;
      if (email == null) {
        print('No se pudo obtener el email de Google');
        await _auth.signOut();
        if (!kIsWeb) await _googleSignIn.signOut();
        return null;
      }

      // 🔍 Verificar si el correo existe en la BD
      final response = await http.post(
        Uri.parse(ApiConfig.verifyGoogleEmail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Guardar token y datos localmente
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', data['token']);
        await prefs.setString('userEmail', data['user']['email']);
        await prefs.setInt('userId', data['user']['id']);
        await prefs.setInt('roleId', data['user']['roleId']);
        await prefs.setString('roleName', data['user']['roleName']);
        await prefs.setString('loginMethod', 'google');

        return data;
      } else {
        // El correo no existe en la BD - cerrar sesión de Firebase
        print('Correo no registrado en BD: ${response.body}');
        await _auth.signOut();
        if (!kIsWeb) await _googleSignIn.signOut();

        return {
          'error': 'Este correo no está registrado como agremiado',
          'exists': false,
        };
      }
    } catch (e) {
      print('Error detallado en Google Sign-In: $e');
      // Cerrar sesión en caso de error
      try {
        await _auth.signOut();
        if (!kIsWeb) await _googleSignIn.signOut();
      } catch (_) {}
      return null;
    }
  }

  // 🚪 Cerrar sesión
  Future<void> signOut() async {
    try {
      // Limpiar token local
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Cerrar sesión de Google si está activo
      if (!kIsWeb) {
        await _googleSignIn.signOut();
      }
      await _auth.signOut();

      // Notificar al servidor (opcional)
      try {
        await http.post(Uri.parse(ApiConfig.logoutMobile));
      } catch (e) {
        print('Error notificando logout al servidor: $e');
      }
    } catch (e) {
      print('Error en signOut: $e');
    }
  }

  // 🔍 Verificar si hay sesión activa
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return token != null;
  }

  // 📋 Obtener datos del usuario guardados
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) return null;

    return {
      'email': prefs.getString('userEmail'),
      'userId': prefs.getInt('userId'),
      'roleId': prefs.getInt('roleId'),
      'roleName': prefs.getString('roleName'),
    };
  }
}
