import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';
import '../widgets/language_toggle_bar.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;
    final lang = appState.settings.language;
    final fontSize = appState.settings.fontSize;

    // Filter and sort terms alphabetically
    final List<DictionaryEntry> entries = ContentDatabase.dictionary
        .where((d) => d.term.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList()
      ..sort((a, b) => a.term.compareTo(b.term));

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF9F0),
      appBar: AppBar(
        title: const Text('Dharma Dictionary 📖', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF8B1A1A), // Deep Maroon
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(child: LanguageToggleBar()),
          )
        ],
      ),
      body: Column(
        children: [
          // Search box
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Sanskrit terms...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFFF6B00)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: isDark ? Colors.grey.shade800 : Colors.white,
              ),
            ),
          ),

          // Entries list
          Expanded(
            child: entries.isEmpty
                ? const Center(child: Text('No terms found.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: entries.length,
                    itemBuilder: (context, idx) {
                      final entry = entries[idx];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFFF6B00).withOpacity(0.1),
                            child: Text(
                              entry.term.isNotEmpty ? entry.term[0].toUpperCase() : 'ॐ',
                              style: const TextStyle(color: Color(0xFFFF6B00), fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                            entry.term,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            entry.getLocalizedDefinition(lang),
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Detailed Explanation:',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF6B00), fontSize: 13),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    entry.getLocalizedDetailedExplanation(lang),
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Icon(Icons.menu_book, color: Color(0xFFFF6B00), size: 16),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Related Scripture: ${entry.relatedScripture}',
                                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.link, color: Color(0xFFFF6B00), size: 16),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Related Concepts: ${entry.relatedConcepts}',
                                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
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
