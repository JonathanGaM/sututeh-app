import 'package:flutter/material.dart';

class DatosPersonalesPagina extends StatelessWidget {
  const DatosPersonalesPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Datos Personales",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            icon: Icons.person_outline,
            titulo: "Nombre completo",
            valor: "Jonathan García Martínez",
          ),
          _buildCard(
            icon: Icons.email_outlined,
            titulo: "Correo institucional",
            valor: "20221074@uthh.edu.mx",
          ),
          _buildCard(
            icon: Icons.badge_outlined,
            titulo: "Número de trabajador",
            valor: "123",
          ),
          _buildCard(
            icon: Icons.group_outlined,
            titulo: "Número de sindicalizado",
            valor: "562",
          ),
          _buildCard(
            icon: Icons.work_outline,
            titulo: "Puesto en la universidad",
            valor: "Técnico en desarrollo de software",
          ),
          _buildCard(
            icon: Icons.school_outlined,
            titulo: "Nivel educativo",
            valor: "Ingeniería en Desarrollo y Gestión de Software",
          ),
          _buildCard(
            icon: Icons.assignment_ind_outlined,
            titulo: "CURP",
            valor: "JFMDK23MFKD2K1LDLL",
          ),
          _buildCard(
            icon: Icons.phone_android_rounded,
            titulo: "Número de teléfono",
            valor: "771-287-8740",
          ),
          const SizedBox(height: 20),

          // Pie de página
          const Center(
            child: Text(
              "© 2025 Sindicato SUTUTEH",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Widget auxiliar para construir las tarjetas uniformes
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 26),
        title: Text(
          titulo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
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
