// lib/widgets/result_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truth_ai/generated/l10n.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String content;
  final String modelType;
  final double confidenceLevel;
  final Color? borderColor;
  final bool isExpanded;
  final VoidCallback? onToggleExpand;
  final VoidCallback? onShare;

  const ResultCard({
    super.key,
    required this.title,
    required this.content,
    required this.modelType,
    this.confidenceLevel = 1.0,
    this.borderColor,
    this.isExpanded = false,
    this.onToggleExpand,
    this.onShare,
  });

  // Couleurs pour les différents types de modèles
  static Color _getModelColor(String modelType) {
    switch (modelType.toLowerCase()) {
      case 'gemini':
        return const Color(0xFF4285F4); // Bleu Google
      case 'gpt':
        return const Color(0xFF10A37F); // Vert OpenAI
      case 'grok':
        return const Color(0xFF000000); // Noir X/Twitter
      case 'transformers':
        return const Color(0xFFFF6B35); // Orange
      case 'gguf':
        return const Color(0xFF5856D6); // Violet
      default:
        return const Color(0xFF2ECC71); // Vert Truth AI
    }
  }

  // Icônes pour les différents types de modèles
  static IconData _getModelIcon(String modelType) {
    switch (modelType.toLowerCase()) {
      case 'gemini':
        return Icons.brightness_5; // Soleil
      case 'gpt':
        return Icons.auto_awesome; // Étoile
      case 'grok':
        return Icons.lightbulb_outline; // Ampoule
      case 'transformers':
        return Icons.transform; // Transform
      case 'gguf':
        return Icons.memory; // Mémoire
      default:
        return Icons.verified; Vérifié
    }
  }

  // Texte de confiance basé sur le niveau
  static String _getConfidenceText(double level, BuildContext context) {
    final s = S.of(context);
    if (level >= 0.9) return s.confidenceHigh;
    if (level >= 0.7) return s.confidenceMedium;
    if (level >= 0.5) return s.confidenceLow;
    return s.confidenceVeryLow;
  }

  // Couleur de confiance basée sur le niveau
  static Color _getConfidenceColor(double level) {
    if (level >= 0.9) return const Color(0xFF2ECC71); // Vert
    if (level >= 0.7) return const Color(0xFFF39C12); // Orange
    if (level >= 0.5) return const Color(0xFFE74C3C); // Rouge
    return const Color(0xFF95A5A6); // Gris
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final s = S.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: borderColor != null
            ? BorderSide(color: borderColor!, width: 2)
            : BorderSide.none,
      ),
      color: isDarkMode
          ? Colors.grey[900]!.withOpacity(0.8)
          : Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec titre et badge du modèle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _ModelBadge(
                  modelType: modelType,
                  confidence: confidenceLevel,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Barre de confiance
            if (confidenceLevel > 0)
              _ConfidenceBar(confidenceLevel: confidenceLevel),

            const SizedBox(height: 12),

            // Contenu du résultat
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: theme.textTheme.bodyMedium?.color,
              ),
              maxLines: isExpanded ? null : 3,
              overflow: isExpanded ? null : TextOverflow.ellipsis,
            ),

            const SizedBox(height: 16),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bouton expand/collapse
                if (onToggleExpand != null)
                  TextButton(
                    onPressed: onToggleExpand,
                    style: TextButton.styleFrom(
                      foregroundColor: theme.primaryColor,
                    ),
                    child: Text(
                      isExpanded ? s.seeLess : s.seeMore,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),

                const Spacer(),

                // Bouton partager
                if (onShare != null)
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 20,
                      color: theme.primaryColor,
                    ),
                    onPressed: onShare,
                    tooltip: s.shareResults,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Badge du modèle avec icône et indicateur de confiance
class _ModelBadge extends StatelessWidget {
  final String modelType;
  final double confidence;

  const _ModelBadge({
    required this.modelType,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    final modelColor = ResultCard._getModelColor(modelType);
    final confidenceText = ResultCard._getConfidenceText(confidence, context);
    final confidenceColor = ResultCard._getConfidenceColor(confidence);

    return Tooltip(
      message: '$modelType - $confidenceText',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: modelColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: modelColor.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              ResultCard._getModelIcon(modelType),
              size: 14,
              color: modelColor,
            ),
            const SizedBox(width: 4),
            Text(
              modelType.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: modelColor,
              ),
            ),
            if (confidence > 0) ...[
              const SizedBox(width: 4),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: confidenceColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Barre de progression de confiance
class _ConfidenceBar extends StatelessWidget {
  final double confidenceLevel;

  const _ConfidenceBar({
    required this.confidenceLevel,
  });

  @override
  Widget build(BuildContext context) {
    final confidenceColor = ResultCard._getConfidenceColor(confidenceLevel);
    final confidenceText = ResultCard._getConfidenceText(confidenceLevel, context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              confidenceText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: confidenceColor,
              ),
            ),
            Text(
              '${(confidenceLevel * 100).round()}%',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: confidenceLevel,
          backgroundColor: Colors.grey[300],
          color: confidenceColor,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

// Carte pour les résultats de synthèse finale
class FinalSynthesisCard extends StatelessWidget {
  final String synthesis;
  final String verdict;
  final Color verdictColor;

  const FinalSynthesisCard({
    super.key,
    required this.synthesis,
    required this.verdict,
    required this.verdictColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: verdictColor.withOpacity(0.3),
          width: 2,
        ),
      ),
      color: isDarkMode
          ? Colors.grey[900]!.withOpacity(0.9)
          : Colors.white.withOpacity(0.98),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Verdict
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: verdictColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: verdictColor.withOpacity(0.3)),
                ),
                child: Text(
                  verdict.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: verdictColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Séparateur
            Divider(
              color: verdictColor.withOpacity(0.2),
              thickness: 1,
            ),

            const SizedBox(height: 16),

            // Synthèse
            Text(
              synthesis,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: theme.textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 16),

            // Icône de vérification
            Center(
              child: Icon(
                Icons.verified,
                size: 32,
                color: verdictColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}