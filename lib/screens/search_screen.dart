import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';
import 'lesson_detail_screen.dart';
import 'gita_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;

    // Search results compilation
    final List<Map<String, dynamic>> results = [];

    if (_query.trim().isNotEmpty) {
      final qLower = _query.toLowerCase();

      // Search Lessons
      for (var l in ContentDatabase.lessons) {
        if (l.title.toLowerCase().contains(qLower) ||
            l.englishContent.toLowerCase().contains(qLower) ||
            l.category.toLowerCase().contains(qLower)) {
          results.add({
            'type': 'Lesson',
            'title': l.title,
            'category': l.category,
            'desc': l.simpleExplanation,
            'icon': '🕉️',
            'lesson': l,
          });
        }
      }

      // Search Gita Chapters
      for (var ch in ContentDatabase.gitaChapters) {
        if (ch['sanskritName'].toString().toLowerCase().contains(qLower) ||
            ch['englishTitle'].toString().toLowerCase().contains(qLower) ||
            ch['englishExplanation'].toString().toLowerCase().contains(qLower)) {
          results.add({
            'type': 'Gita Chapter',
            'title': '${ch['number']}. ${ch['sanskritName']}',
            'category': 'Bhagavad Gita',
            'desc': ch['englishTitle'],
            'icon': '☸️',
            'chapter': ch,
          });
        }
      }

      // Search Deities
      for (var d in ContentDatabase.deities) {
        if (d['name'].toString().toLowerCase().contains(qLower) ||
            d['whoIs'].toString().toLowerCase().contains(qLower)) {
          results.add({
            'type': 'Deity',
            'title': d['name'],
            'category': d['associatedTraditions'],
            'desc': d['whoIs'],
            'icon': '🔱',
          });
        }
      }
    }

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Global Search 🔍'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              autofocus: true,
              onChanged: (val) {
                setState(() {
                  _query = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search concepts, scriptures, chapters, deities...',
                prefixIcon: const Icon(Icons.search, color: Colors.orange),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: isDark ? Colors.grey.shade800 : Colors.white,
              ),
            ),
          ),
          Expanded(
            child: _query.trim().isEmpty
                ? const Center(child: Text('Type something to search...'))
                : results.isEmpty
                    ? const Center(child: Text('No results found.'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: results.length,
                        itemBuilder: (context, idx) {
                          final res = results[idx];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              leading: Text(res['icon'] as String, style: const TextStyle(fontSize: 28)),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      res['title'] as String,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      res['type'] as String,
                                      style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.orange),
                                    ),
                                  )
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Category: ${res['category']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Text(res['desc'] as String, maxLines: 2, overflow: TextOverflow.ellipsis),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  if (res['type'] == 'Lesson') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: res['lesson'] as Lesson)),
                                    );
                                  } else if (res['type'] == 'Gita Chapter') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => GitaDetailScreen(chapter: res['chapter'] as Map<String, dynamic>)),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Detail screen loading offline content...')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                                child: const Text('Open'),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
