import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:app/main.dart';
import 'package:app/state/app_state.dart';

void main() {
  testWidgets('Full HinduDharmaApp load test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: const HinduDharmaApp(),
      ),
    );

    // Should render the Splash Screen title initially
    expect(find.text('Hindu Dharma Learning'), findsOneWidget);

    // Let the Future.delayed complete to prevent pending timer error
    await tester.pump(const Duration(seconds: 2));
  });
}
