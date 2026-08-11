import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../widgets/educational_diagrams.dart';
import '../widgets/language_toggle_bar.dart';
import '../data/content_database.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  int? _selectedQuizAnswerIdx;
  bool _quizSubmitted = false;
  bool _quizCorrect = false;

  int _currentFlashcardIdx = 0;
  bool _flashcardFlipped = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;
    final lang = appState.settings.language;
    final fontSize = appState.settings.fontSize;

    final lesson = widget.lesson;

    // Retrieve related lessons
    final nextLesson = ContentDatabase.lessons.firstWhere(
      (l) => l.category == lesson.category && l.id != lesson.id,
      orElse: () => lesson,
    );

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF9F0),
      appBar: AppBar(
        title: Text(lesson.getLocalizedTitle(lang), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: const Color(0xFF8B1A1A), // Deep Maroon
        actions: [
          IconButton(
            icon: Icon(
              appState.bookmarkedLessonIds.contains(lesson.id) ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
            ),
            onPressed: () {
              appState.toggleBookmarkLesson(lesson.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(appState.bookmarkedLessonIds.contains(lesson.id)
                      ? 'Lesson Bookmarked!'
                      : 'Bookmark Removed!'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Language pill toggle inside lesson body
              const Center(child: LanguageToggleBar()),
              const SizedBox(height: 16),

              // 2. Relevant Image / Illustration
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF8B1A1A), Color(0xFFFF6B00)], // Maroon to Saffron
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _getVisualIcon(lesson.imageUrl),
                              style: const TextStyle(fontSize: 64),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'VISUAL ILLUSTRATION',
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.grey.shade100,
                      width: double.infinity,
                      child: Text(
                        lesson.imageCaption,
                        style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 3. Title and Level tag
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      lesson.getLocalizedTitle(lang),
                      style: TextStyle(
                        fontSize: fontSize + 4,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF8B1A1A),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getLevelColor(lesson.level),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      lesson.level,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 4. Short Introduction & Explanation
              Text(
                lesson.getLocalizedContent(lang),
                style: TextStyle(
                  fontSize: fontSize,
                  color: isDark ? Colors.white70 : const Color(0xFF2D1B0E),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 16),

              // 5. Visual Diagram component
              if (lesson.visualDiagramType != null) ...[
                EducationalDiagram(diagramType: lesson.visualDiagramType),
                const SizedBox(height: 16),
              ],

              // 6. Easy Real-Life Example card
              Card(
                color: isDark ? Colors.grey.shade800 : const Color(0xFFFFF9F0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFD4AF37), width: 1.5),
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
                            'EASY REAL-LIFE EXAMPLE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isDark ? const Color(0xFFD4AF37) : const Color(0xFFFF6B00),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        lesson.getLocalizedExample(lang),
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

              const SizedBox(height: 16),

              // 7. Deeper Explanation
              Text(
                'Deeper Study & Insights',
                style: TextStyle(
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF8B1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                lesson.getLocalizedDeeperExplanation(lang),
                style: TextStyle(
                  fontSize: fontSize,
                  color: isDark ? Colors.white70 : const Color(0xFF2D1B0E),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 16),

              // 8. Key Points Checklist
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
                      '📌 KEY LEARNING POINTS',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 10),
                    ...lesson.getLocalizedKeyPoints(lang).map((pt) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                pt,
                                style: TextStyle(fontSize: fontSize - 1, color: isDark ? Colors.white70 : const Color(0xFF2D1B0E)),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 9. Scripture & Source references
              if (lesson.sources.isNotEmpty) ...[
                Row(
                  children: [
                    const Icon(Icons.menu_book, color: Color(0xFFFF6B00), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Scripture / Source Reference:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white70 : Colors.grey.shade700),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 26.0),
                  child: Text(
                    lesson.sources.join(', '),
                    style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFFFF6B00)),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // 10. Mini Lesson Quiz Question
              if (lesson.quizQuestions.isNotEmpty) ...[
                _buildMiniQuiz(context, isDark, fontSize, appState),
                const SizedBox(height: 16),
              ],

              // 11. Mini Lesson Flashcards
              if (lesson.flashcards.isNotEmpty) ...[
                _buildMiniFlashcard(context, isDark, fontSize, appState),
                const SizedBox(height: 16),
              ],

              const Divider(thickness: 1.5, color: Color(0xFFFF6B00)),
              const SizedBox(height: 12),

              // 12. Complete Lesson Action Button
              ElevatedButton.icon(
                onPressed: () {
                  appState.completeLesson(lesson.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('🎉 Lesson Completed! +50 XP Earned!')),
                  );
                },
                icon: const Icon(Icons.done_all, color: Colors.white),
                label: const Text('Mark Lesson Completed', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 24),

              // Navigation between previous and next lessons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson)),
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Reset view'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: nextLesson)),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next Lesson'),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B00)),
                  ),
                ],
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniQuiz(BuildContext context, bool isDark, double fontSize, AppState state) {
    final q = widget.lesson.quizQuestions.first;
    final lang = state.settings.language;
    final options = q.getLocalizedOptions(lang);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : const Color(0xFFFFF9F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFF6B00), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('❓', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              const Text(
                'LESSON QUIZ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFFF6B00)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(q.getLocalizedQuestion(lang), style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(options.length, (idx) {
            final opt = options[idx];
            Color optColor = Colors.grey.shade300;
            if (_quizSubmitted) {
              if (opt == q.getLocalizedCorrectAnswer(lang)) {
                optColor = Colors.green.shade200;
              } else if (_selectedQuizAnswerIdx == idx) {
                optColor = Colors.red.shade200;
              }
            } else if (_selectedQuizAnswerIdx == idx) {
              optColor = const Color(0xFFFF6B00).withOpacity(0.3);
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: _quizSubmitted
                    ? null
                    : () {
                        setState(() {
                          _selectedQuizAnswerIdx = idx;
                        });
                      },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: optColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Text(opt, style: const TextStyle(fontSize: 14)),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          if (!_quizSubmitted)
            ElevatedButton(
              onPressed: _selectedQuizAnswerIdx == null
                  ? null
                  : () {
                      final chosen = options[_selectedQuizAnswerIdx!];
                      final correct = chosen == q.getLocalizedCorrectAnswer(lang);
                      setState(() {
                        _quizSubmitted = true;
                        _quizCorrect = correct;
                      });
                      state.completeQuiz(q.id, correct ? 1 : 0, 1);
                    },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B00)),
              child: const Text('Submit Answer', style: TextStyle(color: Colors.white)),
            ),
          if (_quizSubmitted) ...[
            const SizedBox(height: 8),
            Text(
              _quizCorrect ? '✅ Correct!' : '❌ Incorrect!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: _quizCorrect ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              q.getLocalizedExplanation(lang),
              style: TextStyle(fontSize: fontSize - 1, color: isDark ? Colors.white70 : Colors.black87),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMiniFlashcard(BuildContext context, bool isDark, double fontSize, AppState state) {
    final fc = widget.lesson.flashcards[_currentFlashcardIdx];
    final lang = state.settings.language;
    final isLearned = state.learnedFlashcardIds.contains(fc.id);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : const Color(0xFFFFF9F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('📇', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  const Text(
                    'LESSON FLASHCARD',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF8B1A1A)),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  state.bookmarkedFlashcardIds.contains(fc.id) ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () => state.toggleBookmarkFlashcard(fc.id),
              )
            ],
          ),
          const SizedBox(height: 8),

          // Flip card core
          InkWell(
            onTap: () {
              setState(() {
                _flashcardFlipped = !_flashcardFlipped;
              });
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFF6B00).withOpacity(0.2), width: 1),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _flashcardFlipped ? 'BACK (Explanation)' : 'FRONT (Concept)',
                        style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _flashcardFlipped ? fc.getLocalizedBack(lang) : fc.getLocalizedFront(lang),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontSize + 1,
                          fontWeight: FontWeight.bold,
                          color: _flashcardFlipped ? Colors.black87 : const Color(0xFFFF6B00),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _flashcardFlipped = !_flashcardFlipped;
                  });
                },
                child: const Text('🔄 Flip Card'),
              ),
              ElevatedButton(
                onPressed: () {
                  state.markFlashcardLearned(fc.id, !isLearned);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLearned ? Colors.green : Colors.grey,
                ),
                child: Text(isLearned ? '✓ Learned' : 'Mark Learned'),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _getVisualIcon(String url) {
    switch (url) {
      case 'OM_SYMBOL':
        return '🕉️';
      case 'SUN_TEMPLE':
        return '☀️';
      case 'DEITY_TRINITY':
        return '🔱';
      case 'SCALE_BALANCE':
        return '⚖️';
      case 'BOOMERANG':
        return '🪃';
      case 'DIVINE_SPARK':
        return '✨';
      case 'INFINITE_COSMOS':
        return '🌌';
      case 'SAMSARA_WHEEL':
        return '☸️';
      default:
        return '📖';
    }
  }

  Color _getLevelColor(String level) {
    if (level == 'Beginner') return Colors.green;
    if (level == 'Intermediate') return Colors.orange;
    return Colors.red;
  }
}
