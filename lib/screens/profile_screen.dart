import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'dashboard_screen.dart';
import 'saved_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Your Profile 🙏', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange.shade800,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Visual Avatar & Profile summary card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.orange,
                    child: Text('ॐ', style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sadhaka (Seeker)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Learning Level: ${appState.settings.learningLevel}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Link to Progress Dashboard
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.assessment, color: Colors.orange),
              title: const Text('Progress Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('View XP, quiz accuracy, and unlocked badges'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
              },
            ),
          ),
          const SizedBox(height: 10),

          // Link to Bookmarks Saved screen
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.bookmark, color: Colors.orange),
              title: const Text('Saved Lessons & Bookmarks', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${appState.bookmarkedLessonIds.length} saved lessons/topics'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedScreen()));
              },
            ),
          ),
          const SizedBox(height: 10),

          // Link to Settings Screen Settings screen
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.settings, color: Colors.orange),
              title: const Text('Application Settings', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Adjust language, font sizes, notifications'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
