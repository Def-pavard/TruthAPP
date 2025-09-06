// lib/pages/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truth_ai/providers/theme_provider.dart';
import 'package:truth_ai/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // Initialiser le thème provider pour détecter le mode système
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.updateFromSystem();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    
    _controller.forward();
    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : const Color(0xFFF5F5DC),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo ou icône qui s'adapte au thème
              Icon(
                Icons.verified_user,
                size: 64,
                color: isDarkMode ? const Color(0xFF3EB489) : const Color(0xFF2ECC71),
              ),
              const SizedBox(height: 24),
              Text(
                'Truth AI Verifier',
                style: GoogleFonts.montserrat(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : const Color(0xFF2ECC71),
                ),
              ),
              const SizedBox(height: 16),
              if (isDarkMode)
                Text(
                  'Mode Nuit Activé',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                )
              else
                Text(
                  'Mode Jour Activé',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}