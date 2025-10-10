import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AcercaDePagina extends StatelessWidget {
  const AcercaDePagina({super.key});

 Future<void> _abrirSitioWeb() async {
  final Uri url = Uri.parse('https://sututeh.com');
  
  // Verifica que la URL se pueda lanzar
  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Abre en navegador externo
    );
  } else {
    throw Exception('No se pudo abrir el sitio web');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/imagenes/logoSth.png"),
              height: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              "Sindicato SUTUTEH",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Aplicación desarrollada para la gestión de asistencia, comunicación y organización de los agremiados.",
                style: TextStyle(color: Colors.white70, height: 1.4),
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              "Versión 1.0.0",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 25),

            // 🔹 Botón para visitar el sitio
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _abrirSitioWeb,
              icon: const Icon(Icons.public, color: Colors.white),
              label: const Text(
                "Visitar sitio oficial",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
