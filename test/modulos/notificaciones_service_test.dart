import 'package:flutter_test/flutter_test.dart';
import 'package:sututeh_app/modulos/notificaciones/servicios/notificaciones_service.dart';

void main() {
  group('🔔 NotificacionesService - Pruebas unitarias', () {
    final service = NotificacionesService();

    test('Debe devolver lista (vacía o con elementos)', () async {
      final result = await service.obtenerNotificaciones();
      expect(result, isA<List<Map<String, dynamic>>>());
    });

    test('Debe devolver contador como número entero', () async {
      final total = await service.obtenerContador();
      expect(total, isA<int>());
    });

    test('Debe devolver mapa o null para próxima reunión', () async {
      final data = await service.obtenerProximaReunion();
      expect(data, anyOf(isNull, isA<Map<String, dynamic>>()));
    });

    test('Debe manejar correctamente resumen semanal', () async {
      final resumen = await service.obtenerResumenSemanal();
      expect(resumen, isA<Map<String, dynamic>>());
      expect(resumen.containsKey('total_reuniones'), true);
    });
  });
}
