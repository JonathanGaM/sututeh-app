import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sututeh_app/modulos/escaner/servicios/asistencia_service.dart';

class EscanerPagina extends StatefulWidget {
  const EscanerPagina({super.key});

  @override
  State<EscanerPagina> createState() => _EscanerPaginaState();
}

class _EscanerPaginaState extends State<EscanerPagina> {
  bool _codigoDetectado = false;
  String? _ultimoCodigo;
  final MobileScannerController _controller = MobileScannerController();

  // 🔹 Función para registrar asistencia
  Future<void> _registrarAsistencia(String code) async {
    try {
      final id = int.tryParse(code);
      if (id == null) {
        _mostrarSnack('Código QR inválido', Colors.red);
        return;
      }

      final respuesta = await AsistenciaService.registrarAsistencia(
        reunionId: id,
      );

      if (respuesta.containsKey('error')) {
        _mostrarSnack('❌ ${respuesta['error']}', Colors.red);
      } else {
        _mostrarSnack(
          '✅ ${respuesta['estado']} (+${respuesta['puntaje']} pts)',
          Colors.green,
        );
      }
    } catch (e) {
      _mostrarSnack('Error: $e', Colors.red);
    }
  }

  void _mostrarSnack(String mensaje, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final code = barcodes.first.rawValue ?? '';
                if (!_codigoDetectado || code != _ultimoCodigo) {
                  setState(() {
                    _codigoDetectado = true;
                    _ultimoCodigo = code;
                  });

                  _registrarAsistencia(code);

                  Future.delayed(const Duration(seconds: 3), () {
                    setState(() => _codigoDetectado = false);
                  });
                }
              }
            },
          ),
          // Marco verde
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // Linterna
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.flash_on, color: Colors.white),
              onPressed: () => _controller.toggleTorch(),
            ),
          ),
          // Texto
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: const Text(
              'Apunta la cámara hacia el código QR',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
