import 'package:flutter/material.dart';

class AyudaPagina extends StatelessWidget {
  const AyudaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Ayuda", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔹 1. Registrar asistencia
          _helpSection(
            icon: Icons.help_outline,
            titulo: "¿Cómo registrar asistencia?",
            descripcion: _textoAsistencia,
          ),

          // 🔹 2. Problemas con el QR
          _helpSection(
            icon: Icons.qr_code_scanner_rounded,
            titulo: "Problemas con el QR",
            descripcion: _textoQR,
          ),

          // 🔹 3. Actualizar datos personales
          _helpSection(
            icon: Icons.person_outline,
            titulo: "Actualizar datos personales",
            descripcion: _textoDatos,
          ),

          // 🔹 4. Problemas de inicio de sesión
          _helpSection(
            icon: Icons.lock_reset_rounded,
            titulo: "No puedo iniciar sesión",
            descripcion: _textoLogin,
          ),

          // 🔹 5. Foto o puesto no aparece
          _helpSection(
            icon: Icons.photo_camera_front_outlined,
            titulo: "Mi foto o puesto no aparece",
            descripcion: _textoFotoPuesto,
          ),

          const SizedBox(height: 25),
          const Center(
            child: Text(
              "© 2025 Sindicato SUTUTEH · Ayuda",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // ⭐ Tarjeta expandible + estilo profesional
  Widget _helpSection({
    required IconData icon,
    required String titulo,
    required String descripcion,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2939),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData.dark().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: Colors.white70,
          collapsedIconColor: Colors.white54,

          leading: Icon(icon, color: Colors.lightBlueAccent, size: 34),

          title: Text(
            titulo,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),

          children: [
            Text(
              descripcion,
              style: const TextStyle(
                color: Colors.white70,
                height: 1.4,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// ⭐ Textos estáticos — puedes editarlos cuando quieras

const String _textoAsistencia = """
1. Abre el módulo “Escáner QR”.
2. Permite acceso a la cámara.
3. Apunta al código que aparece en la reunión.
4. Espera la confirmación en pantalla.
5. Verifica tu asistencia desde tu perfil.
""";

const String _textoQR = """
Si el escáner QR no funciona prueba lo siguiente:
• Asegura buena iluminación.
• Limpia la cámara.
• Acércate o aléjate un poco.
• Reinicia la aplicación si el escáner se congela.
• Verifica que el código no esté dañado o borroso.
""";

const String _textoDatos = """
Para actualizar tu información:
1. Abre el módulo “Perfil”.
2. Revisa tus datos cargados desde el sistema.
3. Si hay errores, repórtalo al administrador del sindicato.
4. Tu foto sí puede actualizarse directamente desde la app.
""";

const String _textoLogin = """
Si tienes problemas para iniciar sesión:
• Verifica que tu correo esté registrado.
• Confirma que tu contraseña sea correcta.
• Revisa tu conexión a internet.
• Si olvidaste tu contraseña repórtalo al administrador.
• Si tu cuenta está inactiva no podrás acceder.
""";

const String _textoFotoPuesto = """
Esto puede ocurrir porque:
• Aún no tienes asignado un puesto oficial.
• Si no tienes puesto, se mostrará “Agremiado”.
• La foto puede tardar unos segundos en actualizarse.
• Si deseas actualizar tu puesto, repórtalo al administrador.
""";
