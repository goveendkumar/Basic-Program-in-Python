import 'package:flutter_test/flutter_test.dart';
import 'package:app/models/models.dart';
import 'package:app/state/app_state.dart';

void main() {
  group('Models Unit Tests', () {
    test('Lesson instantiation and fields verification', () {
      final quiz = QuizQuestion(
        id: 'q1',
        category: 'Basics',
        type: QuizType.multipleChoice,
        questionTranslations: {'English': 'What is Dharma?'},
        optionsTranslations: {'English': ['Duty', 'Water', 'Air', 'Fire']},
        correctAnswerTranslations: {'English': 'Duty'},
        explanationTranslations: {'English': 'Dharma is right conduct or cosmic order.'},
        difficulty: 'Beginner',
      );

      final flashcard = Flashcard(
        id: 'fc1',
        category: 'Basics',
        imageUrl: '',
        frontTranslations: {'English': 'Dharma'},
        backTranslations: {'English': 'Righteous Duty'},
        explanationTranslations: {'English': 'Righteous action and conduct.'},
        exampleTranslations: {'English': 'Helping someone in need is Dharma.'},
        relatedConcept: 'Right conduct',
      );

      final lesson = Lesson(
        id: 'l1',
        title: 'Introduction to Dharma',
        category: 'Basics',
        level: 'Beginner',
        imageUrl: 'assets/dharma.png',
        imageCaption: 'Illustration of Dharma Wheel',
        titleTranslations: {'English': 'Introduction to Dharma', 'Urdu': 'دھرما کا تعارف'},
        contentTranslations: {'English': 'Dharma means righteousness.'},
        simpleExplanationTranslations: {'English': 'Righteous duty.'},
        exampleTranslations: {'English': 'Being honest is dharma.'},
        deeperExplanationTranslations: {'English': 'Dharma is a core pillar of Hindu life.'},
        keyPointsTranslations: {'English': ['Righteousness', 'Cosmic law']},
        sources: ['Rig Veda'],
        relatedTopics: ['Karma'],
        quizQuestions: [quiz],
        flashcards: [flashcard],
      );

      expect(lesson.id, 'l1');
      expect(lesson.getLocalizedTitle('English'), 'Introduction to Dharma');
      expect(lesson.getLocalizedTitle('Urdu'), 'دھرما کا تعارف');
      expect(lesson.quizQuestions.first.getLocalizedQuestion('English'), 'What is Dharma?');
      expect(lesson.flashcards.first.getLocalizedFront('English'), 'Dharma');
    });

    test('Settings copyWith works correctly', () {
      final s = Settings();
      expect(s.language, 'English');
      expect(s.learningLevel, 'Beginner');

      final updated = s.copyWith(language: 'Urdu', learningLevel: 'Intermediate');
      expect(updated.language, 'Urdu');
      expect(updated.learningLevel, 'Intermediate');
    });
  });

  group('AppState Unit Tests', () {
    test('State properties update correctly', () {
      final state = AppState();

      expect(state.settings.language, 'English');
      expect(state.isRtl, false);

      state.updateLanguage('UR');
      expect(state.settings.language, 'Urdu');
      expect(state.isRtl, true);

      state.updateLanguage('SD');
      expect(state.settings.language, 'Sindhi');
      expect(state.isRtl, true);

      state.updateLearningLevel('Intermediate');
      expect(state.settings.learningLevel, 'Intermediate');

      expect(state.progress.xp, 0);
      state.completeLesson('lesson_1');
      expect(state.progress.xp, 50);
      expect(state.progress.completedLessons.contains('lesson_1'), true);

      state.completeQuiz('quiz_1', 3, 3);
      expect(state.progress.xp, 50 + 30); // 50 + 3 * 10
      expect(state.progress.completedQuizzes.contains('quiz_1'), true);
    });

    test('Level locking works as designed', () {
      final state = AppState();
      expect(state.isLevelUnlocked('Beginner'), true);
      expect(state.isLevelUnlocked('Intermediate'), false);

      state.completeLesson('lesson_1');
      expect(state.isLevelUnlocked('Intermediate'), true);
      expect(state.isLevelUnlocked('Advanced'), false);

      state.completeLesson('lesson_2');
      state.completeLesson('lesson_3');
      state.completeQuiz('quiz_1', 1, 1);

      expect(state.isLevelUnlocked('Advanced'), true);
    });
  });
}
