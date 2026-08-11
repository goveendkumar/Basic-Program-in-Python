import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';
import '../widgets/language_toggle_bar.dart';
import 'gita_detail_screen.dart';
import 'timeline_screen.dart';

class ScripturesScreen extends StatefulWidget {
  const ScripturesScreen({Key? key}) : super(key: key);

  @override
  State<ScripturesScreen> createState() => _ScripturesScreenState();
}

class _ScripturesScreenState extends State<ScripturesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF9F0),
      appBar: AppBar(
        title: const Text('Sacred Scriptures 📖', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: const Color(0xFF8B1A1A), // Deep Maroon
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(child: LanguageToggleBar()),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Bhagavad Gita'),
            Tab(text: 'Sacred Libraries'),
            Tab(text: 'Ramayana'),
            Tab(text: 'Mahabharata'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGitaTab(context, isDark, appState),
          _buildLibrariesTab(context, isDark, appState),
          _buildRamayanaTab(context, isDark, appState),
          _buildMahabharataTab(context, isDark, appState),
        ],
      ),
    );
  }

  Widget _buildGitaTab(BuildContext context, bool isDark, AppState state) {
    final lang = state.settings.language;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ContentDatabase.gitaChapters.length + 1,
      itemBuilder: (context, idx) {
        if (idx == 0) {
          return Card(
            color: const Color(0xFFFFF9F0),
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFFF6B00), width: 1.2),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text('☸️', style: TextStyle(fontSize: 40)),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Song of the Lord',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF8B1A1A)),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'The Bhagavad Gita is an 18-chapter dialogue between Lord Krishna and Arjuna on the battlefield of Kurukshetra, answering humanity\'s ultimate life questions.',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        final ch = ContentDatabase.gitaChapters[idx - 1];
        final String localizedName = (ch['titleTranslations'] as Map<String, String>)[lang] ?? ch['sanskritName'] as String;

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFFF6B00),
              foregroundColor: Colors.white,
              child: Text('${ch['number']}'),
            ),
            title: Text(
              localizedName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              ch['englishTitle'] as String,
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFFFF6B00)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GitaDetailScreen(chapter: ch),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLibrariesTab(BuildContext context, bool isDark, AppState state) {
    final libs = ContentDatabase.scriptures;
    final lang = state.settings.language;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: libs.length,
      itemBuilder: (context, idx) {
        final lib = libs[idx];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Text('📚', style: TextStyle(fontSize: 32)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lib.getLocalizedTitle(lang),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Category: ${lib.type}',
                            style: const TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  lib.getLocalizedDescription(lang),
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Key Philosophical Themes:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFFF6B00)),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: lib.themes.map((theme) {
                    return Chip(
                      backgroundColor: const Color(0xFFFFF9F0),
                      label: Text(
                        theme,
                        style: const TextStyle(fontSize: 10, color: Color(0xFF8B1A1A), fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                Text(
                  'Importance: ${lib.getLocalizedImportance(lang)}',
                  style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRamayanaTab(BuildContext context, bool isDark, AppState state) {
    return TimelineScreen(
      title: 'Ramayana Story Timeline 🏹',
      subtitle: 'Follow Rama\'s journey step-by-step through the majestic epic of righteousness.',
      steps: ContentDatabase.ramayanaTimeline,
      icon: '🏹',
    );
  }

  Widget _buildMahabharataTab(BuildContext context, bool isDark, AppState state) {
    return TimelineScreen(
      title: 'Mahabharata Epic Timeline ⚔️',
      subtitle: 'The grand saga of the Kuru clan, leading up to the great battlefield of Kurukshetra.',
      steps: ContentDatabase.mahabharataTimeline,
      icon: '⚔️',
    );
  }
}
