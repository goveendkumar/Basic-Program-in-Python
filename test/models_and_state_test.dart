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
        question: 'What is Dharma?',
        options: ['Duty', 'Water', 'Air', 'Fire'],
        correctAnswer: 'Duty',
        explanation: 'Dharma is right conduct or cosmic order.',
        difficulty: 'Beginner',
      );

      final flashcard = Flashcard(
        id: 'fc1',
        category: 'Basics',
        imageUrl: '',
        front: 'Dharma',
        back: 'Righteous Duty',
        explanation: 'Righteous action and conduct.',
        example: 'Helping someone in need is Dharma.',
        relatedConcept: 'Right conduct',
      );

      final lesson = Lesson(
        id: 'l1',
        title: 'Introduction to Dharma',
        category: 'Basics',
        level: 'Beginner',
        imageUrl: 'assets/dharma.png',
        imageCaption: 'Illustration of Dharma Wheel',
        englishContent: 'Dharma means righteousness.',
        romanEnglishContent: 'Dharma ka matlab righteousness hai.',
        simpleExplanation: 'Righteous duty.',
        example: 'Being honest is dharma.',
        deeperExplanation: 'Dharma is a core pillar of Hindu life.',
        keyPoints: ['Righteousness', 'Cosmic law'],
        sources: ['Rig Veda'],
        relatedTopics: ['Karma'],
        quizQuestions: [quiz],
        flashcards: [flashcard],
      );

      expect(lesson.id, 'l1');
      expect(lesson.title, 'Introduction to Dharma');
      expect(lesson.quizQuestions.first.question, 'What is Dharma?');
      expect(lesson.flashcards.first.front, 'Dharma');
    });

    test('Settings copyWith works correctly', () {
      final s = Settings();
      expect(s.language, 'English');
      expect(s.learningLevel, 'Beginner');

      final updated = s.copyWith(language: 'Roman English', learningLevel: 'Intermediate');
      expect(updated.language, 'Roman English');
      expect(updated.learningLevel, 'Intermediate');
    });
  });

  group('AppState Unit Tests', () {
    test('State properties update correctly', () {
      final state = AppState();

      expect(state.settings.language, 'English');
      state.updateLanguage('Roman English');
      expect(state.settings.language, 'Roman English');

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

      // Complete a lesson to earn 50 XP
      state.completeLesson('lesson_1');
      expect(state.isLevelUnlocked('Intermediate'), true);
      expect(state.isLevelUnlocked('Advanced'), false);

      state.completeLesson('lesson_2');
      state.completeLesson('lesson_3');
      state.completeQuiz('quiz_1', 1, 1);

      expect(state.isLevelUnlocked('Advanced'), true);
    });

    test('Bookmarks manage correct state', () {
      final state = AppState();
      expect(state.bookmarkedLessonIds.isEmpty, true);

      state.toggleBookmarkLesson('lesson_1');
      expect(state.bookmarkedLessonIds.contains('lesson_1'), true);

      state.toggleBookmarkLesson('lesson_1');
      expect(state.bookmarkedLessonIds.contains('lesson_1'), false);
    });
  });
}
