// lib/widgets/welcome_sheet.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSheet extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const WelcomeSheet({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultBackgroundColor = isDarkMode 
        ? Colors.black.withOpacity(0.8) 
        : Colors.white.withOpacity(0.9);
    final defaultTextColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image d'illustration avec adaptation au thème
          ColorFiltered(
            colorFilter: isDarkMode
                ? const ColorFilter.mode(Colors.white, BlendMode.modulate)
                : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
            child: Image.asset(
              imagePath,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24),
          
          // Titre
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor ?? defaultTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: textColor ?? defaultTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // Bouton d'action
          ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}