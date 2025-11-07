import 'dart:convert';
import 'package:http/http.dart' as http;

class InicioService {
  static const String baseUrl = 'http://192.168.100.9:3001';

  String _normalizar(String texto) {
    final mapa = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
      'Á': 'A',
      'É': 'E',
      'Í': 'I',
      'Ó': 'O',
      'Ú': 'U',
    };
    return texto.split('').map((c) => mapa[c] ?? c).join().toLowerCase();
  }

  /// 🔹 Obtiene misión, visión e imagen del cover de empresa
  Future<Map<String, dynamic>> obtenerDatosInicio() async {
    try {
      // --- 1. Obtener Misión y Visión ---
      final responseNosotros = await http.get(
        Uri.parse('$baseUrl/api/nosotros/vigentes'),
        headers: {'Content-Type': 'application/json'},
      );

      String mision = 'Sin misión registrada';
      String vision = 'Sin visión registrada';

      if (responseNosotros.statusCode == 200) {
        final List<dynamic> data = json.decode(responseNosotros.body);

        for (var e in data) {
          final nombre = _normalizar(e['seccion'].toString());
          if (nombre.contains('mision')) mision = e['contenido'];
          if (nombre.contains('vision')) vision = e['contenido'];
        }
      }

      // --- 2. Obtener Cover de datos_empresa ---
      final responseEmpresa = await http.get(
        Uri.parse('$baseUrl/api/datos-empresa'),
        headers: {'Content-Type': 'application/json'},
      );

      String? cover;
      if (responseEmpresa.statusCode == 200) {
        final List<dynamic> empresas = json.decode(responseEmpresa.body);
        if (empresas.isNotEmpty) {
          cover = empresas.first['cover_url'];
        }
      }

      // --- 3. Retornar los datos combinados ---
      return {'mision': mision, 'vision': vision, 'cover': cover};
    } catch (e) {
      print('❌ Error en obtenerDatosInicio: $e');
      return {
        'mision': 'Error de conexión',
        'vision': 'Error de conexión',
        'cover': null,
      };
    }
  }
}
