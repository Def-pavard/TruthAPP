// lib/widgets/light_ships_animation.dart
import 'dart:math';
import 'package:flutter/material.dart';

class LightShip {
  Offset position;
  Offset controlPoint1;
  Offset controlPoint2;
  Offset endPoint;
  double progress = 0.0;
  double speed;
  Color color;
  double size;

  LightShip(Size screenSize) {
    final random = Random();
    
    // Position de départ aléatoire sur les bords de l'écran
    final startEdge = random.nextInt(4);
    switch (startEdge) {
      case 0: // Haut
        position = Offset(random.nextDouble() * screenSize.width, 0);
        break;
      case 1: // Droite
        position = Offset(screenSize.width, random.nextDouble() * screenSize.height);
        break;
      case 2: // Bas
        position = Offset(random.nextDouble() * screenSize.width, screenSize.height);
        break;
      case 3: // Gauche
        position = Offset(0, random.nextDouble() * screenSize.height);
        break;
    }
    
    // Points de contrôle pour la courbe de Bézier
    controlPoint1 = Offset(
      random.nextDouble() * screenSize.width,
      random.nextDouble() * screenSize.height,
    );
    
    controlPoint2 = Offset(
      random.nextDouble() * screenSize.width,
      random.nextDouble() * screenSize.height,
    );
    
    // Point d'arrivée aléatoire sur les bords opposés
    final endEdge = (startEdge + 2) % 4;
    switch (endEdge) {
      case 0: // Haut
        endPoint = Offset(random.nextDouble() * screenSize.width, 0);
        break;
      case 1: // Droite
        endPoint = Offset(screenSize.width, random.nextDouble() * screenSize.height);
        break;
      case 2: // Bas
        endPoint = Offset(random.nextDouble() * screenSize.width, screenSize.height);
        break;
      case 3: // Gauche
        endPoint = Offset(0, random.nextDouble() * screenSize.height);
        break;
    }
    
    speed = 0.001 + random.nextDouble() * 0.003;
    size = 2.0 + random.nextDouble() * 4.0;
    
    // Couleur bleu ciel avec variations
    final blueVariation = random.nextDouble() * 0.2 - 0.1;
    color = Color.fromRGBO(
      135 + (blueVariation * 50).round(),
      206 + (blueVariation * 50).round(),
      235 + (blueVariation * 50).round(),
      0.6 + random.nextDouble() * 0.4,
    );
  }

  void update() {
    progress += speed;
    if (progress > 1.0) {
      progress = 0.0;
    }
    
    position = calculateBezierPoint(progress, position, controlPoint1, controlPoint2, endPoint);
  }

  Offset calculateBezierPoint(double t, Offset p0, Offset p1, Offset p2, Offset p3) {
    final double u = 1 - t;
    final double u2 = u * u;
    final double u3 = u2 * u;
    final double t2 = t * t;
    final double t3 = t2 * t;

    final double x = u3 * p0.dx + 3 * u2 * t * p1.dx + 3 * u * t2 * p2.dx + t3 * p3.dx;
    final double y = u3 * p0.dy + 3 * u2 * t * p1.dy + 3 * u * t2 * p2.dy + t3 * p3.dy;
    
    return Offset(x, y);
  }
}

class LightShipsPainter extends CustomPainter {
  final List<LightShip> ships;
  final double time;

  LightShipsPainter(this.ships, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shipPaint = Paint();
    
    for (final ship in ships) {
      // Dessiner le vaisseau principal
      shipPaint.color = ship.color;
      canvas.drawCircle(ship.position, ship.size, shipPaint);
      
      // Dessiner une traînée lumineuse
      final trailLength = 5;
      for (int i = 1; i <= trailLength; i++) {
        final trailProgress = ship.progress - (i * 0.02);
        if (trailProgress < 0) continue;
        
        final trailPos = ship.calculateBezierPoint(
          trailProgress, 
          ship.position, 
          ship.controlPoint1, 
          ship.controlPoint2, 
          ship.endPoint
        );
        
        final trailAlpha = 0.6 * (1 - i / trailLength.toDouble());
        shipPaint.color = ship.color.withOpacity(trailAlpha);
        canvas.drawCircle(trailPos, ship.size * (1 - i / trailLength.toDouble()), shipPaint);
      }
      
      // Ajouter un effet de lueur
      final glowPaint = Paint()
        ..color = ship.color.withOpacity(0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(ship.position, ship.size * 3, glowPaint);
    }
  }

  @override
  bool shouldRepaint(LightShipsPainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.ships != ships;
  }
}

class LightShipsBackground extends StatefulWidget {
  final Widget child;

  const LightShipsBackground({super.key, required this.child});

  @override
  _LightShipsBackgroundState createState() => _LightShipsBackgroundState();
}

class _LightShipsBackgroundState extends State<LightShipsBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<LightShip> ships = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(days: 1),
      vsync: this,
    )..repeat();
    
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeShips());
  }

  void _initializeShips() {
    final size = MediaQuery.of(context).size;
    setState(() {
      ships = List.generate(15, (_) => LightShip(size));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (final ship in ships) {
          ship.update();
        }
        
        return Stack(
          children: [
            Container(color: const Color(0xFFFFFFFF)),
            CustomPaint(
              painter: LightShipsPainter(ships, _controller.value),
              size: Size.infinite,
            ),
            widget.child,
          ],
        );
      },
    );
  }
}