import 'package:flutter_test/flutter_test.dart';
import 'package:app/data/content_database.dart';

void main() {
  group('Content Database Tests', () {
    test('Ensure lessons are populated and accessible', () {
      expect(ContentDatabase.lessons.isNotEmpty, true);
      final first = ContentDatabase.lessons.first;
      expect(first.id, 'intro_what_is_hindu_dharma');
      expect(first.title, 'What is Hindu Dharma?');
      expect(first.category, 'Introduction');
      expect(first.level, 'Beginner');
      expect(first.quizQuestions.isNotEmpty, true);
    });

    test('Ensure scriptures are populated', () {
      expect(ContentDatabase.scriptures.isNotEmpty, true);
      expect(ContentDatabase.scriptures.any((s) => s.type == 'Vedas'), true);
    });

    test('Ensure all 18 Bhagavad Gita chapters exist', () {
      expect(ContentDatabase.gitaChapters.length, 18);
      expect(ContentDatabase.gitaChapters[0]['number'], 1);
      expect(ContentDatabase.gitaChapters[17]['number'], 18);
      expect(ContentDatabase.gitaChapters[1]['sanskritName'], 'Sankhya Yoga');
    });

    test('Ensure dictionary is large enough', () {
      expect(ContentDatabase.dictionary.length >= 20, true);
      expect(ContentDatabase.dictionary.any((d) => d.term == 'Ahimsa'), true);
      expect(ContentDatabase.dictionary.any((d) => d.term == 'Tamas'), true);
    });

    test('Ensure deities and timelines are correct', () {
      expect(ContentDatabase.deities.length, 3);
      expect(ContentDatabase.ramayanaTimeline.length, 6);
      expect(ContentDatabase.mahabharataTimeline.length, 6);
      expect(ContentDatabase.avatars.length, 10);
      expect(ContentDatabase.philosophies.length, 6);
      expect(ContentDatabase.vedantaComparison.length, 3);
    });
  });
}
