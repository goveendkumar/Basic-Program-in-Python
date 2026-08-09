import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/widgets/educational_diagrams.dart';

void main() {
  group('Educational Diagrams Test', () {
    testWidgets('Verify diagrams render correct subcomponents', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  EducationalDiagram(diagramType: 'Samsara'),
                  EducationalDiagram(diagramType: 'Karma'),
                  EducationalDiagram(diagramType: 'Dharma'),
                  EducationalDiagram(diagramType: 'Moksha'),
                  EducationalDiagram(diagramType: 'Yoga'),
                  EducationalDiagram(diagramType: 'Gunas'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('SAMSARA CYCLE DIAGRAM'), findsOneWidget);
      expect(find.text('KARMA CAUSE & EFFECT LOOP'), findsOneWidget);
      expect(find.text('DHARMA COHESION PATHWAY'), findsOneWidget);
      expect(find.text('MOKSHA LIBERATION FLOW'), findsOneWidget);
      expect(find.text('FOUR YOGA PATHWAYS'), findsOneWidget);
      expect(find.text('THE THREE GUNAS (MODES OF NATURE)'), findsOneWidget);
    });
  });
}
