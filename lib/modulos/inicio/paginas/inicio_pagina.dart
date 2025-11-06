import 'package:flutter/material.dart';
import '../../perfil/paginas/perfil_pagina.dart';
import '../../informacion/paginas/ayuda_pagina.dart';
import '../../informacion/paginas/acerca_de_pagina.dart';

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

  // 🔹 Páginas que se renderizan según el menú inferior
  // 🔹 Páginas que se renderizan según el menú inferior
// 🔹 Páginas que se renderizan según el menú inferior
final _pages = [
  SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 🔹 Imagen principal
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            "assets/imagenes/p.jpg", // tu imagen
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity, // ocupa todo el ancho igual que los contenedores
          ),
        ),

        // 🔹 Contenedor de Misión
        Container(
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Misiónnnnn",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Representar y defender los intereses laborales, profesionales y humanos de los agremiados, promoviendo la unión, la participación y el desarrollo continuo dentro de la comunidad universitaria.",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // 🔹 Contenedor de Visión
        Container(
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Visión",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Ser un sindicato sólido, transparente y comprometido con el bienestar de sus miembros, fomentando la participación activa y el crecimiento profesional en un entorno de respeto y colaboración.",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
  const EscanerPagina(),
  const NotificacionesPagina(),
];

  // 🔹 Títulos dinámicos del AppBar
  final List<String> _titulos = [
    'SUTUTEH',
    'Escáner QR',
    'Avisos',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      // 🔹 AppBar dinámico
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _titulos[_index],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ),

      // 🔹 Drawer (menú lateral)
      drawer: Drawer(
        backgroundColor: const Color(0xFF1E2939),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.green,
              padding: const EdgeInsets.only(
                  top: 50, bottom: 25, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage("assets/imagenes/perfil.webp"),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Jonathan Garcia Martinez",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Agremiado",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // 🔹 Opciones de navegación
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline,
                        color: Colors.lightBlueAccent),
                    title: const Text("Perfil",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PerfilPagina()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_outline,
                        color: Colors.lightBlueAccent),
                    title: const Text("Ayuda",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AyudaPagina()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline,
                        color: Colors.lightBlueAccent),
                    title: const Text("Acerca de",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AcercaDePagina()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // 🔹 Botón cerrar sesión
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
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
                    style:
                        TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔹 Contenido dinámico
      body: _pages[_index],

      // 🔹 Menú inferior
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

            // 🔹 Indicador animado verde inferior
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              left:
                  MediaQuery.of(context).size.width / 3 * _index,
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
