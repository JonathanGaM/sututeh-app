import 'package:flutter/material.dart';

class AyudaPagina extends StatelessWidget {
  const AyudaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayuda", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF121212),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            color: Color(0xFF1E2939),
            child: ListTile(
              leading: Icon(Icons.help, color: Colors.lightBlueAccent),
              title: Text("¿Cómo registrar asistencia?",
                  style: TextStyle(color: Colors.white)),
              subtitle: Text("Consulta nuestra guía paso a paso",
                  style: TextStyle(color: Colors.white70)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70),
            ),
          ),
          Card(
            color: Color(0xFF1E2939),
            child: ListTile(
              leading: Icon(Icons.qr_code, color: Colors.lightBlueAccent),
              title: Text("Problemas con el escáner QR",
                  style: TextStyle(color: Colors.white)),
              subtitle: Text("Sigue estos pasos",
                  style: TextStyle(color: Colors.white70)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
