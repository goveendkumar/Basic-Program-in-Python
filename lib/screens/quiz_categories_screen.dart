import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';
import '../widgets/language_toggle_bar.dart';
import 'quiz_play_screen.dart';

class QuizCategoriesScreen extends StatelessWidget {
  const QuizCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;

    // Gather unique quiz categories from all lessons
    final categories = [
      {'name': 'Introduction', 'icon': '🙏', 'desc': 'Foundations and history of Sanatana Dharma.'},
      {'name': 'Core Concepts', 'icon': '🔑', 'desc': 'Dharma, Karma, Atman, Brahman, Samsara.'},
      {'name': 'Bhagavad Gita', 'icon': '☸️', 'desc': 'Chapters and dialogue of Arjuna & Krishna.'},
      {'name': 'Sacred Texts', 'icon': '📖', 'desc': 'Vedas, Upanishads, and the Puranas.'},
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF9F0),
      appBar: AppBar(
        title: const Text('Interactive Quizzes 🏆', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: const Color(0xFF8B1A1A), // Deep Maroon
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(child: LanguageToggleBar()),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header stats
            Card(
              color: const Color(0xFFFFF9F0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFFF6B00)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Text('📊', style: TextStyle(fontSize: 40)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Quiz Accuracy',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF8B1A1A)),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Completed Quizzes: ${appState.progress.completedQuizzes.length}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Accuracy: ${stateAccuracy(appState)}%',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFFF6B00)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'CHOOSE A CATEGORY TO BEGIN',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey, letterSpacing: 1.1),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, idx) {
                final cat = categories[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF9F0),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: Text(cat['icon']!, style: const TextStyle(fontSize: 24))),
                    ),
                    title: Text(
                      cat['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(cat['desc']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                    trailing: const Icon(Icons.play_circle_fill, color: Color(0xFFFF6B00), size: 32),
                    onTap: () {
                      // Retrieve category questions
                      final questions = _getQuestionsForCategory(cat['name']!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizPlayScreen(
                            category: cat['name']!,
                            questions: questions,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  int stateAccuracy(AppState state) {
    if (state.progress.quizTotalCount == 0) return 0;
    return ((state.progress.quizCorrectCount / state.progress.quizTotalCount) * 100).round();
  }

  List<QuizQuestion> _getQuestionsForCategory(String category) {
    final List<QuizQuestion> list = [];
    for (var l in ContentDatabase.lessons) {
      if (l.category == category) {
        list.addAll(l.quizQuestions);
      }
    }

    // Fallbacks if list is empty for specific categories
    if (list.isEmpty) {
      list.add(
        QuizQuestion(
          id: 'fb_1',
          category: category,
          type: QuizType.multipleChoice,
          questionTranslations: {'English': 'What is the core pillar of Hindu life?'},
          optionsTranslations: {'English': ['Dharma', 'Water', 'Salt', 'Sorrow']},
          correctAnswerTranslations: {'English': 'Dharma'},
          explanationTranslations: {'English': 'Dharma represents the cosmic order and righteous duty which supports life.'},
          difficulty: 'Beginner',
        ),
      );
    }
    return list;
  }
}
