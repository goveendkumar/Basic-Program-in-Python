import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';
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
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Interactive Quizzes 🏆', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange.shade800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header stats
            Card(
              color: Colors.orange.shade100,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.brown),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Completed Quizzes: ${appState.progress.completedQuizzes.length}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Accuracy: ${stateAccuracy(appState)}%',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
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
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
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
                    trailing: const Icon(Icons.play_circle_fill, color: Colors.orange, size: 32),
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
          question: 'What is the core pillar of Hindu life?',
          options: ['Dharma', 'Water', 'Salt', 'Sorrow'],
          correctAnswer: 'Dharma',
          explanation: 'Dharma represents the cosmic order and righteous duty which supports life.',
          difficulty: 'Beginner',
        ),
      );
    }
    return list;
  }
}
