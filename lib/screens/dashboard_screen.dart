import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;
    final fontSize = appState.settings.fontSize;

    // Compute progress percentages
    final totalLessons = ContentDatabase.lessons.length;
    final completedLessonsCount = appState.progress.completedLessons.length;
    final lessonsProgress = totalLessons == 0 ? 0.0 : (completedLessonsCount / totalLessons);

    final completedQuizzesCount = appState.progress.completedQuizzes.length;
    final totalQuizzes = 4; // Mock standard quizzes

    final int accuracy = appState.progress.quizTotalCount == 0
        ? 0
        : ((appState.progress.quizCorrectCount / appState.progress.quizTotalCount) * 100).round();

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Your Progress 📈', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange.shade800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Overall level/streak summary Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: isDark ? Colors.grey.shade800 : Colors.orange.shade800,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: Text('🧘', style: TextStyle(fontSize: 36)),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Dharma Explorer',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'LEVEL: ${appState.settings.learningLevel.toUpperCase()}',
                      style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                    ),
                    const Divider(color: Colors.white30, height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryItem('✨ XP', '${appState.progress.xp}'),
                        _buildSummaryItem('🔥 STREAK', '${appState.progress.streak} days'),
                        _buildSummaryItem('🎯 ACCURACY', '$accuracy%'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Progress Indicators Group
            Text(
              'COURSE COMPLETION PROGRESS',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800, letterSpacing: 1.1),
            ),
            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProgressRow(
                      'Beginner Lessons',
                      completedLessonsCount,
                      totalLessons,
                      lessonsProgress,
                      Colors.green,
                    ),
                    const Divider(height: 24),
                    _buildProgressRow(
                      'Interactive Quizzes',
                      completedQuizzesCount,
                      totalQuizzes,
                      completedQuizzesCount / totalQuizzes,
                      Colors.blue,
                    ),
                    const Divider(height: 24),
                    _buildProgressRow(
                      'Gita Chapters Read',
                      appState.progress.completedLessons.where((id) => id.contains('gita_chapter')).length,
                      18,
                      appState.progress.completedLessons.where((id) => id.contains('gita_chapter')).length / 18,
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Badges Achievement List
            Text(
              'UNLOCKED BADGES & ACHIEVEMENTS',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800, letterSpacing: 1.1),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: appState.badges.length,
              itemBuilder: (context, idx) {
                final badge = appState.badges[idx];
                final isUnlocked = badge.unlocked;

                return Card(
                  color: isUnlocked ? Colors.white : Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isUnlocked ? Colors.orange : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: isUnlocked ? 1.0 : 0.35,
                          child: Text(
                            badge.icon,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          badge.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: isUnlocked ? Colors.brown.shade800 : Colors.grey,
                          ),
                        ),
                        Text(
                          badge.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String val) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildProgressRow(String label, int current, int total, double percent, Color color) {
    final double safePercent = percent.clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text('$current / $total', style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: safePercent,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
