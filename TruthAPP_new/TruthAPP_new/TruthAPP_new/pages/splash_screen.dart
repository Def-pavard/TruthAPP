import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    // Initialiser l'animation de transition
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    _controller = AnimationController(
      duration: isDarkMode ? const Duration(milliseconds: 7000) : const Duration(milliseconds: 1500), // 7s pour mode nuit, 1.5s pour mode jour
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // Passer à la page suivante après la fin de l'animation
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
    // Déterminer le mode jour/nuit à partir du système
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white, // Blanc absolu pour mode jour, noir pour mode nuit
      body: Stack(
        children: [
          // Contenu centré (logo ou animation)
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: isDarkMode
                  ? Image.asset(
                      'assets/animation_nuit.gif', // GIF pour mode nuit
                      width: 150,
                      height: 150,
                    )
                  : Image.asset(
                      'assets/Bubbleplash.png', // Logo statique pour mode jour
                      width: 150,
                      height: 150,
                    ),
            ),
          ),
          // Texte "Truth AI" en bas, centré
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Text(
              'Truth AI',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
