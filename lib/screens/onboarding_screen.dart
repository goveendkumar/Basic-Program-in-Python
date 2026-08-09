import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;
  const OnboardingScreen({Key? key, required this.onFinish}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Learn Hindu Dharma',
      'desc': 'Discover the ancient universal principles of Sanatana Dharma step-by-step.',
      'icon': '🙏',
    },
    {
      'title': 'Text + Visuals combined',
      'desc': 'Every lesson includes diagrams, flowcharts and examples to make study simple.',
      'icon': '📊',
    },
    {
      'title': 'Explore Sacred Texts',
      'desc': 'Gain access to the Upanishads, Puranas, Vedas, Ramayana, and Mahabharata.',
      'icon': '📖',
    },
    {
      'title': 'Study Bhagavad Gita',
      'desc': 'Explore all 18 chapters chapter-by-chapter with Krishna-Arjuna context.',
      'icon': '☸️',
    },
    {
      'title': 'Stories, Quizzes & Flashcards',
      'desc': 'Test your progress and reinforce learning with visual quiz systems.',
      'icon': '🏆',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: appState.settings.isDarkMode ? Colors.grey.shade900 : Colors.amber.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  _controller.jumpToPage(_pages.length - 1);
                },
                child: const Text('Skip', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              ),
            ),
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (idx) {
                  setState(() {
                    _currentIndex = idx;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, idx) {
                  final page = _pages[idx];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          page['icon']!,
                          style: const TextStyle(fontSize: 80),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          page['title']!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: appState.settings.isDarkMode ? Colors.white : Colors.orange.shade900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['desc']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: appState.settings.isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.orange : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            // Bottom selections on final slide
            if (_currentIndex == _pages.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Language Selection Selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => appState.updateLanguage('English'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appState.settings.language == 'English' ? Colors.orange : Colors.grey.shade300,
                          ),
                          child: const Text('English'),
                        ),
                        ElevatedButton(
                          onPressed: () => appState.updateLanguage('Roman English'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appState.settings.language == 'Roman English' ? Colors.orange : Colors.grey.shade300,
                          ),
                          child: const Text('Roman English'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Level Selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => appState.updateLearningLevel('Beginner'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appState.settings.learningLevel == 'Beginner' ? Colors.orange : Colors.grey.shade300,
                          ),
                          child: const Text('Beginner'),
                        ),
                        ElevatedButton(
                          onPressed: () => appState.updateLearningLevel('Intermediate'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appState.settings.learningLevel == 'Intermediate' ? Colors.orange : Colors.grey.shade300,
                          ),
                          child: const Text('Intermediate'),
                        ),
                        ElevatedButton(
                          onPressed: () => appState.updateLearningLevel('Advanced'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appState.settings.learningLevel == 'Advanced' ? Colors.orange : Colors.grey.shade300,
                          ),
                          child: const Text('Advanced'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.onFinish,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade800,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'START LEARNING 🚩',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _controller.jumpToPage(_pages.length - 1);
                      },
                      child: const Text('Skip all', style: TextStyle(color: Colors.grey)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
