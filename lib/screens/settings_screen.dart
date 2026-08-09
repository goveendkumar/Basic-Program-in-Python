import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Settings ⚙️', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange.shade800,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Selection
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode, color: Colors.purple),
              title: const Text('Dark Mode Theme', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Toggle between dark and light screens'),
              value: appState.settings.isDarkMode,
              onChanged: (val) {
                appState.toggleTheme(val);
              },
            ),
          ),
          const SizedBox(height: 12),

          // Learning Language Selection Selection
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.translate, color: Colors.blue),
                title: const Text('Learning Language', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Current: ${appState.settings.language}'),
                trailing: DropdownButton<String>(
                  value: appState.settings.language,
                  onChanged: (String? val) {
                    if (val != null) {
                      appState.updateLanguage(val);
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: 'English', child: Text('English')),
                    DropdownMenuItem(value: 'Roman English', child: Text('Roman English')),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Level Selection Selection
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.grade, color: Colors.green),
                title: const Text('Learning Level', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Current: ${appState.settings.learningLevel}'),
                trailing: DropdownButton<String>(
                  value: appState.settings.learningLevel,
                  onChanged: (String? val) {
                    if (val != null) {
                      appState.updateLearningLevel(val);
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: 'Beginner', child: Text('Beginner')),
                    DropdownMenuItem(value: 'Intermediate', child: Text('Intermediate')),
                    DropdownMenuItem(value: 'Advanced', child: Text('Advanced')),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Text / Font Size Adjustment
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.format_size, color: Colors.orange),
                      SizedBox(width: 12),
                      Text('Adjust Font / Text Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    min: 12.0,
                    max: 24.0,
                    divisions: 6,
                    label: '${appState.settings.fontSize}',
                    value: appState.settings.fontSize,
                    onChanged: (val) {
                      appState.updateFontSize(val);
                    },
                  ),
                  Text(
                    'Sample Text: Truth is one, sages call it by many names.',
                    style: TextStyle(fontSize: appState.settings.fontSize, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Notification Toggle
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SwitchListTile(
              secondary: const Icon(Icons.notifications_active, color: Colors.orange),
              title: const Text('Daily Learning Reminders', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Send notification when daily lesson is ready'),
              value: appState.settings.notificationsEnabled,
              onChanged: (val) {
                appState.toggleNotifications(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}
