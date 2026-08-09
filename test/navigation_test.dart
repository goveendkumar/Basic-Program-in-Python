import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:app/state/app_state.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/screens/onboarding_screen.dart';
import 'package:app/screens/home_screen.dart';

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
  testWidgets('Splash Screen displays Title and triggers Timeout', (WidgetTester tester) async {
    bool timeoutTriggered = false;
    await tester.pumpWidget(
      MaterialApp(
        home: SplashScreen(
          onTimeout: () {
            timeoutTriggered = true;
          },
        ),
      ),
    );

    expect(find.text('Hindu Dharma Learning'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(timeoutTriggered, true);
  });

  testWidgets('Onboarding Screen can select languages, levels and complete', (WidgetTester tester) async {
    bool finishedOnboarding = false;

    await tester.pumpWidget(
      MockStateWrapper(
        child: MaterialApp(
          home: OnboardingScreen(
            onFinish: () {
              finishedOnboarding = true;
            },
          ),
        ),
      ),
    );

    // Initial Screen
    expect(find.text('Learn Hindu Dharma'), findsOneWidget);

    // Skip to the end
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('Stories, Quizzes & Flashcards'), findsOneWidget);

    // Choose English & Beginner
    await tester.tap(find.text('English'));
    await tester.tap(find.text('Beginner'));
    await tester.pumpAndSettle();

    // Click finish
    await tester.tap(find.text('START LEARNING 🚩'));
    await tester.pumpAndSettle();

    expect(finishedOnboarding, true);
  });

  testWidgets('Home Screen renders Namaste and Daily Learning section', (WidgetTester tester) async {
    await tester.pumpWidget(
      MockStateWrapper(
        child: MaterialApp(
          home: HomeScreen(
            navigateToTab: (index) {},
          ),
        ),
      ),
    );

    expect(find.text('Namaste 🙏'), findsOneWidget);
    expect(find.text('DAILY LEARNING ⏳'), findsOneWidget);
    expect(find.text('Concept of Karma'), findsOneWidget);
  });
}
