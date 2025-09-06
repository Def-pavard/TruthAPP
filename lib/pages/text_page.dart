// lib/pages/text_page.dart
import 'package:flutter/material.dart';
import 'package:truth_ai/api/api_service.dart';
import 'package:truth_ai/widgets/result_card.dart';
import 'package:truth_ai/generated/l10n.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _verificationResult;
  final Map<String, bool> _expandedSections = {};

  Future<void> _verifyText() async {
    if (_textController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _verificationResult = null;
      _expandedSections.clear();
    });
    
    try {
      final result = await ApiService.verifyText(_textController.text);
      setState(() {
        _verificationResult = result;
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
      _textController.clear();
      _verificationResult = null;
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonction de partage à implémenter')),
    );
  }

  Color _getVerdictColor(String synthesis) {
    if (synthesis.toLowerCase().contains('true') || 
        synthesis.toLowerCase().contains('vrai') ||
        synthesis.toLowerCase().contains('correct')) {
      return const Color(0xFF2ECC71); // Vert pour vrai
    }
    if (synthesis.toLowerCase().contains('false') || 
        synthesis.toLowerCase().contains('faux') ||
        synthesis.toLowerCase().contains('incorrect')) {
      return const Color(0xFFE74C3C); // Rouge pour faux
    }
    return const Color(0xFFF39C12); // Orange pour mixte/incertain
  }

  String _getVerdictText(String synthesis) {
    final s = S.of(context);
    if (synthesis.toLowerCase().contains('true') || 
        synthesis.toLowerCase().contains('vrai') ||
        synthesis.toLowerCase().contains('correct')) {
      return s.verdictTrue;
    }
    if (synthesis.toLowerCase().contains('false') || 
        synthesis.toLowerCase().contains('faux') ||
        synthesis.toLowerCase().contains('incorrect')) {
      return s.verdictFalse;
    }
    if (synthesis.toLowerCase().contains('mix') || 
        synthesis.toLowerCase().contains('part')) {
      return s.verdictMixed;
    }
    return s.verdictUnverifiable;
  }

  Widget _buildResults(Map<String, dynamic> result) {
    final analyses = result['analyses'] as Map<String, dynamic>? ?? {};
    final synthesis = result['final_synthesis'] as String? ?? '';

    return Column(
      children: [
        // Résultats individuels des modèles
        if (analyses['local_transformers'] != null)
          ResultCard(
            title: 'Analyse Transformers',
            content: analyses['local_transformers'].toString(),
            modelType: 'transformers',
            confidenceLevel: 0.8,
            isExpanded: _expandedSections['transformers'] ?? false,
            onToggleExpand: () => _toggleSection('transformers'),
            onShare: () => _shareResults(result),
          ),

        if (analyses['local_transformers'] != null) const SizedBox(height: 16),

        if (analyses['local_gguf'] != null)
          ResultCard(
            title: 'Analyse GGUF',
            content: analyses['local_gguf'].toString(),
            modelType: 'gguf',
            confidenceLevel: 0.7,
            isExpanded: _expandedSections['gguf'] ?? false,
            onToggleExpand: () => _toggleSection('gguf'),
            onShare: () => _shareResults(result),
          ),

        if (analyses['local_gguf'] != null) const SizedBox(height: 16),

        if (analyses['gemini'] != null)
          ResultCard(
            title: 'Analyse Gemini',
            content: analyses['gemini'].toString(),
            modelType: 'gemini',
            confidenceLevel: 0.9,
            isExpanded: _expandedSections['gemini'] ?? false,
            onToggleExpand: () => _toggleSection('gemini'),
            onShare: () => _shareResults(result),
          ),

        if (analyses['gemini'] != null) const SizedBox(height: 24),

        // Synthèse finale
        if (synthesis.isNotEmpty)
          FinalSynthesisCard(
            synthesis: synthesis,
            verdict: _getVerdictText(synthesis),
            verdictColor: _getVerdictColor(synthesis),
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

  Widget _buildInputSection() {
    return Column(
      children: [
        TextField(
          controller: _textController,
          maxLines: 5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Collez votre texte ici...',
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!.withOpacity(0.5)
                : Colors.grey[100]!.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 20),
        _isLoading
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _verifyText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Vérifier',
                    style: TextStyle(
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.text_fields,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun texte à analyser',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Collez un texte, un article ou une déclaration à vérifier',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.analyzeText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _verificationResult == null
                ? _textController.text.isEmpty
                    ? _buildEmptyState()
                    : _buildInputSection()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Aperçu du texte analysé (réduit)
                        if (_textController.text.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[800]!.withOpacity(0.3)
                                  : Colors.grey[100]!.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Texte analysé:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _textController.text.length > 100
                                      ? '${_textController.text.substring(0, 100)}...'
                                      : _textController.text,
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                        if (_textController.text.isNotEmpty) const SizedBox(height: 24),

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
                        _buildResults(_verificationResult!),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}