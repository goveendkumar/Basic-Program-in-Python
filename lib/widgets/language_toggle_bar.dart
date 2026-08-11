import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class LanguageToggleBar extends StatelessWidget {
  const LanguageToggleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final currentLangCode = appState.languageCode;

    final languages = [
      {'code': 'EN', 'flag': '🇬🇧', 'name': 'English'},
      {'code': 'ROM', 'flag': '🔤', 'name': 'Roman English'},
      {'code': 'UR', 'flag': '🇵🇰', 'name': 'Urdu'},
      {'code': 'SD', 'flag': '🇮🇳', 'name': 'Sindhi'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: languages.map((lang) {
          final isSelected = currentLangCode == lang['code'];
          return InkWell(
            onTap: () {
              appState.updateLanguage(lang['code']!);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF6B00) : Colors.transparent, // Saffron Orange
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(lang['flag']!, style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 4),
                  Text(
                    lang['code']!,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
