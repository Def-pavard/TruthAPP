// lib/aurora_background.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuroraBackground extends StatefulWidget {
  final Widget child;
  const AuroraBackground({Key? key, required this.child}) : super(key: key);

  @override
  _AuroraBackgroundState createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  FragmentProgram? _program;

  // Organisme
  double x = 0.1, amp = 1.0, freq = 1.5, health = 1.0;
  int gen = 1, stagnation = 0;
  final Random rand = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(days: 1))
      ..addListener(() => setState(() => updateOrganism()));
    _controller.repeat();
    _loadShader();
  }

  Future<void> _loadShader() async {
    _program = await FragmentProgram.fromAsset('assets/shaders/aurora_shader.frag');
    setState(() {});
  }

  void updateOrganism() {
    if (health <= 0) return;

    double life = sin(_controller.value * 10);
    double A = amp * (1 + 0.8 * life) * (0.8 + 0.5 * sin(gen));
    double B = freq * (1 + 0.6 * life.abs()) * (0.9 + 0.3 * cos(gen));
    double D = 0.4 * sin(_controller.value * 15) * health;
    double R = x.abs() < 0.2 ? 0.8 * (rand.nextDouble() - 0.5) : 0.0;
    double eps = (rand.nextDouble() - 0.5) * 0.25;

    double xNew = A * sin(B * x) + R + eps + D;

    if (xNew.abs() > amp * 7 || (xNew.abs() < 0.12 && x.abs() < 0.12)) {
      stagnation++;
      if (stagnation > 6 || xNew.abs() > amp * 7) rebirth();
    } else {
      stagnation = 0;
    }

    x = health > 0 ? xNew : 0;
    health = (health - 0.0003).clamp(0.0, 1.0);
  }

  void rebirth() {
    gen++;
    amp = (amp * (0.8 + 0.7 * rand.nextDouble())).clamp(0.5, 5.0);
    freq = (freq * (0.9 + 0.4 * rand.nextDouble())).clamp(1.0, 3.0);
    x = rand.nextDouble() * 0.6 - 0.3;
    health = 1.0;
    stagnation = 0;
    print("RENAISSANCE ! GEN $gen | amp: ${amp.toStringAsFixed(2)}");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_program == null) {
      return Container(color: Colors.black, child: widget.child);
    }

    return Stack(
      children: [
        Container(color: Colors.black),
        CustomPaint(
          painter: AuroraPainter(_program!, _controller.value, MediaQuery.of(context).size, gen.toDouble(), health),
          size: Size.infinite,
        ),
        Positioned(
          top: 40, left: 20,
          child: Text(
            "GEN $gen | Heart ${health.toStringAsFixed(2)}",
            style: TextStyle(
              color: health > 0.5 ? Colors.cyan : Colors.redAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 12, color: Colors.black)],
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class AuroraPainter extends CustomPainter {
  final FragmentProgram program;
  final double time, gen, health;
  final Size size;

  AuroraPainter(this.program, this.time, this.size, this.gen, this.health);

  @override
  void paint(Canvas canvas, Size size) {
    final shader = program.fragmentShader()
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, time)
      ..setFloat(3, gen)
      ..setFloat(4, health);
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(_) => true;
}
