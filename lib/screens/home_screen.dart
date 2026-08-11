import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';
import '../widgets/language_toggle_bar.dart';
import 'lesson_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) navigateToTab;

  const HomeScreen({Key? key, required this.navigateToTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;
    final lang = appState.settings.language;

    // Filter relevant introductory lessons
    final List<Lesson> introLessons = ContentDatabase.lessons
        .where((l) => l.category == 'Introduction')
        .toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF9F0),
      body: CustomScrollView(
        slivers: [
          // Elegant Header
          SliverAppBar(
            expandedHeight: 160.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF8B1A1A), // Deep Maroon
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Center(child: LanguageToggleBar()),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'SANATAN PATH 🙏',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black45, offset: Offset(1, 1))],
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8B1A1A), Color(0xFFFF6B00)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Opacity(
                      opacity: 0.15,
                      child: Text('ॐ', style: TextStyle(fontSize: 120, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Subtitle
                  Text(
                    'Learn Hindu Dharma step by step.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF8B1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Streak & XP Dashboard Widget
                  _buildDashboardCard(context, appState),

                  const SizedBox(height: 24),

                  // Continue Learning Lesson / Daily Learning Feature
                  _buildDailyLearningSection(context, appState),

                  const SizedBox(height: 24),

                  // Quick Category Navigation Cards
                  Text(
                    'EXPLORE TOPICS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: isDark ? Colors.white70 : const Color(0xFF6B4F3C),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildTopicGrid(context),

                  const SizedBox(height: 24),

                  // Intro lessons list
                  Text(
                    'HINDU DHARMA INTRODUCTION',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: isDark ? Colors.white70 : const Color(0xFF6B4F3C),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Column(
                    children: introLessons.map((lesson) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        color: isDark ? Colors.grey.shade800 : Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFF9F0),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text('🕉️', style: TextStyle(fontSize: 24)),
                            ),
                          ),
                          title: Text(
                            lesson.getLocalizedTitle(lang),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: isDark ? Colors.white : const Color(0xFF2D1B0E),
                            ),
                          ),
                          subtitle: Text(
                            'Level: ${lesson.level} | ${lesson.category}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white60 : const Color(0xFF6B4F3C),
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFFF6B00)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LessonDetailScreen(lesson: lesson),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, AppState state) {
    final isDark = state.settings.isDarkMode;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? Colors.grey.shade800 : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text('🔥', style: TextStyle(fontSize: 28)),
                const SizedBox(height: 4),
                Text(
                  '${state.progress.streak} Day Streak',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : const Color(0xFF2D1B0E)),
                ),
              ],
            ),
            Container(height: 40, width: 1, color: const Color(0xFFD4AF37)),
            Column(
              children: [
                const Text('✨', style: TextStyle(fontSize: 28)),
                const SizedBox(height: 4),
                Text(
                  '${state.progress.xp} Total XP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : const Color(0xFF2D1B0E)),
                ),
              ],
            ),
            Container(height: 40, width: 1, color: const Color(0xFFD4AF37)),
            Column(
              children: [
                const Text('🎓', style: TextStyle(fontSize: 28)),
                const SizedBox(height: 4),
                Text(
                  state.settings.learningLevel,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFFF6B00)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyLearningSection(BuildContext context, AppState state) {
    final isDark = state.settings.isDarkMode;
    final lang = state.settings.language;
    // We grab 'Concept of Karma' as the daily lesson
    final dailyLesson = ContentDatabase.lessons.firstWhere(
      (l) => l.id == 'core_karma',
      orElse: () => ContentDatabase.lessons.first,
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFFF6B00), width: 1.5),
      ),
      color: isDark ? Colors.grey.shade800 : const Color(0xFFFFF9F0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B00),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'DAILY LEARNING ⏳',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text('Reading Time: 5 mins', style: TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              dailyLesson.getLocalizedTitle(lang),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF8B1A1A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              dailyLesson.getLocalizedSimpleExplanation(lang),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white70 : const Color(0xFF2D1B0E),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LessonDetailScreen(lesson: dailyLesson),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B00),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Start Learning Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicGrid(BuildContext context) {
    final topics = [
      {'title': 'Sacred Texts', 'icon': '📖', 'tab': 2},
      {'title': 'Bhagavad Gita', 'icon': '☸️', 'tab': 2},
      {'title': 'Ramayana', 'icon': '🏹', 'tab': 2},
      {'title': 'Core Concepts', 'icon': '🔑', 'tab': 1},
      {'title': 'Deities & Traditions', 'icon': '🔱', 'tab': 1},
      {'title': 'Interactive Quizzes', 'icon': '🏆', 'tab': 3},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: topics.length,
      itemBuilder: (context, idx) {
        final t = topics[idx];
        return InkWell(
          onTap: () {
            navigateToTab(t['tab'] as int);
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(t['icon'] as String, style: const TextStyle(fontSize: 28)),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    t['title'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
