import 'package:flutter/material.dart';
import '../../autenticacion/servicios/auth_service.dart';
import '../servicios/perfil_service.dart';
import '../../autenticacion/paginas/login_pagina.dart';

class PerfilPagina extends StatefulWidget {
  const PerfilPagina({super.key});

  @override
  State<PerfilPagina> createState() => _PerfilPaginaState();
}

class _PerfilPaginaState extends State<PerfilPagina> {
  final PerfilService _perfilService = PerfilService();
  Map<String, dynamic>? _perfil;
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarPerfil();
  }

  Future<void> _cargarPerfil() async {
    final data = await _perfilService.obtenerPerfil();
    setState(() {
      _perfil = data;
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F0F0F),
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    // 🔹 Datos del backend
    final foto = _perfil?["url_foto"];
    final nombre = _perfil?["nombre_completo"] ?? "...";
    final correo = _perfil?["correo"] ?? "...";
    final puesto = _perfil?["puesto"] ?? "Agremiado";

    final telefono = "${_perfil?["telefono"] ?? "..."}";
    final curp = "${_perfil?["curp"] ?? "..."}";
    final numTrabajador = "${_perfil?["numero_trabajador"] ?? "..."}";
    final numSindical = "${_perfil?["numero_sindicalizado"] ?? "..."}";
    final nivel = "${_perfil?["nivel_educativo"] ?? "..."}";
    final programa = "${_perfil?["programa_educativo"] ?? "..."}";

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          "Perfil",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
        child: Column(
          children: [
            // 🔹 Foto
            CircleAvatar(
              radius: 60,
              backgroundImage: foto != null
                  ? NetworkImage(foto)
                  : const AssetImage("assets/imagenes/perfil2.jpeg")
                        as ImageProvider,
            ),

            const SizedBox(height: 15),

            // 🔹 Nombre
            Text(
              nombre,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // 🔹 Correo
            Text(
              correo,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 8),

            // 🔹 Puesto
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF673AB7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                puesto,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 🔹 Datos personales
            _sectionTitle("Datos personales"),
            _buildCard(
              icon: Icons.phone_android,
              titulo: "Teléfono",
              valor: telefono,
            ),
            _buildCard(
              icon: Icons.badge,
              titulo: "Número de trabajador",
              valor: numTrabajador,
            ),
            _buildCard(
              icon: Icons.people,
              titulo: "Número sindicalizado",
              valor: numSindical,
            ),
            _buildCard(icon: Icons.assignment_ind, titulo: "CURP", valor: curp),

            const SizedBox(height: 25),

            // 🔹 Datos académicos
            _sectionTitle("Datos académicos / laborales"),
            _buildCard(
              icon: Icons.school,
              titulo: "Nivel educativo",
              valor: nivel,
            ),
            _buildCard(
              icon: Icons.menu_book,
              titulo: "Programa educativo",
              valor: programa,
            ),

            const SizedBox(height: 30),

            // 🔹 Cerrar sesión
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await AuthService().signOut();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPagina()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Cerrar sesión",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Sindicato App v1.0.0\n© 2025 Sindicato SUTUTEH",
              style: TextStyle(color: Colors.white54, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String titulo,
    required String valor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2939),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          titulo,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          valor,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ),
    );
  }
}
