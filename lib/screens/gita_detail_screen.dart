import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

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
    final ch = widget.chapter;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: Text('Adhyaya ${ch['number']}: ${ch['sanskritName']}', style: const TextStyle(fontSize: 16)),
        backgroundColor: Colors.orange.shade800,
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
              // Chapter Header Banner
              Card(
                color: Colors.orange.shade800,
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

              // Simple English content
              Text(
                'English Explanation',
                style: TextStyle(fontSize: fontSize + 2, fontWeight: FontWeight.bold, color: Colors.orange.shade900),
              ),
              const SizedBox(height: 8),
              Text(
                ch['englishExplanation'] as String,
                style: TextStyle(fontSize: fontSize, color: isDark ? Colors.white70 : Colors.black87, height: 1.4),
              ),

              const SizedBox(height: 16),

              // Roman English content
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🗣️ Roman English Translation:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      ch['romanEnglishExplanation'] as String,
                      style: TextStyle(
                        fontSize: fontSize - 1,
                        color: isDark ? Colors.white70 : Colors.brown.shade900,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Krishna-Arjuna Context
              Text(
                '⚔️ Krishna-Arjuna Context',
                style: TextStyle(fontSize: fontSize + 2, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.brown.shade800),
              ),
              const SizedBox(height: 6),
              Text(
                ch['context'] as String,
                style: TextStyle(fontSize: fontSize, color: isDark ? Colors.white70 : Colors.black87, height: 1.4),
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
                      style: TextStyle(fontSize: fontSize, color: isDark ? Colors.white70 : Colors.black87),
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
                          backgroundColor: Colors.orange.shade100,
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
                color: isDark ? Colors.grey.shade800 : Colors.amber.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.amber.shade700, width: 1),
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
                          Text(
                            'REAL-LIFE ANALOGY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isDark ? Colors.amber : Colors.orange.shade900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ch['example'] as String,
                        style: TextStyle(
                          fontSize: fontSize - 1,
                          color: isDark ? Colors.white70 : Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Scripture Source
              Text(
                'Source: ${ch['source']}',
                style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey),
                textAlign: TextAlign.right,
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
        color: isDark ? Colors.grey.shade800 : Colors.orange.shade50.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('❓', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              const Text('CHAPTER RECAP QUIZ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.orange)),
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
              optColor = Colors.orange.shade200;
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
              _quizCorrect ? '✅ Correct! Exellent work.' : '❌ Incorrect! Try reviewing the name at top.',
              style: TextStyle(fontWeight: FontWeight.bold, color: _quizCorrect ? Colors.green : Colors.red),
            )
          ]
        ],
      ),
    );
  }
}
