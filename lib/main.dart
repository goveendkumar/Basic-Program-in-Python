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
import 'screens/search_screen.dart';

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

    return MaterialApp(
      title: 'Hindu Dharma Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange.shade800,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
          selectedItemColor: Colors.orange.shade800,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const AppNavigator(),
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
        backgroundColor: Colors.orange.shade800,
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
