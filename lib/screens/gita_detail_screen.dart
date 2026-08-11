import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../widgets/language_toggle_bar.dart';

class GitaDetailScreen extends StatefulWidget {
  final Map<String, dynamic> chapter;

  const GitaDetailScreen({Key? key, required this.chapter}) : super(key: key);

  @override
  State<GitaDetailScreen> createState() => _GitaDetailScreenState();
}

class _GitaDetailScreenState extends State<GitaDetailScreen> {
  bool _quizCorrect = false;
  bool _quizSubmitted = false;
  int? _selectedAnswerIdx;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;
    final fontSize = appState.settings.fontSize;
    final lang = appState.settings.language;
    final ch = widget.chapter;

    final String localizedTitle = (ch['titleTranslations'] as Map<String, String>)[lang] ?? ch['sanskritName'] as String;
    final String localizedExplanation = ch['${lang.toLowerCase().replaceAll(' ', '')}Explanation'] ?? ch['englishExplanation'] as String;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF9F0),
      appBar: AppBar(
        title: Text('Adhyaya ${ch['number']}: $localizedTitle', style: const TextStyle(fontSize: 16)),
        backgroundColor: const Color(0xFF8B1A1A), // Deep Maroon
        actions: [
          IconButton(
            icon: Icon(
              appState.bookmarkedScriptureIds.contains('gita_ch_${ch['number']}')
                  ? Icons.bookmark
                  : Icons.bookmark_border,
            ),
            onPressed: () {
              appState.toggleBookmarkScripture('gita_ch_${ch['number']}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(appState.bookmarkedScriptureIds.contains('gita_ch_${ch['number']}')
                      ? 'Chapter Bookmarked!'
                      : 'Bookmark Removed!'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Language toggle
              const Center(child: LanguageToggleBar()),
              const SizedBox(height: 16),

              // Chapter Header Banner
              Card(
                color: const Color(0xFF8B1A1A),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'CHAPTER ${ch['number']}',
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        ch['sanskritName'] as String,
                        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ch['englishTitle'] as String,
                        style: const TextStyle(color: Colors.white70, fontSize: 14, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Explanation
              Text(
                'Explanation',
                style: TextStyle(fontSize: fontSize + 2, fontWeight: FontWeight.bold, color: const Color(0xFFFF6B00)),
              ),
              const SizedBox(height: 8),
              Text(
                localizedExplanation,
                style: TextStyle(fontSize: fontSize, color: isDark ? Colors.white70 : const Color(0xFF2D1B0E), height: 1.4),
              ),

              const SizedBox(height: 16),

              // Krishna-Arjuna Context
              Text(
                'Context',
                style: TextStyle(fontSize: fontSize + 2, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF2D1B0E)),
              ),
              const SizedBox(height: 6),
              Text(
                ch['context'] as String,
                style: TextStyle(fontSize: fontSize, color: isDark ? Colors.white70 : const Color(0xFF2D1B0E), height: 1.4),
              ),

              const SizedBox(height: 16),

              // Important teachings & themes
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📌 KEY CHAPTER TEACHINGS',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ch['teachings'] as String,
                      style: TextStyle(fontSize: fontSize, color: isDark ? Colors.white70 : const Color(0xFF2D1B0E)),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '🌟 MAIN THEMES:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: (ch['mainThemes'] as List<String>).map((t) {
                        return Chip(
                          backgroundColor: const Color(0xFFFF6B00).withOpacity(0.1),
                          label: Text(t, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Easy real life example
              Card(
                color: isDark ? Colors.grey.shade800 : const Color(0xFFFFF9F0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFD4AF37), width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('💡', style: TextStyle(fontSize: 20)),
                          const SizedBox(width: 8),
                          const Text(
                            'REAL-LIFE ANALOGY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFFFF6B00),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ch['example'] as String,
                        style: TextStyle(
                          fontSize: fontSize - 1,
                          color: isDark ? Colors.white70 : const Color(0xFF2D1B0E),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Simple Quiz system
              _buildGitaQuiz(context, isDark, fontSize, appState),

              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  appState.completeLesson('gita_chapter_${ch['number']}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('🎉 Adhyaya Completed! +50 XP Earned!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Mark Chapter as Read', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGitaQuiz(BuildContext context, bool isDark, double fontSize, AppState state) {
    final chNum = widget.chapter['number'];
    final question = 'What is the Sanskrit name for Bhagavad Gita Chapter $chNum?';
    final options = [
      widget.chapter['sanskritName'] as String,
      'Siddha Marg',
      'Maya Rahasya',
      'Ananda Lahari'
    ]..shuffle(); // Keep correct first then shuffle

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : const Color(0xFFFFF9F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFF6B00), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('❓', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              const Text('CHAPTER RECAP QUIZ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFFF6B00))),
            ],
          ),
          const SizedBox(height: 8),
          Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(options.length, (idx) {
            final opt = options[idx];
            Color optColor = Colors.grey.shade300;
            if (_quizSubmitted) {
              if (opt == widget.chapter['sanskritName']) {
                optColor = Colors.green.shade200;
              } else if (_selectedAnswerIdx == idx) {
                optColor = Colors.red.shade200;
              }
            } else if (_selectedAnswerIdx == idx) {
              optColor = const Color(0xFFFF6B00).withOpacity(0.3);
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: _quizSubmitted ? null : () {
                  setState(() {
                    _selectedAnswerIdx = idx;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: optColor, borderRadius: BorderRadius.circular(8)),
                  child: Text(opt),
                ),
              ),
            );
          }),
          if (!_quizSubmitted)
            ElevatedButton(
              onPressed: _selectedAnswerIdx == null ? null : () {
                final chosen = options[_selectedAnswerIdx!];
                final correct = chosen == widget.chapter['sanskritName'];
                setState(() {
                  _quizSubmitted = true;
                  _quizCorrect = correct;
                });
                state.completeQuiz('gita_ch_quiz_$chNum', correct ? 1 : 0, 1);
              },
              child: const Text('Submit Answer'),
            ),
          if (_quizSubmitted) ...[
            const SizedBox(height: 8),
            Text(
              _quizCorrect ? '✅ Correct! Excellent work.' : '❌ Incorrect! Try reviewing the name at top.',
              style: TextStyle(fontWeight: FontWeight.bold, color: _quizCorrect ? Colors.green : Colors.red),
            )
          ]
        ],
      ),
    );
  }
}
