import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../notificaciones/servicios/notificaciones_service.dart';

class NotificacionesPagina extends StatefulWidget {
  const NotificacionesPagina({super.key});

  @override
  State<NotificacionesPagina> createState() => _NotificacionesPaginaState();
}

class _NotificacionesPaginaState extends State<NotificacionesPagina> {
  final NotificacionesService _service = NotificacionesService();
  List<Map<String, dynamic>> _notificaciones = [];
  bool _isLoading = true;
  int _totalNoLeidas = 0;

  @override
  void initState() {
    super.initState();
    _cargarNotificaciones();
  }

  Future<void> _cargarNotificaciones() async {
    setState(() => _isLoading = true);

    try {
      final notificaciones = await _service.obtenerNotificaciones();
      final contador = await _service.obtenerContador();

      setState(() {
        _notificaciones = notificaciones;
        _totalNoLeidas = contador;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar notificaciones: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  String _formatearFecha(String? fecha) {
    if (fecha == null) return 'Fecha desconocida';

    try {
      final date = DateTime.parse(fecha);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          if (difference.inMinutes <= 0) return 'Ahora';
          return '${difference.inMinutes} min';
        }
        return '${difference.inHours}h';
      } else if (difference.inDays == 1) {
        return 'Ayer';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} días';
      } else {
        return DateFormat('dd MMM yyyy', 'es').format(date);
      }
    } catch (e) {
      return 'Fecha inválida';
    }
  }

  IconData _obtenerIcono(String? tipo) {
    switch (tipo) {
      case 'nueva_reunion':
        return Icons.event_available_rounded;
      case 'recordatorio_24h':
        return Icons.notifications_active_rounded;
      case 'recordatorio_4h':
        return Icons.alarm_rounded;
      default:
        return Icons.notifications;
    }
  }

  Color _obtenerColor(String? tipo) {
    switch (tipo) {
      case 'nueva_reunion':
        return Colors.greenAccent;
      case 'recordatorio_24h':
        return Colors.orangeAccent;
      case 'recordatorio_4h':
        return Colors.redAccent;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2939),
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'Notificaciones',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_totalNoLeidas > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_totalNoLeidas',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _cargarNotificaciones,
            tooltip: 'Actualizar',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            )
          : _notificaciones.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_rounded,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay notificaciones',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Las notificaciones de reuniones\naparecerán aquí',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _cargarNotificaciones,
              color: Colors.blueAccent,
              backgroundColor: const Color(0xFF1E2939),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                itemCount: _notificaciones.length,
                itemBuilder: (context, i) {
                  final notif = _notificaciones[i];
                  final esNueva = notif['es_nueva'] == true;
                  final fechaEnvio = notif['fecha_envio'];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2939),
                      borderRadius: BorderRadius.circular(16),
                      border: esNueva
                          ? Border.all(
                              color: _obtenerColor(notif['tipo_notificacion']),
                              width: 1.5,
                            )
                          : null,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Encabezado
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _obtenerIcono(notif['tipo_notificacion']),
                                  color: _obtenerColor(
                                    notif['tipo_notificacion'],
                                  ),
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  notif['titulo'] ?? 'Notificación',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: esNueva
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _formatearFecha(fechaEnvio),
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
                          notif['mensaje'] ?? '',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // 🔹 Detalles de reunión
                        if (notif['reunion_titulo'] != null)
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F0F0F),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.event,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      notif['reunion_titulo'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${notif['reunion_fecha']} • ${notif['reunion_hora']}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                if (notif['reunion_ubicacion'] != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.place,
                                          color: Colors.white70,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            notif['reunion_ubicacion'],
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
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
