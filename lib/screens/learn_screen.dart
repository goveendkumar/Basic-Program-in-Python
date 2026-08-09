import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';
import 'lesson_detail_screen.dart';
import 'dictionary_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;

    // Direct lists of topics
    final categories = [
      {'title': 'Core Concepts', 'desc': 'Learn Dharma, Karma, Atman, Brahman etc.', 'icon': '🔑', 'action': () => _showConcepts(context, appState)},
      {'title': 'Deities & Traditions', 'desc': 'Explore Vaishnavism, Shaivism, Shaktism deities.', 'icon': '🔱', 'action': () => _showDeities(context, isDark)},
      {'title': 'Ten Avatars (Dashavatara)', 'desc': 'Study Matsya, Kurma, Varaha, Narasimha, Rama, Krishna.', 'icon': '🧜‍♂️', 'action': () => _showAvatars(context, isDark)},
      {'title': 'Yoga & Spiritual Paths', 'desc': 'Karma, Jnana, Bhakti, and Dhyana / Raja Yoga.', 'icon': '🧘', 'action': () => _showYogaPaths(context, isDark)},
      {'title': 'Festivals & Practices', 'desc': 'Puja, Aarti, Diwali, Holi, Navratri celebrations.', 'icon': '🏮', 'action': () => _showFestivalsAndPractices(context, isDark)},
      {'title': 'Hindu Philosophy & Vedanta', 'desc': '6 classical schools, Advaita vs Dvaita Vedanta.', 'icon': '⚛️', 'action': () => _showPhilosophies(context, isDark)},
      {'title': 'Dharma Dictionary', 'desc': 'Browse 20+ terms alphabetically with simple meanings.', 'icon': '📖', 'action': () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DictionaryScreen()))},
    ];

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Dharma Curriculum 🚩', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange.shade800,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, idx) {
          final cat = categories[idx];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(cat['icon'] as String, style: const TextStyle(fontSize: 24))),
              ),
              title: Text(
                cat['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(cat['desc'] as String, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.orange),
              onTap: cat['action'] as VoidCallback,
            ),
          );
        },
      ),
    );
  }

  void _showConcepts(BuildContext context, AppState state) {
    // Navigate to Core Concepts lessons list
    final concepts = ContentDatabase.lessons.where((l) => l.category == 'Core Concepts').toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Core Concepts 🔑'), backgroundColor: Colors.orange.shade800),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: concepts.length,
            itemBuilder: (c, idx) {
              final lesson = concepts[idx];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Text('🔑', style: TextStyle(fontSize: 24)),
                  title: Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Level: ${lesson.level}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.orange),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson)));
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showDeities(BuildContext context, bool isDark) {
    final list = ContentDatabase.deities;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Deities & Traditions 🔱'), backgroundColor: Colors.orange.shade800),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (c, idx) {
              final item = list[idx];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Text('🔱', style: TextStyle(fontSize: 28)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text('Tradition: ${item['category']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(height: 20),
                      Text('Who is this Deity?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange.shade800)),
                      Text(item['whoIs'] as String, style: const TextStyle(fontSize: 13)),
                      const SizedBox(height: 8),
                      Text('Symbols:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange.shade800)),
                      Text(item['symbols'] as String, style: const TextStyle(fontSize: 13)),
                      const SizedBox(height: 8),
                      Text('Traditional Significance:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange.shade800)),
                      Text(item['keyPoints'] as String, style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showAvatars(BuildContext context, bool isDark) {
    final list = ContentDatabase.avatars;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Ten Avatars (Dashavatara) 🧜‍♂️'), backgroundColor: Colors.orange.shade800),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (c, idx) {
              final item = list[idx];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade800,
                    foregroundColor: Colors.white,
                    child: Text('${item['number']}'),
                  ),
                  title: Text('${item['name']} (${item['form']})', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item['story'] as String, style: const TextStyle(fontSize: 12)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showYogaPaths(BuildContext context, bool isDark) {
    final paths = [
      {'title': 'Karma Yoga', 'desc': 'Path of Selfless Work. Doing your duties without attachment to rewards, offering all fruits to the Divine.', 'symbol': '⚡'},
      {'title': 'Jnana Yoga', 'desc': 'Path of Wisdom. Discriminating between the temporary physical world and the eternal Atman/soul.', 'symbol': '📖'},
      {'title': 'Bhakti Yoga', 'desc': 'Path of Devotion. Connecting with God through pure unconditional love, singing, and prayer.', 'symbol': '❤️'},
      {'title': 'Raja / Dhyana Yoga', 'desc': 'Path of Meditation. Controlling mental modifications through breathing exercises, focus, and stillness.', 'symbol': '🧘'},
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Yoga & Spiritual Paths 🧘'), backgroundColor: Colors.orange.shade800),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: paths.length,
            itemBuilder: (c, idx) {
              final p = paths[idx];
              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p['symbol']!, style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p['title']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown)),
                            const SizedBox(height: 6),
                            Text(p['desc']!, style: const TextStyle(fontSize: 13, height: 1.4)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showFestivalsAndPractices(BuildContext context, bool isDark) {
    final list = [
      {'title': 'Diwali (Deepavali)', 'desc': 'Festival of Lights celebrating Rama\'s return to Ayodhya and victory of light over darkness.', 'type': 'Festival', 'icon': '🏮'},
      {'title': 'Holi', 'desc': 'Festival of Colors representing spring, joy, and the victory of devotee Prahlada over demonic forces.', 'type': 'Festival', 'icon': '🎨'},
      {'title': 'Puja & Aarti', 'desc': 'Grateful ceremony offering flowers, pure water, food, and lights to represent elements of nature.', 'type': 'Practice', 'icon': '🔥'},
      {'title': 'Seva (Selfless service)', 'desc': 'Serving community, helping poor, cleaning shrines with no expectation of reward.', 'type': 'Practice', 'icon': '🤝'},
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Festivals & Practices 🏮'), backgroundColor: Colors.orange.shade800),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (c, idx) {
              final item = list[idx];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Text(item['icon']!, style: const TextStyle(fontSize: 28)),
                  title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item['desc']!, style: const TextStyle(fontSize: 12)),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(8)),
                    child: Text(item['type']!, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.orange)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showPhilosophies(BuildContext context, bool isDark) {
    final list = ContentDatabase.philosophies;
    final vedanta = ContentDatabase.vedantaComparison;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Philosophy & Vedanta ⚛️'), backgroundColor: Colors.orange.shade800),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('SIX CLASSICAL SCHOOLS (SHAD-DARSHAN)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueGrey)),
                const SizedBox(height: 12),
                ...list.map((ph) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.star, color: Colors.orange),
                      title: Text('${ph['name']} (Founder: ${ph['founder']})', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(ph['ideas'] as String, style: const TextStyle(fontSize: 12)),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 24),
                const Text('VEDANTA COMPARISON TABLE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueGrey)),
                const SizedBox(height: 12),
                ...vedanta.map((vd) {
                  return Card(
                    color: Colors.orange.shade50,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.orange)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(vd['school']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown)),
                          const SizedBox(height: 4),
                          Text('Major Proponent: ${vd['thinker']}', style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
                          const Divider(),
                          Text('View of God: ${vd['viewOfBrahman']}', style: const TextStyle(fontSize: 12)),
                          const SizedBox(height: 4),
                          Text('Soul Connection: ${vd['relationship']}', style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
