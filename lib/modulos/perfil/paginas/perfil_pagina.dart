import 'package:flutter/material.dart';
import 'datos_personales_pagina.dart';

class PerfilPagina extends StatelessWidget {
  const PerfilPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Perfil",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Imagen de perfil
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/imagenes/perfil2.jpeg"),
            ),
            const SizedBox(height: 15),

            // 🔹 Nombre y correo
            const Text(
              "Jonathan García Martínez",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "20221074@uthh.edu.mx",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 10),

            // 🔹 Rol (Agremiado)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF673AB7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Agremiado",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 25),

            // 🔹 Tarjeta: Mis Datos
            _buildCard(
              context,
              icon: Icons.description_outlined,
              title: "Mis datos",
              subtitle: "Ver y actualizar información personal",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DatosPersonalesPagina()),
                );
              },
            ),

            const SizedBox(height: 16),

            // 🔹 Tarjeta: Cambiar Contraseña
            _buildCard(
              context,
              icon: Icons.vpn_key_rounded,
              title: "Cambiar contraseña",
              subtitle: "Actualizar credenciales de acceso",
              onTap: () {
                // Navegación al módulo de cambio de contraseña
              },
            ),

            const SizedBox(height: 25),

            // 🔹 Botón cerrar sesión
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
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Cerrar Sesión",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // 🔹 Footer
            const Text(
              "Sindicato App v1.0.0\n© 2025 Sindicato SUTUTEH",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget auxiliar para tarjetas de perfil
  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2939),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, color: Colors.blueAccent, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded,
            color: Colors.white54, size: 18),
        onTap: onTap,
      ),
    );
  }
}
