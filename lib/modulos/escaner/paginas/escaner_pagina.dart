import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sututeh_app/modulos/escaner/servicios/asistencia_service.dart';

class EscanerPagina extends StatefulWidget {
  const EscanerPagina({super.key});

  @override
  State<EscanerPagina> createState() => _EscanerPaginaState();
}

class _EscanerPaginaState extends State<EscanerPagina> {
  bool _procesando = false;
  final MobileScannerController _controller = MobileScannerController();

  Future<void> _registrarAsistencia(String code) async {
    if (_procesando) return;

    setState(() => _procesando = true);

    final id = int.tryParse(code);
    if (id == null) {
      _mostrarSnack("Código QR inválido", Colors.red);
      _reset();
      return;
    }

    final resp = await AsistenciaService.registrarAsistencia(reunionId: id);

    if (resp.containsKey('error')) {
      _mostrarSnack("❌ ${resp['error']}", Colors.red);
    } else {
      _mostrarSnack(
        "✅ ${resp['estado']} (+${resp['puntaje']} pts)",
        Colors.green,
      );
    }

    _reset();
  }

  void _reset() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _procesando = false);
      _controller.start(); // volver a escanear
    });
  }

  void _mostrarSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              final barcode = capture.barcodes.first;
              final code = barcode.rawValue;

              if (code != null && !_procesando) {
                _controller.stop(); // pausa escaneo
                _registrarAsistencia(code);
              }
            },
          ),

          // Marco verde
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 3),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          // Botón linterna
          Positioned(
            top: 40,
            right: 15,
            child: IconButton(
              icon: const Icon(Icons.flash_on, color: Colors.white),
              onPressed: () => _controller.toggleTorch(),
            ),
          ),

          // Texto
          const Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Text(
              "Apunta la cámara hacia el QR",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
