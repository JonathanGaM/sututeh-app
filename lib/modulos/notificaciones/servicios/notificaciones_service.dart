import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../config/api_config.dart';

class NotificacionesService {
  String get baseUrl => ApiConfig.baseUrl;

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

  Future<int> obtenerContador() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/notificaciones/contador'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['total_leidas'] ?? 0;
      } else {
        return 0;
      }
    } catch (_) {
      return 0;
    }
  }

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
