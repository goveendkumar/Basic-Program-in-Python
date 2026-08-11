import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:app/state/app_state.dart';
import 'package:app/screens/quiz_categories_screen.dart';
import 'package:app/screens/flashcards_screen.dart';
import 'package:app/screens/dictionary_screen.dart';
import 'package:app/screens/search_screen.dart';

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
  testWidgets('QuizCategoriesScreen renders statistics and list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MockStateWrapper(
        child: const MaterialApp(
          home: QuizCategoriesScreen(),
        ),
      ),
    );

    expect(find.text('Interactive Quizzes 🏆'), findsOneWidget);
    expect(find.text('Your Quiz Accuracy'), findsOneWidget);
    expect(find.text('Introduction'), findsOneWidget);
    expect(find.text('Core Concepts'), findsOneWidget);
  });

  testWidgets('FlashcardsScreen displays first flashcard and flipping works', (WidgetTester tester) async {
    await tester.pumpWidget(
      MockStateWrapper(
        child: const MaterialApp(
          home: FlashcardsScreen(),
        ),
      ),
    );

    expect(find.text('Spiritual Flashcards 📇'), findsOneWidget);
    expect(find.text('FRONT - SPIRITUAL CONCEPT'), findsOneWidget);

    // Tap to flip card
    await tester.tap(find.text('FRONT - SPIRITUAL CONCEPT'));
    await tester.pumpAndSettle();

    expect(find.text('BACK - DEFINITION & DETAILS'), findsOneWidget);
  });

  testWidgets('DictionaryScreen renders alphabetical list and searches', (WidgetTester tester) async {
    await tester.pumpWidget(
      MockStateWrapper(
        child: const MaterialApp(
          home: DictionaryScreen(),
        ),
      ),
    );

    expect(find.text('Dharma Dictionary 📖'), findsOneWidget);
    expect(find.text('Dharma'), findsWidgets);

    // Filter search query
    await tester.enterText(find.byType(TextField), 'Dharma');
    await tester.pumpAndSettle();

    expect(find.text('Dharma'), findsWidgets);
  });

  testWidgets('SearchScreen queries elements dynamically', (WidgetTester tester) async {
    await tester.pumpWidget(
      MockStateWrapper(
        child: const MaterialApp(
          home: SearchScreen(),
        ),
      ),
    );

    expect(find.text('Global Search 🔍'), findsOneWidget);
    expect(find.text('Type something to search...'), findsOneWidget);

    // Search query for Karma
    await tester.enterText(find.byType(TextField), 'Karma');
    await tester.pumpAndSettle();

    expect(find.text('Concept of Karma'), findsWidgets);
    expect(find.text('Open'), findsWidgets);
  });
}
