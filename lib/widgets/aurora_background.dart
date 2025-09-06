// aurora_background.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuroraBackground extends StatefulWidget {
  final Widget child;

  const AuroraBackground({Key? key, required this.child}) : super(key: key);

  @override
  _AuroraBackgroundState createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  FragmentProgram? _program;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(days: 1),
      vsync: this,
    )..repeat();
    
    _loadShader();
  }

  Future<void> _loadShader() async {
    try {
      _program = await FragmentProgram.fromAsset('assets/shaders/aurora_shader.frag');
      setState(() {});
    } catch (e) {
      print('Erreur lors du chargement du shader: $e');
    }
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

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Fond noir
            Container(color: const Color(0xFF000000)),
            // Shader d'aurores boréales
            CustomPaint(
              painter: AuroraPainter(_program!, _controller.value, MediaQuery.of(context).size),
              size: Size.infinite,
            ),
            // Contenu par-dessus
            widget.child,
          ],
        );
      },
    );
  }
}

class AuroraPainter extends CustomPainter {
  final FragmentProgram program;
  final double time;
  final Size size;

  AuroraPainter(this.program, this.time, this.size);

  @override
  void paint(Canvas canvas, Size canvasSize) {
    if (size.isEmpty) return;

    final shader = program.fragmentShader()
      ..setFloat(0, size.width)  // uSize.x
      ..setFloat(1, size.height) // uSize.y
      ..setFloat(2, time);       // uTime

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(AuroraPainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.size != size;
  }
}