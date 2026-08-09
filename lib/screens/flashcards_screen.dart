import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/content_database.dart';
import '../models/models.dart';

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({Key? key}) : super(key: key);

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  int _currentIndex = 0;
  bool _isFlipped = false;

  // Compile unique flashcards across all lessons
  List<Flashcard> _getFlashcards() {
    final List<Flashcard> list = [];
    for (var l in ContentDatabase.lessons) {
      list.addAll(l.flashcards);
    }
    // Fallback if empty
    if (list.isEmpty) {
      list.add(
        Flashcard(
          id: 'fc_fallback_1',
          category: 'Basics',
          imageUrl: '',
          front: 'Sanatana Dharma',
          back: 'The Eternal Way',
          explanation: 'The timeless natural moral code that holds all existence together.',
          example: 'Showing truth and compassion is Sanatana Dharma.',
          relatedConcept: 'Dharma',
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isDark = appState.settings.isDarkMode;
    final fontSize = appState.settings.fontSize;

    final cards = _getFlashcards();
    final fc = cards[_currentIndex];
    final isLearned = appState.learnedFlashcardIds.contains(fc.id);
    final isBookmarked = appState.bookmarkedFlashcardIds.contains(fc.id);

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.amber.shade50.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Spiritual Flashcards 📇', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top indicator and stars
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Card ${_currentIndex + 1} of ${cards.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        appState.toggleBookmarkFlashcard(fc.id);
                      },
                    ),
                    if (isLearned)
                      const Chip(
                        backgroundColor: Colors.green,
                        label: Text('Learned ✓', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Flippable Card Body
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isFlipped = !_isFlipped;
                  });
                },
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.orange, width: 2),
                  ),
                  color: isDark ? Colors.grey.shade800 : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isFlipped ? 'BACK - DEFINITION & DETAILS' : 'FRONT - SPIRITUAL CONCEPT',
                          style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          _isFlipped ? fc.back : fc.front,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fontSize + 6,
                            fontWeight: FontWeight.bold,
                            color: _isFlipped ? Colors.black87 : Colors.orange.shade800,
                          ),
                        ),
                        if (_isFlipped) ...[
                          const SizedBox(height: 16),
                          Text(
                            fc.explanation,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: fontSize - 1, color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Example: ${fc.example}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.brown),
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Navigation Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.orange, size: 32),
                  onPressed: _currentIndex == 0
                      ? null
                      : () {
                          setState(() {
                            _currentIndex--;
                            _isFlipped = false;
                          });
                        },
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    appState.markFlashcardLearned(fc.id, !isLearned);
                  },
                  icon: Icon(isLearned ? Icons.check_circle : Icons.radio_button_unchecked, color: Colors.white),
                  label: Text(isLearned ? 'Mark Unlearned' : 'Mark Learned', style: const TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLearned ? Colors.green : Colors.grey.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.orange, size: 32),
                  onPressed: _currentIndex == cards.length - 1
                      ? null
                      : () {
                          setState(() {
                            _currentIndex++;
                            _isFlipped = false;
                          });
                        },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
