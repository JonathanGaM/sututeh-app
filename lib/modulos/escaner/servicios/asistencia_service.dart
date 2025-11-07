import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sututeh_app/modulos/autenticacion/servicios/auth_service.dart';

class AsistenciaService {
  static const String baseUrl = 'http://192.168.100.9:3001/api';

  // 🔹 Registrar asistencia
  static Future<Map<String, dynamic>> registrarAsistencia({
    required int reunionId,
  }) async {
    try {
      final token = await AuthService().getToken(); // Token JWT guardado
      if (token == null) {
        return {'error': 'Usuario no autenticado'};
      }

      final response = await http.post(
        Uri.parse('$baseUrl/reuniones/$reunionId/asistencia'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // 🔑 Importante
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'error': jsonDecode(response.body)['error'] ?? 'Error desconocido',
        };
      }
    } catch (e) {
      return {'error': 'Error de conexión: $e'};
    }
  }
}
