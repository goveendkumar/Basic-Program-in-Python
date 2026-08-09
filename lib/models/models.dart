class Lesson {
  final String id;
  final String title;
  final String category; // e.g. "Basics", "Core Concepts", "Deities", etc.
  final String level; // "Beginner", "Intermediate", "Advanced"
  final String imageUrl; // placeholder/description string for visual rendering
  final String imageCaption;
  final String englishContent;
  final String romanEnglishContent;
  final String simpleExplanation;
  final String example;
  final String? visualDiagramType; // e.g., "Samsara", "Karma", "Dharma", "Moksha", "Yoga", "Gunas"
  final String deeperExplanation;
  final List<String> keyPoints;
  final List<String> sources;
  final List<String> relatedTopics;
  final List<QuizQuestion> quizQuestions;
  final List<Flashcard> flashcards;

  Lesson({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    required this.imageUrl,
    required this.imageCaption,
    required this.englishContent,
    required this.romanEnglishContent,
    required this.simpleExplanation,
    required this.example,
    this.visualDiagramType,
    required this.deeperExplanation,
    required this.keyPoints,
    required this.sources,
    required this.relatedTopics,
    required this.quizQuestions,
    required this.flashcards,
  });
}

class Scripture {
  final String id;
  final String title;
  final String type; // "Vedas", "Upanishads", "Gita", "Ramayana", "Mahabharata", "Puranas"
  final String imageUrl;
  final String description;
  final List<String> themes;
  final String importance;
  final List<String> sources;

  Scripture({
    required this.id,
    required this.title,
    required this.type,
    required this.imageUrl,
    required this.description,
    required this.themes,
    required this.importance,
    required this.sources,
  });
}

enum QuizType {
  multipleChoice,
  trueFalse,
  matchConcept,
  identifyCorrect,
}

class QuizQuestion {
  final String id;
  final String category;
  final QuizType type;
  final String question;
  final List<String> options; // for MCQ or Match
  final String correctAnswer;
  final String explanation;
  final String difficulty; // "Beginner", "Intermediate", "Advanced"
  final String? relatedLessonId;

  QuizQuestion({
    required this.id,
    required this.category,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.difficulty,
    this.relatedLessonId,
  });
}

class Flashcard {
  final String id;
  final String category;
  final String imageUrl;
  final String front;
  final String back;
  final String explanation;
  final String example;
  final String relatedConcept;
  final String? relatedLessonId;

  Flashcard({
    required this.id,
    required this.category,
    required this.imageUrl,
    required this.front,
    required this.back,
    required this.explanation,
    required this.example,
    required this.relatedConcept,
    this.relatedLessonId,
  });
}

class DictionaryEntry {
  final String term;
  final String simpleDefinition;
  final String romanEnglishDefinition;
  final String detailedExplanation;
  final String relatedConcepts;
  final String relatedScripture;
  final String relatedLessonId;

  DictionaryEntry({
    required this.term,
    required this.simpleDefinition,
    required this.romanEnglishDefinition,
    required this.detailedExplanation,
    required this.relatedConcepts,
    required this.relatedScripture,
    required this.relatedLessonId,
  });
}

class AppBadge {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool unlocked;

  AppBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.unlocked = false,
  });

  AppBadge copyWith({bool? unlocked}) {
    return AppBadge(
      id: id,
      title: title,
      description: description,
      icon: icon,
      unlocked: unlocked ?? this.unlocked,
    );
  }
}

class UserProgress {
  final int xp;
  final List<String> completedLessons;
  final List<String> completedQuizzes;
  final int streak;
  final int quizCorrectCount;
  final int quizTotalCount;
  final DateTime? lastActiveDate;
  final List<String> unlockedBadges;

  UserProgress({
    this.xp = 0,
    this.completedLessons = const [],
    this.completedQuizzes = const [],
    this.streak = 0,
    this.quizCorrectCount = 0,
    this.quizTotalCount = 0,
    this.lastActiveDate,
    this.unlockedBadges = const [],
  });

  UserProgress copyWith({
    int? xp,
    List<String>? completedLessons,
    List<String>? completedQuizzes,
    int? streak,
    int? quizCorrectCount,
    int? quizTotalCount,
    DateTime? lastActiveDate,
    List<String>? unlockedBadges,
  }) {
    return UserProgress(
      xp: xp ?? this.xp,
      completedLessons: completedLessons ?? this.completedLessons,
      completedQuizzes: completedQuizzes ?? this.completedQuizzes,
      streak: streak ?? this.streak,
      quizCorrectCount: quizCorrectCount ?? this.quizCorrectCount,
      quizTotalCount: quizTotalCount ?? this.quizTotalCount,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      unlockedBadges: unlockedBadges ?? this.unlockedBadges,
    );
  }
}

class Settings {
  final String language; // "English" or "Roman English"
  final String learningLevel; // "Beginner", "Intermediate", "Advanced"
  final double fontSize; // 14.0, 16.0, 18.0, 22.0
  final bool isDarkMode;
  final bool notificationsEnabled;

  Settings({
    this.language = "English",
    this.learningLevel = "Beginner",
    this.fontSize = 16.0,
    this.isDarkMode = false,
    this.notificationsEnabled = true,
  });

  Settings copyWith({
    String? language,
    String? learningLevel,
    double? fontSize,
    bool? isDarkMode,
    bool? notificationsEnabled,
  }) {
    return Settings(
      language: language ?? this.language,
      learningLevel: learningLevel ?? this.learningLevel,
      fontSize: fontSize ?? this.fontSize,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
