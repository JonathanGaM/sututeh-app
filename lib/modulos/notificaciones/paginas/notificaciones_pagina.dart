import 'package:flutter/material.dart';

class NotificacionesPagina extends StatelessWidget {
  const NotificacionesPagina({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notificaciones = [
      {
        'titulo': 'Recordatorio',
        'mensaje': 'Prepárate: la reunión sindical será la próxima semana.',
        'fecha': '17 Sept 2025',
        'tipo': 'recordatorio',
        'nuevo': false,
      },
      {
        'titulo': 'Recordatorio',
        'mensaje': '¡Atención! Mañana se llevará a cabo la reunión, no faltes.',
        'fecha': '22 Sept 2025',
        'tipo': 'recordatorio',
        'nuevo': false,
      },
      {
        'titulo': 'Recordatorio',
        'mensaje': 'Recuerda que la reunión es hoy, ¡no faltes!',
        'fecha': '23 Sept 2025',
        'tipo': 'hoy',
        'nuevo': true,
      },
      {
        'titulo': 'Nueva reunión',
        'mensaje':
            '¡Atención! Nueva reunión registrada, mantente informado en tu agenda.',
        'fecha': '1 Sept 2025',
        'tipo': 'nueva',
        'nuevo': false,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: ListView.builder(
          itemCount: notificaciones.length,
          itemBuilder: (context, i) {
            final Map<String, dynamic> item = notificaciones[i];

            // Definir ícono y color por tipo
            IconData icono;
            Color colorIcono;

            switch (item['tipo']) {
              case 'recordatorio':
                icono = Icons.calendar_today_rounded;
                colorIcono = Colors.blueAccent;
                break;
              case 'hoy':
                icono = Icons.notifications_active_rounded;
                colorIcono = Colors.orangeAccent;
                break;
              case 'nueva':
                icono = Icons.event_available_rounded;
                colorIcono = Colors.greenAccent;
                break;
              default:
                icono = Icons.notifications;
                colorIcono = Colors.white;
            }

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2939),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Fila superior (título, etiqueta y fecha)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(icono, color: colorIcono, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            item['titulo'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          if (item['nuevo'] == true)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Nuevo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        item['fecha'] ?? '',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // 🔹 Mensaje
                  Text(
                    item['mensaje'] ?? '',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
