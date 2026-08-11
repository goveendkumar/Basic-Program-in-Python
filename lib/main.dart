import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/scriptures_screen.dart';
import 'screens/quiz_categories_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/ai_assistant_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: const HinduDharmaApp(),
    ),
  );
}

class HinduDharmaApp extends StatelessWidget {
  const HinduDharmaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;

    // "SANATAN PATH" Beautiful Brand Colors Setup
    final primaryColor = const Color(0xFFFF6B00); // Saffron Orange
    final secondaryColor = const Color(0xFF8B1A1A); // Deep Maroon
    final accentColor = const Color(0xFFD4AF37); // Gold
    final backgroundColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF9F0); // Warm Cream
    final textPrimary = isDark ? const Color(0xFFFFFFFF) : const Color(0xFF2D1B0E); // Dark Brown
    final textSecondary = isDark ? const Color(0xFFCCCCCC) : const Color(0xFF6B4F3C); // Muted Brown

    return MaterialApp(
      title: 'SANATAN PATH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
        hintColor: accentColor,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: textPrimary),
          bodyMedium: TextStyle(color: textSecondary),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
        ),
        cardTheme: CardThemeData(
          color: isDark ? Colors.grey.shade900 : Colors.white.withOpacity(0.95),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: const DirectionalityWrapper(child: AppNavigator()),
    );
  }
}

// Global dynamic TextDirection wrapper supporting Urdu & Sindhi RTL layout direction
class DirectionalityWrapper extends StatelessWidget {
  final Widget child;
  const DirectionalityWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final direction = appState.isRtl ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: direction,
      child: child,
    );
  }
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  bool _showSplash = true;
  bool _showOnboarding = true;
  int _selectedTabIdx = 0;

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(
        onTimeout: () {
          setState(() {
            _showSplash = false;
          });
        },
      );
    }

    if (_showOnboarding) {
      return OnboardingScreen(
        onFinish: () {
          setState(() {
            _showOnboarding = false;
          });
        },
      );
    }

    final List<Widget> tabs = [
      HomeScreen(navigateToTab: (index) {
        setState(() {
          _selectedTabIdx = index;
        });
      }),
      const LearnScreen(),
      const ScripturesScreen(),
      const QuizCategoriesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedTabIdx,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIdx,
        type: BottomNavigationBarType.fixed,
        onTap: (idx) {
          setState(() {
            _selectedTabIdx = idx;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'Scriptures'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF6B00), // Saffron Orange
        foregroundColor: Colors.white,
        tooltip: 'AI Dharma Tutor',
        child: const Icon(Icons.psychology),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AiAssistantScreen()),
          );
        },
      ),
    );
  }
}
