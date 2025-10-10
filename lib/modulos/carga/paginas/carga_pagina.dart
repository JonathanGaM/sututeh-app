import 'package:flutter/material.dart';
import 'dart:math' as math;

class CargaPagina extends StatefulWidget {
  const CargaPagina({super.key});

  @override
  State<CargaPagina> createState() => _CargaPaginaState();
}

class _CargaPaginaState extends State<CargaPagina>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Arco verde animado que gira
              RotationTransition(
                turns: _controller,
                child: CustomPaint(
                  size: const Size(200, 200),
                  painter: _ArcoPainter(),
                ),
              ),

              // Logo en el centro
              Image.asset(
                'assets/imagenes/logoSth.png',
                width: 150,
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArcoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Dibuja solo 120° (1/3 del círculo)
    canvas.drawArc(rect, 0, math.pi * 2 / 3, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
