// lib/pages/forensics_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truth_ai/api/api_service.dart';
import 'package:truth_ai/widgets/welcome_sheet.dart';
import 'package:truth_ai/widgets/result_card.dart';
import 'package:truth_ai/generated/l10n.dart';

class ForensicsPage extends StatefulWidget {
  const ForensicsPage({super.key});

  @override
  _ForensicsPageState createState() => _ForensicsPageState();
}

class _ForensicsPageState extends State<ForensicsPage> {
  XFile? _selectedImage;
  bool _isLoading = false;
  Map<String, dynamic>? _analysisResult;
  bool _showWelcome = true;
  final Map<String, bool> _expandedSections = {};

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _selectedImage = image;
        _showWelcome = false;
      });
      await _analyzeImage(image);
    }
  }

  Future<void> _analyzeImage(XFile image) async {
    setState(() {
      _isLoading = true;
      _analysisResult = null;
      _expandedSections.clear();
    });
    
    try {
      final result = await ApiService.verifyImage(image);
      setState(() {
        _analysisResult = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  void _resetAnalysis() {
    setState(() {
      _selectedImage = null;
      _analysisResult = null;
      _showWelcome = true;
      _expandedSections.clear();
    });
  }

  void _toggleSection(String sectionKey) {
    setState(() {
      _expandedSections[sectionKey] = !(_expandedSections[sectionKey] ?? false);
    });
  }

  void _shareResults(Map<String, dynamic> result) {
    // Implémentation du partage des résultats
    // Pourrait utiliser share_plus package ou autre méthode de partage
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonction de partage à implémenter')),
    );
  }

  Color _getVerdictColor(String origin) {
    if (origin.toLowerCase().contains('ia') || origin.toLowerCase().contains('ai')) {
      return const Color(0xFFE74C3C); // Rouge pour IA
    }
    if (origin.toLowerCase().contains('photographie') || 
        origin.toLowerCase().contains('photo')) {
      return const Color(0xFF2ECC71); // Vert pour photo
    }
    return const Color(0xFFF39C12); // Orange pour incertain
  }

  String _getVerdictText(String origin) {
    final s = S.of(context);
    if (origin.toLowerCase().contains('ia') || origin.toLowerCase().contains('ai')) {
      return s.verdictFalse;
    }
    if (origin.toLowerCase().contains('photographie') || 
        origin.toLowerCase().contains('photo')) {
      return s.verdictTrue;
    }
    return s.verdictMixed;
  }

  Widget _buildImagePreview() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: _selectedImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(_selectedImage!.path),
                fit: BoxFit.cover,
              ),
            )
          : const Icon(Icons.image, size: 64, color: Colors.grey),
    );
  }

  Widget _buildAnalysisResults() {
    if (_analysisResult == null) return const SizedBox();

    final result = _analysisResult!['result'] as Map<String, dynamic>;
    final report = result['struct_report'] as Map<String, dynamic>;
    final message = result['message'] as String;

    return Column(
      children: [
        // Carte principale d'analyse
        ResultCard(
          title: S.of(context).imageForensics,
          content: message,
          modelType: 'forensics',
          confidenceLevel: (report['confiance'] as double?) ?? 0.5,
          borderColor: _getVerdictColor(report['origine'] ?? ''),
          isExpanded: _expandedSections['main'] ?? false,
          onToggleExpand: () => _toggleSection('main'),
          onShare: () => _shareResults(_analysisResult!),
        ),

        const SizedBox(height: 16),

        // Section des métadonnées EXIF
        if (result['exif'] != null && (result['exif'] as Map).isNotEmpty)
          ResultCard(
            title: 'Métadonnées EXIF',
            content: _formatExifData(result['exif'] as Map<String, dynamic>),
            modelType: 'metadata',
            confidenceLevel: 0.8,
            isExpanded: _expandedSections['exif'] ?? false,
            onToggleExpand: () => _toggleSection('exif'),
          ),

        const SizedBox(height: 16),

        // Section d'analyse de falsification
        if (result['tampering_analysis'] != null)
          ResultCard(
            title: 'Analyse de Falsification',
            content: _formatTamperingAnalysis(
                result['tampering_analysis'] as Map<String, dynamic>),
            modelType: 'tampering',
            confidenceLevel: 0.7,
            isExpanded: _expandedSections['tampering'] ?? false,
            onToggleExpand: () => _toggleSection('tampering'),
          ),

        const SizedBox(height: 24),

        // Bouton de nouvelle analyse
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _resetAnalysis,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              S.of(context).newAnalysis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatExifData(Map<String, dynamic> exifData) {
    final buffer = StringBuffer();
    exifData.forEach((key, value) {
      if (key != 'JPEGThumbnail' && key != 'TIFFThumbnail' && key != 'EXIF MakerNote') {
        buffer.writeln('• $key: $value');
      }
    });
    return buffer.toString();
  }

  String _formatTamperingAnalysis(Map<String, dynamic> tamperingData) {
    final buffer = StringBuffer();
    
    if (tamperingData['ela'] != null) {
      final ela = tamperingData['ela'] as Map<String, dynamic>;
      buffer.writeln('• Analyse ELA: ${ela['tampering_likelihood']}');
    }
    
    if (tamperingData['clone_detection'] != null) {
      final clone = tamperingData['clone_detection'] as Map<String, dynamic>;
      buffer.writeln('• Détection de clones: ${clone['cloning_likelihood']}');
    }
    
    if (tamperingData['prnu_analysis'] != null) {
      final prnu = tamperingData['prnu_analysis'] as Map<String, dynamic>;
      buffer.writeln('• Analyse PRNU: ${prnu['prnu_likelihood']}');
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _showWelcome
          ? WelcomeSheet(
              imagePath: 'assets/images/ForensicsModeApp.png',
              title: s.imageForensics,
              description: s.welcomeForensics,
              buttonText: s.uploadImage,
              onButtonPressed: _pickImage,
            )
          : _isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        s.analysisInProgress,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : _analysisResult != null
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Aperçu de l'image
                          _buildImagePreview(),

                          const SizedBox(height: 24),

                          // Titre des résultats
                          Text(
                            'Résultats de l\'analyse:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Résultats détaillés
                          _buildAnalysisResults(),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.image_search, size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            'Aucune image sélectionnée',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _pickImage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              s.uploadImage,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}