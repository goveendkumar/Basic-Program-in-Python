import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:app/state/app_state.dart';
import 'package:app/data/content_database.dart';
import 'package:app/screens/lesson_detail_screen.dart';
import 'package:app/screens/scriptures_screen.dart';
import 'package:app/screens/gita_detail_screen.dart';

class MockStateWrapper extends StatefulWidget {
  final Widget child;
  const MockStateWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<MockStateWrapper> createState() => _MockStateWrapperState();
}

class _MockStateWrapperState extends State<MockStateWrapper> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: widget.child,
    );
  }
}

void main() {
  testWidgets('LessonDetailScreen renders full structure correctly', (WidgetTester tester) async {
    final lesson = ContentDatabase.lessons.firstWhere((l) => l.id == 'core_karma');

    await tester.pumpWidget(
      MockStateWrapper(
        child: MaterialApp(
          home: LessonDetailScreen(lesson: lesson),
        ),
      ),
    );

    // Should find title, level badge, content indicators
    expect(find.text('Concept of Karma'), findsWidgets);
    expect(find.text('Beginner'), findsOneWidget);
    expect(find.text('EASY REAL-LIFE EXAMPLE'), findsOneWidget);
    expect(find.text('LESSON QUIZ'), findsOneWidget);
    expect(find.text('LESSON FLASHCARD'), findsOneWidget);
  });

  testWidgets('ScripturesScreen tabs render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MockStateWrapper(
        child: const MaterialApp(
          home: ScripturesScreen(),
        ),
      ),
    );

    expect(find.text('Sacred Scriptures 📖'), findsOneWidget);
    expect(find.text('Arjuna Vishada Yoga'), findsOneWidget);
  });

  testWidgets('GitaDetailScreen renders chapter details', (WidgetTester tester) async {
    final chapter = ContentDatabase.gitaChapters.first;

    await tester.pumpWidget(
      MockStateWrapper(
        child: MaterialApp(
          home: GitaDetailScreen(chapter: chapter),
        ),
      ),
    );

    expect(find.text('Arjuna Vishada Yoga'), findsWidgets);
    expect(find.text('CHAPTER RECAP QUIZ'), findsOneWidget);
    expect(find.text('REAL-LIFE ANALOGY'), findsOneWidget);
  });
}
