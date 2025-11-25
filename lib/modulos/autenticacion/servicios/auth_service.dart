import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/api_config.dart';

class AuthService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  GoogleSignIn get _googleSignIn => GoogleSignIn(scopes: ['email']);

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  // ============================================================
  // 🔐 LOGIN EMAIL + PASSWORD (API MOVIL)
  // ============================================================
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

      final data = jsonDecode(response.body);

      // ❌ Si falla el login
      if (response.statusCode != 200 || data['token'] == null) {
        print("Login fallido :: ${response.body}");
        return null;
      }

      // Guardar token y datos del usuario
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', data['token']);
      await prefs.setString('userEmail', data['user']['email']);
      await prefs.setInt('userId', data['user']['id']);
      await prefs.setInt('roleId', data['user']['roleId']);
      await prefs.setString('roleName', data['user']['roleName']);

      print("TOKEN GUARDADO: ${data['token']}");

      return data;
    } catch (e) {
      print("Error en login email: $e");
      return null;
    }
  }

  // ============================================================
  // 🔥 LOGIN CON GOOGLE (FIREBASE)
  // ============================================================
  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      UserCredential? credential;

      if (kIsWeb) {
        credential = await _auth.signInWithPopup(GoogleAuthProvider());
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return null;

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        credential = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ),
        );
      }

      final email = credential.user?.email;
      if (email == null) {
        print("No se pudo obtener email de Google");
        await signOut();
        return null;
      }

      // Enviar a tu backend
      final response = await http.post(
        Uri.parse(ApiConfig.verifyGoogleEmail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final data = jsonDecode(response.body);

      // ❌ Correo NO registrado en BD
      if (response.statusCode != 200 || data['token'] == null) {
        await signOut();
        return {'exists': false, 'error': data['error']};
      }

      // Guardar token y datos
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', data['token']);
      await prefs.setString('userEmail', data['user']['email']);
      await prefs.setInt('userId', data['user']['id']);
      await prefs.setInt('roleId', data['user']['roleId']);
      await prefs.setString('roleName', data['user']['roleName']);
      await prefs.setString('loginMethod', 'google');

      return data;
    } catch (e) {
      print("Error Google login: $e");
      await signOut();
      return null;
    }
  }

  // ============================================================
  // 🚪 LOGOUT
  // ============================================================
  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (!kIsWeb) await _googleSignIn.signOut();
      await _auth.signOut();

      await http.post(Uri.parse(ApiConfig.logoutMobile));
    } catch (e) {
      print("Error logout: $e");
    }
  }

  // ============================================================
  // 🔍 SESIÓN ACTIVA
  // ============================================================
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken') != null;
  }

  // ============================================================
  // 📋 OBTENER DATOS DEL USUARIO
  // ============================================================
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('authToken') == null) return null;

    return {
      'email': prefs.getString('userEmail'),
      'userId': prefs.getInt('userId'),
      'roleId': prefs.getInt('roleId'),
      'roleName': prefs.getString('roleName'),
    };
  }

  // ============================================================
  // 🔑 OBTENER TOKEN JWT
  // ============================================================
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
