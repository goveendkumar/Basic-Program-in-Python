import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../state/app_state.dart';

class QuizPlayScreen extends StatefulWidget {
  final String category;
  final List<QuizQuestion> questions;

  const QuizPlayScreen({Key? key, required this.category, required this.questions}) : super(key: key);

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  int _currentIdx = 0;
  int? _selectedIdx;
  bool _submitted = false;
  int _correctCount = 0;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;
    final fontSize = appState.settings.fontSize;

    final q = widget.questions[_currentIdx];

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: Text('${widget.category} Quiz 🏆'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${_currentIdx + 1} of ${widget.questions.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  Text(
                    'Correct: $_correctCount',
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (_currentIdx + 1) / widget.questions.length,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              ),

              const SizedBox(height: 24),

              // Question text
              Text(
                q.question,
                style: TextStyle(fontSize: fontSize + 4, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // Options
              ...List.generate(q.options.length, (idx) {
                final opt = q.options[idx];
                Color cardColor = isDark ? Colors.grey.shade800 : Colors.white;
                BorderSide border = BorderSide(color: Colors.grey.shade300);

                if (_submitted) {
                  if (opt == q.correctAnswer) {
                    cardColor = Colors.green.shade100;
                    border = const BorderSide(color: Colors.green, width: 2);
                  } else if (_selectedIdx == idx) {
                    cardColor = Colors.red.shade100;
                    border = const BorderSide(color: Colors.red, width: 2);
                  }
                } else if (_selectedIdx == idx) {
                  cardColor = Colors.orange.shade50;
                  border = const BorderSide(color: Colors.orange, width: 2);
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    onTap: _submitted
                        ? null
                        : () {
                            setState(() {
                              _selectedIdx = idx;
                            });
                          },
                    child: Card(
                      color: cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: border,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          opt,
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 16),

              // Feedback & explanation block
              if (_submitted) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedIdx != null && q.options[_selectedIdx!] == q.correctAnswer
                            ? '✅ Correct Answer!'
                            : '❌ Incorrect Answer!',
                        style: TextStyle(
                          fontSize: fontSize + 1,
                          fontWeight: FontWeight.bold,
                          color: _selectedIdx != null && q.options[_selectedIdx!] == q.correctAnswer
                              ? Colors.green.shade800
                              : Colors.red.shade800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Explanation: ${q.explanation}',
                        style: TextStyle(fontSize: fontSize - 1, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Submission and navigation buttons
              if (!_submitted)
                ElevatedButton(
                  onPressed: _selectedIdx == null
                      ? null
                      : () {
                          final isCorrect = q.options[_selectedIdx!] == q.correctAnswer;
                          setState(() {
                            _submitted = true;
                            if (isCorrect) _correctCount++;
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('SUBMIT ANSWER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                )
              else
                ElevatedButton(
                  onPressed: () {
                    if (_currentIdx < widget.questions.length - 1) {
                      setState(() {
                        _currentIdx++;
                        _selectedIdx = null;
                        _submitted = false;
                      });
                    } else {
                      // Save total score
                      appState.completeQuiz(widget.category, _correctCount, widget.questions.length);

                      // Show Result Screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizResultScreen(
                            category: widget.category,
                            correct: _correctCount,
                            total: widget.questions.length,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    _currentIdx < widget.questions.length - 1 ? 'NEXT QUESTION' : 'VIEW RESULT',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Simple result view
class QuizResultScreen extends StatelessWidget {
  final String category;
  final int correct;
  final int total;

  const QuizResultScreen({Key? key, required this.category, required this.correct, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double percent = total == 0 ? 0 : (correct / total);
    final bool passed = percent >= 0.7;

    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                passed ? '🏆' : '🧘',
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 24),
              Text(
                passed ? 'Congratulations!' : 'Keep Learning!',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              const SizedBox(height: 12),
              Text(
                'You completed the $category quiz.',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: Column(
                  children: [
                    const Text('SCORE', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      '$correct / $total',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: passed ? Colors.green : Colors.orange,
                      ),
                    ),
                    Text(
                      '${(percent * 100).round()}% Accuracy',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Back to Quizzes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
