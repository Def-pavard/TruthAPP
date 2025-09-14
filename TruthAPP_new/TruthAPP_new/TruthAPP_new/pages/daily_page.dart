// lib/pages/daily_page.dart
import 'package:flutter/material.dart';
import 'package:truth_ai/api/api_service.dart';
import 'package:truth_ai/widgets/welcome_sheet.dart';
import 'package:truth_ai/widgets/result_card.dart';
import 'package:truth_ai/generated/l10n.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  final TextEditingController _topicController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _dailyResult;
  bool _showWelcome = true;
  final Map<String, bool> _expandedSections = {};

  Future<void> _getDailyFactCheck() async {
    if (_topicController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _showWelcome = false;
      _dailyResult = null;
      _expandedSections.clear();
    });
    
    try {
      final result = await ApiService.getDailyFactCheck(_topicController.text);
      setState(() {
        _dailyResult = result;
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

  Future<void> _getDailySummary() async {
    setState(() {
      _isLoading = true;
      _showWelcome = false;
      _dailyResult = null;
      _expandedSections.clear();
    });
    
    try {
      final result = await ApiService.getDailySummary();
      setState(() {
        _dailyResult = result;
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
      _topicController.clear();
      _dailyResult = null;
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonction de partage à implémenter')),
    );
  }

  Widget _buildTopicInput() {
    return Column(
      children: [
        TextField(
          controller: _topicController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Entrez un sujet d\'actualité...',
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!.withOpacity(0.5)
                : Colors.grey[100]!.withOpacity(0.8),
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: _getDailyFactCheck,
            ),
          ),
          onSubmitted: (_) => _getDailyFactCheck(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _getDailyFactCheck,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Rechercher',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _getDailySummary,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Résumé du jour',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDailyResults() {
    if (_dailyResult == null) return const SizedBox();

    final factCheck = _dailyResult!['fact_check'] as String? ?? '';
    final summary = _dailyResult!['summary'] as String? ?? '';
    final sources = _dailyResult!['sources'] as List<dynamic>? ?? [];
    final topic = _dailyResult!['topic'] as String? ?? 'actualités du jour';

    final content = factCheck.isNotEmpty ? factCheck : summary;

    return Column(
      children: [
        // Carte principale des résultats
        ResultCard(
          title: 'Truth Daily - $topic',
          content: content,
          modelType: 'truthdaily',
          confidenceLevel: 0.85,
          isExpanded: _expandedSections['main'] ?? false,
          onToggleExpand: () => _toggleSection('main'),
          onShare: () => _shareResults(_dailyResult!),
        ),

        const SizedBox(height: 16),

        // Section des sources
        if (sources.isNotEmpty)
          ResultCard(
            title: 'Sources',
            content: _formatSources(sources),
            modelType: 'sources',
            confidenceLevel: 0.9,
            isExpanded: _expandedSections['sources'] ?? false,
            onToggleExpand: () => _toggleSection('sources'),
          ),

        const SizedBox(height: 24),

        // Bouton de nouvelle recherche
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

  String _formatSources(List<dynamic> sources) {
    final buffer = StringBuffer();
    for (int i = 0; i < sources.length; i++) {
      buffer.writeln('${i + 1}. ${sources[i]}');
    }
    return buffer.toString();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.newspaper,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Recherche d\'actualités',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Entrez un sujet ou consultez le résumé du jour',
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
      child: _showWelcome
          ? WelcomeSheet(
              imagePath: 'assets/images/ImageDailyApp.png',
              title: s.truthDaily,
              description: s.welcomeDaily,
              buttonText: 'Commencer',
              onButtonPressed: () {
                setState(() {
                  _showWelcome = false;
                });
              },
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
                      const SizedBox(height: 8),
                      Text(
                        'Recherche des dernières actualités...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : _dailyResult != null
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Titre des résultats
                          Text(
                            'Résultats Truth Daily:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Résultats détaillés
                          _buildDailyResults(),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recherche d\'actualités',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Column(
                            children: [
                              _buildTopicInput(),
                              const SizedBox(height: 32),
                              _buildEmptyState(),
                            ],
                          ),
                        ),
                      ],
                    ),
    );
  }
}
