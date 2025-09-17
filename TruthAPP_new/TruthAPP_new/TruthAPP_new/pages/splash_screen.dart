import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truth_ai/providers/theme_provider.dart';
import 'package:truth_ai/pages/home_page.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  VideoPlayerController? _videoController;

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

    // Initialiser le contrôleur vidéo pour mode nuit
    if (themeProvider.isDarkMode) {
      _videoController = VideoPlayerController.asset('assets/animation_nuit.mp4')
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
          _videoController!.setLooping(true);
        });
    }

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _videoController?.dispose();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white, // Blanc absolu pour mode jour
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Bubbleplash
              Image.asset(
                'assets/Bubblesplash.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 24),
              // Animation ou image selon le mode
              isDarkMode
                  ? (_videoController != null && _videoController!.value.isInitialized
                      ? SizedBox(
                          width: 300,
                          height: 200,
                          child: VideoPlayer(_videoController!),
                        )
                      : const CircularProgressIndicator())
                  : Image.asset(
                      'assets/Splashanim.png', // Image pour mode jour
                      width: 300,
                      height: 200,
                    ),
              const SizedBox(height: 16),
              Text(
                isDarkMode ? 'Mode Nuit Activé' : 'Mode Jour Activé',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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
