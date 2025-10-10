import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class EscanerPagina extends StatefulWidget {
  const EscanerPagina({super.key});

  @override
  State<EscanerPagina> createState() => _EscanerPaginaState();
}

class _EscanerPaginaState extends State<EscanerPagina> {
  bool _codigoDetectado = false;
  String? _ultimoCodigo;
  final MobileScannerController _controller = MobileScannerController(
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔹 Cámara activa para escanear
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final code = barcodes.first.rawValue ?? "";
                if (!_codigoDetectado || code != _ultimoCodigo) {
                  setState(() {
                    _codigoDetectado = true;
                    _ultimoCodigo = code;
                  });

                  // Aquí podrías enviar el código a tu API
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Código detectado: $code'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                    ),
                  );

                  // Evita lecturas continuas
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() => _codigoDetectado = false);
                  });
                }
              }
            },
          ),

          // 🔹 Marco guía verde
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

          // 🔹 Solo el botón de linterna (se quitó el de salir)
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.flash_on, color: Colors.white),
              onPressed: () {
                _controller.toggleTorch();
              },
            ),
          ),

          // 🔹 Texto informativo
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
