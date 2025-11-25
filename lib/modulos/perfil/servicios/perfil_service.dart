import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/api_config.dart';

class PerfilService {
  Future<Map<String, dynamic>?> obtenerPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) return null;

    final response = await http.get(
      Uri.parse(ApiConfig.userInfoMobile),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["user"];
    } else {
      print("❌ Error al obtener perfil: ${response.body}");
      return null;
    }
  }
}
