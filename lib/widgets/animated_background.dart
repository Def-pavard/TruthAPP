// lib/widgets/animated_background.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truth_ai/providers/theme_provider.dart';
import 'light_ships_animation.dart';
import 'aurora_background.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return themeProvider.isDarkMode
        ? AuroraBackground(child: child)
        : LightShipsBackground(child: child);
  }
}