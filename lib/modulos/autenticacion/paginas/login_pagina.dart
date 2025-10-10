import 'package:flutter/material.dart';
import '../../inicio/paginas/inicio_pagina.dart';

class LoginPagina extends StatefulWidget {
  const LoginPagina({super.key});

  @override
  State<LoginPagina> createState() => _LoginPaginaState();
}

class _LoginPaginaState extends State<LoginPagina> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return 'Debe tener al menos 8 caracteres';
    }
    return null;
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const InicioPagina()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const iconColor = Color(0xFF64B5F6); // 🔹 Azul suave para iconos
    const greenSututeh = Color(0xFF4CAF50); // ✅ Verde institucional

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E1E1E),
              Color(0xFF121212),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔹 Logo
                  Image.asset(
                    'assets/imagenes/logoSth.png',
                    height: 120,
                  ),
                  const SizedBox(height: 25),

                  // 🔹 Título "¡Bienvenido!"
                  const Text(
                    "¡Bienvenido!",
                    style: TextStyle(
                      color: greenSututeh,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 🔹 Campo Email
                  TextFormField(
                    controller: _emailController,
                    validator: _validateEmail,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Correo Electrónico",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF2A2A2A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.email, color: iconColor),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // 🔹 Campo Contraseña
                  TextFormField(
                    controller: _passwordController,
                    validator: _validatePassword,
                    obscureText: !_showPassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF2A2A2A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: iconColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // 🔹 Botón Ingresar (verde)
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenSututeh,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      "Ingresar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🔹 Recuperar contraseña (verde)
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "¿Olvidaste tu contraseña?",
                      style: TextStyle(color: greenSututeh),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
