class Lesson {
  final String id;
  final String title;
  final String category; // e.g. "Basics", "Core Concepts", "Deities", etc.
  final String level; // "Beginner", "Intermediate", "Advanced"
  final String imageUrl; // placeholder/description string for visual rendering
  final String imageCaption;

  // Multilingual content map for flexibility and ease of lookup
  final Map<String, String> titleTranslations;
  final Map<String, String> contentTranslations;
  final Map<String, String> simpleExplanationTranslations;
  final Map<String, String> exampleTranslations;
  final Map<String, String> deeperExplanationTranslations;
  final Map<String, List<String>> keyPointsTranslations;

  final String? visualDiagramType; // e.g., "Samsara", "Karma", "Dharma", "Moksha", "Yoga", "Gunas"
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
    required this.titleTranslations,
    required this.contentTranslations,
    required this.simpleExplanationTranslations,
    required this.exampleTranslations,
    required this.deeperExplanationTranslations,
    required this.keyPointsTranslations,
    this.visualDiagramType,
    required this.sources,
    required this.relatedTopics,
    required this.quizQuestions,
    required this.flashcards,
  });

  // Getters to fall back to English if target is missing
  String getLocalizedTitle(String lang) => titleTranslations[lang] ?? title;
  String getLocalizedContent(String lang) => contentTranslations[lang] ?? contentTranslations['English'] ?? '';
  String getLocalizedSimpleExplanation(String lang) => simpleExplanationTranslations[lang] ?? simpleExplanationTranslations['English'] ?? '';
  String getLocalizedExample(String lang) => exampleTranslations[lang] ?? exampleTranslations['English'] ?? '';
  String getLocalizedDeeperExplanation(String lang) => deeperExplanationTranslations[lang] ?? deeperExplanationTranslations['English'] ?? '';
  List<String> getLocalizedKeyPoints(String lang) => keyPointsTranslations[lang] ?? keyPointsTranslations['English'] ?? [];
}

class Scripture {
  final String id;
  final String title;
  final String type; // "Vedas", "Upanishads", "Gita", "Ramayana", "Mahabharata", "Puranas"
  final String imageUrl;
  final Map<String, String> titleTranslations;
  final Map<String, String> descriptionTranslations;
  final List<String> themes;
  final Map<String, String> importanceTranslations;
  final List<String> sources;

  Scripture({
    required this.id,
    required this.title,
    required this.type,
    required this.imageUrl,
    required this.titleTranslations,
    required this.descriptionTranslations,
    required this.themes,
    required this.importanceTranslations,
    required this.sources,
  });

  String getLocalizedTitle(String lang) => titleTranslations[lang] ?? title;
  String getLocalizedDescription(String lang) => descriptionTranslations[lang] ?? descriptionTranslations['English'] ?? '';
  String getLocalizedImportance(String lang) => importanceTranslations[lang] ?? importanceTranslations['English'] ?? '';
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
  final Map<String, String> questionTranslations;
  final Map<String, List<String>> optionsTranslations;
  final Map<String, String> correctAnswerTranslations;
  final Map<String, String> explanationTranslations;
  final String difficulty; // "Beginner", "Intermediate", "Advanced"
  final String? relatedLessonId;

  QuizQuestion({
    required this.id,
    required this.category,
    required this.type,
    required this.questionTranslations,
    required this.optionsTranslations,
    required this.correctAnswerTranslations,
    required this.explanationTranslations,
    required this.difficulty,
    this.relatedLessonId,
  });

  String getLocalizedQuestion(String lang) => questionTranslations[lang] ?? questionTranslations['English'] ?? '';
  List<String> getLocalizedOptions(String lang) => optionsTranslations[lang] ?? optionsTranslations['English'] ?? [];
  String getLocalizedCorrectAnswer(String lang) => correctAnswerTranslations[lang] ?? correctAnswerTranslations['English'] ?? '';
  String getLocalizedExplanation(String lang) => explanationTranslations[lang] ?? explanationTranslations['English'] ?? '';
}

class Flashcard {
  final String id;
  final String category;
  final String imageUrl;
  final Map<String, String> frontTranslations;
  final Map<String, String> backTranslations;
  final Map<String, String> explanationTranslations;
  final Map<String, String> exampleTranslations;
  final String relatedConcept;
  final String? relatedLessonId;

  Flashcard({
    required this.id,
    required this.category,
    required this.imageUrl,
    required this.frontTranslations,
    required this.backTranslations,
    required this.explanationTranslations,
    required this.exampleTranslations,
    required this.relatedConcept,
    this.relatedLessonId,
  });

  String getLocalizedFront(String lang) => frontTranslations[lang] ?? frontTranslations['English'] ?? '';
  String getLocalizedBack(String lang) => backTranslations[lang] ?? backTranslations['English'] ?? '';
  String getLocalizedExplanation(String lang) => explanationTranslations[lang] ?? explanationTranslations['English'] ?? '';
  String getLocalizedExample(String lang) => exampleTranslations[lang] ?? exampleTranslations['English'] ?? '';
}

class DictionaryEntry {
  final String term;
  final Map<String, String> definitionTranslations;
  final Map<String, String> detailedExplanationTranslations;
  final String relatedConcepts;
  final String relatedScripture;
  final String relatedLessonId;

  DictionaryEntry({
    required this.term,
    required this.definitionTranslations,
    required this.detailedExplanationTranslations,
    required this.relatedConcepts,
    required this.relatedScripture,
    required this.relatedLessonId,
  });

  String getLocalizedDefinition(String lang) => definitionTranslations[lang] ?? definitionTranslations['English'] ?? '';
  String getLocalizedDetailedExplanation(String lang) => detailedExplanationTranslations[lang] ?? detailedExplanationTranslations['English'] ?? '';
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
  final String language; // "English", "Roman English", "Urdu", "Sindhi"
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
