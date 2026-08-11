import 'package:flutter/material.dart';
import '../models/models.dart';

class AppState extends ChangeNotifier {
  // Current user settings
  Settings _settings = Settings();
  Settings get settings => _settings;

  // Helper getter to check if current selected language is RTL (Right-to-Left)
  bool get isRtl {
    return _settings.language == "Urdu" || _settings.language == "Sindhi";
  }

  // User progress tracker
  UserProgress _progress = UserProgress(
    xp: 0,
    completedLessons: [],
    completedQuizzes: [],
    streak: 1, // Start with 1 day streak
    quizCorrectCount: 0,
    quizTotalCount: 0,
    lastActiveDate: DateTime.now(),
    unlockedBadges: [],
  );
  UserProgress get progress => _progress;

  // Bookmarks lists
  final List<String> _bookmarkedLessonIds = [];
  final List<String> _bookmarkedScriptureIds = [];
  final List<String> _bookmarkedDeityIds = [];
  final List<String> _bookmarkedFestivalIds = [];
  final List<String> _bookmarkedFlashcardIds = [];

  List<String> get bookmarkedLessonIds => _bookmarkedLessonIds;
  List<String> get bookmarkedScriptureIds => _bookmarkedScriptureIds;
  List<String> get bookmarkedDeityIds => _bookmarkedDeityIds;
  List<String> get bookmarkedFestivalIds => _bookmarkedFestivalIds;
  List<String> get bookmarkedFlashcardIds => _bookmarkedFlashcardIds;

  // Badges system
  List<AppBadge> _badges = [
    AppBadge(id: 'first_lesson', title: 'First Steps', description: 'Complete your first lesson.', icon: '🏆'),
    AppBadge(id: 'gita_beginner', title: 'Gita Seeker', description: 'Explore a chapter of Bhagavad Gita.', icon: '📖'),
    AppBadge(id: 'quiz_master', title: 'Quiz Master', description: 'Achieve 100% score on any quiz.', icon: '🔥'),
    AppBadge(id: 'streak_3', title: 'Dharma Devotee', description: 'Reach a 3-day learning streak.', icon: '🧘'),
    AppBadge(id: 'scripture_explorer', title: 'Scripture Explorer', description: 'Read details of any Sacred Text.', icon: '🌟'),
  ];
  List<AppBadge> get badges => _badges;

  // Flashcards learned state
  final Set<String> _learnedFlashcardIds = {};
  Set<String> get learnedFlashcardIds => _learnedFlashcardIds;

  // Toggle Language
  void updateLanguage(String lang) {
    if (lang == "EN") lang = "English";
    if (lang == "ROM") lang = "Roman English";
    if (lang == "UR") lang = "Urdu";
    if (lang == "SD") lang = "Sindhi";

    _settings = _settings.copyWith(language: lang);
    notifyListeners();
  }

  // Get current language flag prefix or code
  String get languageCode {
    if (_settings.language == "English") return "EN";
    if (_settings.language == "Roman English") return "ROM";
    if (_settings.language == "Urdu") return "UR";
    if (_settings.language == "Sindhi") return "SD";
    return "EN";
  }

  // Update learning level selection
  void updateLearningLevel(String level) {
    _settings = _settings.copyWith(learningLevel: level);
    notifyListeners();
  }

  // Update font size adjustment
  void updateFontSize(double size) {
    _settings = _settings.copyWith(fontSize: size);
    notifyListeners();
  }

  // Toggle theme mode
  void toggleTheme(bool isDark) {
    _settings = _settings.copyWith(isDarkMode: isDark);
    notifyListeners();
  }

  // Toggle notifications setting
  void toggleNotifications(bool enabled) {
    _settings = _settings.copyWith(notificationsEnabled: enabled);
    notifyListeners();
  }

  // Complete a lesson and earn XP
  void completeLesson(String lessonId) {
    if (!_progress.completedLessons.contains(lessonId)) {
      final updatedLessons = List<String>.from(_progress.completedLessons)..add(lessonId);
      final newXp = _progress.xp + 50; // 50 XP per lesson

      _progress = _progress.copyWith(
        completedLessons: updatedLessons,
        xp: newXp,
      );
      _checkAndUnlockBadges();
      notifyListeners();
    }
  }

  // Complete a quiz and update score/XP
  void completeQuiz(String quizId, int correct, int total) {
    final updatedQuizzes = List<String>.from(_progress.completedQuizzes);
    if (!updatedQuizzes.contains(quizId)) {
      updatedQuizzes.add(quizId);
    }

    final int earnedXp = correct * 10; // 10 XP per correct answer
    final newXp = _progress.xp + earnedXp;

    _progress = _progress.copyWith(
      completedQuizzes: updatedQuizzes,
      quizCorrectCount: _progress.quizCorrectCount + correct,
      quizTotalCount: _progress.quizTotalCount + total,
      xp: newXp,
    );

    if (correct == total && total > 0) {
      _unlockBadge('quiz_master');
    }

    _checkAndUnlockBadges();
    notifyListeners();
  }

  // Flashcard controls
  void markFlashcardLearned(String flashcardId, bool learned) {
    if (learned) {
      _learnedFlashcardIds.add(flashcardId);
      final newXp = _progress.xp + 5; // 5 XP for learning a flashcard
      _progress = _progress.copyWith(xp: newXp);
    } else {
      _learnedFlashcardIds.remove(flashcardId);
    }
    notifyListeners();
  }

  // Bookmark controls
  void toggleBookmarkLesson(String id) {
    if (_bookmarkedLessonIds.contains(id)) {
      _bookmarkedLessonIds.remove(id);
    } else {
      _bookmarkedLessonIds.add(id);
    }
    notifyListeners();
  }

  void toggleBookmarkScripture(String id) {
    if (_bookmarkedScriptureIds.contains(id)) {
      _bookmarkedScriptureIds.remove(id);
    } else {
      _bookmarkedScriptureIds.add(id);
    }
    notifyListeners();
  }

  void toggleBookmarkDeity(String id) {
    if (_bookmarkedDeityIds.contains(id)) {
      _bookmarkedDeityIds.remove(id);
    } else {
      _bookmarkedDeityIds.add(id);
    }
    notifyListeners();
  }

  void toggleBookmarkFestival(String id) {
    if (_bookmarkedFestivalIds.contains(id)) {
      _bookmarkedFestivalIds.remove(id);
    } else {
      _bookmarkedFestivalIds.add(id);
    }
    notifyListeners();
  }

  void toggleBookmarkFlashcard(String id) {
    if (_bookmarkedFlashcardIds.contains(id)) {
      _bookmarkedFlashcardIds.remove(id);
    } else {
      _bookmarkedFlashcardIds.add(id);
    }
    notifyListeners();
  }

  // Check if a specific level is unlocked.
  bool isLevelUnlocked(String level) {
    if (level == "Beginner") return true;
    if (level == "Intermediate") {
      return _progress.completedLessons.length >= 1 || _progress.completedQuizzes.isNotEmpty || _progress.xp >= 50;
    }
    if (level == "Advanced") {
      return _progress.completedLessons.length >= 3 && _progress.completedQuizzes.length >= 1;
    }
    return true;
  }

  // Helper method to unlock a badge
  void _unlockBadge(String badgeId) {
    final list = List<String>.from(_progress.unlockedBadges);
    if (!list.contains(badgeId)) {
      list.add(badgeId);
      _progress = _progress.copyWith(unlockedBadges: list);
      _badges = _badges.map((b) => b.id == badgeId ? b.copyWith(unlocked: true) : b).toList();
    }
  }

  // Badge validation rules
  void _checkAndUnlockBadges() {
    if (_progress.completedLessons.isNotEmpty) {
      _unlockBadge('first_lesson');
    }
    if (_progress.completedLessons.any((id) => id.contains('gita') || id.contains('text'))) {
      _unlockBadge('scripture_explorer');
    }
    if (_progress.completedLessons.any((id) => id.contains('gita_chapter'))) {
      _unlockBadge('gita_beginner');
    }
    if (_progress.completedLessons.length >= 3) {
      _unlockBadge('streak_3');
    }
  }
}
