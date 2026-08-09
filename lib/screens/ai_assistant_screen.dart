import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';
import 'lesson_detail_screen.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({Key? key}) : super(key: key);

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _queryController = TextEditingController();
  final List<Map<String, dynamic>> _chatHistory = [
    {
      'role': 'assistant',
      'text': 'Namaste! 🙏 I am your personal Hindu Dharma tutor. Ask me any question, and I will explain using verified scriptures and offline lessons.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;
    final isEnglish = appState.settings.language == 'English';
    final fontSize = appState.settings.fontSize;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('AI Dharma Tutor 🤖', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Column(
        children: [
          // Info Banner
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.orange.shade50,
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.orange),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Note: This tutor answers based on verified scriptures and stored content to prevent inaccuracies.',
                    style: TextStyle(fontSize: 11, color: Colors.brown.shade900, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Messages list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _chatHistory.length,
              itemBuilder: (context, idx) {
                final msg = _chatHistory[idx];
                final isUser = msg['role'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? (isDark ? Colors.orange.shade900 : Colors.orange.shade200)
                          : (isDark ? Colors.grey.shade800 : Colors.white),
                      borderRadius: BorderRadius.circular(12).copyWith(
                        topRight: isUser ? Radius.zero : const Radius.circular(12),
                        topLeft: isUser ? const Radius.circular(12) : Radius.zero,
                      ),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isUser ? 'YOU 🧑' : 'DHARMA TUTOR 🤖',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: isUser
                                ? (isDark ? Colors.orange.shade200 : Colors.brown.shade900)
                                : Colors.orange.shade800,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          msg['text'] as String,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: isUser
                                ? (isDark ? Colors.white : Colors.black87)
                                : (isDark ? Colors.white70 : Colors.black87),
                          ),
                        ),
                        // Sources display
                        if (msg['sourceLesson'] != null) ...[
                          const Divider(height: 12),
                          Text(
                            'Based on: ${msg['sourceLesson']}',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          if (msg['sourceScripture'] != null)
                            Text(
                              'Source: ${msg['sourceScripture']}',
                              style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.orange),
                            ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LessonDetailScreen(lesson: msg['lessonObject'] as Lesson),
                                ),
                              );
                            },
                            icon: const Icon(Icons.menu_book, size: 14, color: Colors.white),
                            label: const Text('View Source Lesson', style: TextStyle(fontSize: 10, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade800,
                              minimumSize: const Size(0, 24),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Search / Ask input box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade900 : Colors.white,
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _queryController,
                    decoration: const InputDecoration(
                      hintText: 'Ask e.g. "What is Karma?" or "What is Atman?"',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (val) => _handleQuery(val),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.orange),
                  onPressed: () => _handleQuery(_queryController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleQuery(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      _chatHistory.add({
        'role': 'user',
        'text': query,
      });
    });

    _queryController.clear();

    // AI Logic: Retrieve stored offline content
    final qLower = query.toLowerCase();
    Lesson? foundLesson;

    for (var l in ContentDatabase.lessons) {
      if (qLower.contains(l.title.toLowerCase()) ||
          l.title.toLowerCase().contains(qLower) ||
          qLower.contains(l.id.replaceAll('_', ' '))) {
        foundLesson = l;
        break;
      }
    }

    // Try finding in dictionary as fallback
    if (foundLesson == null) {
      for (var entry in ContentDatabase.dictionary) {
        if (qLower.contains(entry.term.toLowerCase()) || entry.term.toLowerCase().contains(qLower)) {
          // Map dictionary term to corresponding lesson
          foundLesson = ContentDatabase.lessons.firstWhere(
            (l) => l.id == entry.relatedLessonId,
            orElse: () => ContentDatabase.lessons.first,
          );
          break;
        }
      }
    }

    // Add Simulated Assistant delay response
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        if (foundLesson != null) {
          _chatHistory.add({
            'role': 'assistant',
            'text': foundLesson!.simpleExplanation + '\n\n' + foundLesson!.deeperExplanation,
            'sourceLesson': foundLesson!.title,
            'sourceScripture': foundLesson!.sources.isNotEmpty ? foundLesson!.sources.first : 'Hindu Scriptures',
            'lessonObject': foundLesson,
          });
        } else {
          _chatHistory.add({
            'role': 'assistant',
            'text': "I don't have enough verified information about this topic in the current learning content.",
          });
        }
      });
    });
  }
}
