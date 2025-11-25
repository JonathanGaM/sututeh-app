import 'package:flutter/material.dart';
import '../../perfil/paginas/perfil_pagina.dart';
import '../../informacion/paginas/ayuda_pagina.dart';
import '../../informacion/paginas/acerca_de_pagina.dart';
import '../../inicio/servicios/inicio_service.dart';
import '../../autenticacion/servicios/auth_service.dart';
import '../../autenticacion/paginas/login_pagina.dart';
import '../../perfil/servicios/perfil_service.dart';

// 🔹 Importar los nuevos módulos
import '../../escaner/paginas/escaner_pagina.dart';
import '../../notificaciones/paginas/notificaciones_pagina.dart';

class InicioPagina extends StatefulWidget {
  const InicioPagina({super.key});

  @override
  State<InicioPagina> createState() => _InicioPaginaState();
}

class _InicioPaginaState extends State<InicioPagina> {
  int _index = 0;

  final InicioService _inicioService = InicioService();
  final PerfilService _perfilService = PerfilService();

  Map<String, dynamic>? _datosInicio;
  Map<String, dynamic>? _perfil;
  bool _isLoadingInicio = true;

  @override
  void initState() {
    super.initState();
    _cargarInicio();
    _cargarPerfil();
  }

  Future<void> _cargarInicio() async {
    final data = await _inicioService.obtenerDatosInicio();
    setState(() {
      _datosInicio = data;
      _isLoadingInicio = false;
    });
  }

  Future<void> _cargarPerfil() async {
    final data = await _perfilService.obtenerPerfil();
    setState(() {
      _perfil = data;
    });
  }

  // 🔹 Páginas inferiores
  List<Widget> get _pages => [
    _buildInicio(),
    const EscanerPagina(),
    const NotificacionesPagina(),
  ];

  Widget _buildInicio() {
    if (_isLoadingInicio) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green),
      );
    }

    final mision = _datosInicio?['mision'] ?? 'Sin misión registrada';
    final vision = _datosInicio?['vision'] ?? 'Sin visión registrada';
    final cover = _datosInicio?['cover'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (cover != null)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                cover,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/imagenes/p.jpg',
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
            ),

          _buildCard("Misión", mision, Colors.greenAccent),
          const SizedBox(height: 20),

          _buildCard("Visión", vision, Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildCard(String titulo, String contenido, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2939),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            contenido,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  final List<String> _titulos = ['SUTUTEH', 'Escáner QR', 'Avisos'];

  @override
  Widget build(BuildContext context) {
    final foto = _perfil?["url_foto"];
    final nombre = _perfil?["nombre_completo"] ?? "Cargando...";
    final puesto = _perfil?["puesto"] ?? "Agremiado";

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _titulos[_index],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),

      drawer: Drawer(
        backgroundColor: const Color(0xFF1E2939),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.green,
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 25,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: foto != null
                        ? NetworkImage(foto)
                        : const AssetImage("assets/imagenes/perfil.webp")
                              as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    nombre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    puesto,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.person_outline,
                      color: Colors.lightBlueAccent,
                    ),
                    title: const Text(
                      "Perfil",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PerfilPagina()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.help_outline,
                      color: Colors.lightBlueAccent,
                    ),
                    title: const Text(
                      "Ayuda",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AyudaPagina()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: Colors.lightBlueAccent,
                    ),
                    title: const Text(
                      "Acerca de",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AcercaDePagina(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
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
                    final auth = AuthService();
                    await auth.signOut();

                    if (!mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPagina()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    "Cerrar Sesión",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: _pages[_index],

      bottomNavigationBar: Container(
        color: const Color(0xFF1E2939),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: _index,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.white,
              onTap: (i) => setState(() => _index = i),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner),
                  label: 'QR',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none),
                  label: 'Avisos',
                ),
              ],
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              left: MediaQuery.of(context).size.width / 3 * _index,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 4,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
