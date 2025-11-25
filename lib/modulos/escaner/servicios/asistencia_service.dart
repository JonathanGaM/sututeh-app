import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sututeh_app/modulos/autenticacion/servicios/auth_service.dart';

class AsistenciaService {
  static const String baseUrl = 'http://192.168.100.9:3001/api';

  // Registrar asistencia
  static Future<Map<String, dynamic>> registrarAsistencia({
    required int reunionId,
  }) async {
    try {
      final token = await AuthService().getToken();
      if (token == null) {
        return {'error': 'No tienes sesión activa'};
      }

      final url = Uri.parse('$baseUrl/mobile/asistencia/$reunionId');

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // ⚠️ NECESARIO
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data; // { estado: "...", puntaje: 10 }
      } else {
        return {'error': data['error'] ?? 'Error desconocido'};
      }
    } catch (e) {
      return {'error': 'No se pudo conectar con el servidor'};
    }
  }
}
