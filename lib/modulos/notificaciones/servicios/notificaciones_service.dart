import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificacionesService {
  // ⚙️ Cambia esta URL si usas otro servidor o IP
  static const String baseUrl = 'http://192.168.100.9:3001';

  // ==============================================
  // 📩 GET /api/notificaciones - Todas las notificaciones
  // ==============================================
  Future<List<Map<String, dynamic>>> obtenerNotificaciones() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/notificaciones'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> data = body['notificaciones'] ?? [];
        return data.cast<Map<String, dynamic>>();
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }

  // ==============================================
  // 🔢 GET /api/notificaciones/contador - Contador
  // ==============================================
  Future<int> obtenerContador() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/notificaciones/contador'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['total_no_leidas'] ?? 0;
      } else {
        return 0;
      }
    } catch (_) {
      return 0;
    }
  }

  // ==============================================
  // 📅 GET /api/notificaciones/proxima-reunion
  // ==============================================
  Future<Map<String, dynamic>?> obtenerProximaReunion() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/notificaciones/proxima-reunion'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['proxima_reunion'];
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  // ==============================================
  // 📊 GET /api/notificaciones/resumen-semanal
  // ==============================================
  Future<Map<String, dynamic>> obtenerResumenSemanal() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/notificaciones/resumen-semanal'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'total_reuniones': 0, 'reuniones': []};
      }
    } catch (_) {
      return {'total_reuniones': 0, 'reuniones': []};
    }
  }
}
