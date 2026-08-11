import 'package:flutter_test/flutter_test.dart';
import 'package:app/data/content_database.dart';

void main() {
  group('Content Database Multilingual Tests', () {
    test('Ensure lessons are populated and accessible in all 4 languages', () {
      expect(ContentDatabase.lessons.isNotEmpty, true);
      final first = ContentDatabase.lessons.first;
      expect(first.id, 'intro_what_is_hindu_dharma');

      // Verify multilingual titles exist
      expect(first.getLocalizedTitle('English'), 'What is Hindu Dharma?');
      expect(first.getLocalizedTitle('Roman English'), 'Hindu Dharma kya hai?');
      expect(first.getLocalizedTitle('Urdu'), 'ہندو دھرم کیا ہے؟');
      expect(first.getLocalizedTitle('Sindhi'), 'هندو دھرم ڇا آهي؟');

      // Verify content translations
      expect(first.getLocalizedContent('Urdu').contains('روایتی'), true);
      expect(first.getLocalizedContent('Sindhi').contains('روحاني'), true);
    });

    test('Ensure scriptures support languages', () {
      expect(ContentDatabase.scriptures.isNotEmpty, true);
      final first = ContentDatabase.scriptures.first;
      expect(first.getLocalizedTitle('Urdu'), 'چار وید');
      expect(first.getLocalizedTitle('Sindhi'), 'چار ويد');
    });

    test('Ensure Gita chapters are correct', () {
      expect(ContentDatabase.gitaChapters.isNotEmpty, true);
      final ch = ContentDatabase.gitaChapters.first;
      expect(ch['number'], 1);
      expect(ch['titleTranslations']['Urdu'], 'ارجن کا دکھ');
    });

    test('Ensure dictionary holds translated terms', () {
      expect(ContentDatabase.dictionary.isNotEmpty, true);
      final entry = ContentDatabase.dictionary.firstWhere((d) => d.term == 'Dharma');
      expect(entry.getLocalizedDefinition('Urdu').contains('سچائی'), true);
    });
  });
}
