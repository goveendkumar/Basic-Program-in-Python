import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';
import 'lesson_detail_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;

    // Gather bookmarked lessons
    final savedLessons = ContentDatabase.lessons
        .where((l) => appState.bookmarkedLessonIds.contains(l.id))
        .toList();

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Saved Bookmarks 🔖', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange.shade800,
      ),
      body: savedLessons.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🔖', style: TextStyle(fontSize: 64)),
                  SizedBox(height: 12),
                  Text('No Bookmarks Saved Yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                  SizedBox(height: 4),
                  Text('Bookmark lessons to review them offline.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: savedLessons.length,
              itemBuilder: (context, idx) {
                final lesson = savedLessons[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Text('🕉️', style: TextStyle(fontSize: 24)),
                    title: Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Category: ${lesson.category} | Level: ${lesson.level}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.orange),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson)),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
