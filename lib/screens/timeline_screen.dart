import 'package:flutter/material.dart';

class TimelineScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Map<String, String>> steps;
  final String icon;

  const TimelineScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.steps,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Visual Timeline Cards
          ...List.generate(steps.length, (idx) {
            final step = steps[idx];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left hand timeline column
                Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.orange, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '${idx + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.orange),
                        ),
                      ),
                    ),
                    if (idx < steps.length - 1)
                      Container(
                        width: 3,
                        height: 90,
                        color: Colors.orange.shade300,
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                // Right hand card content
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(icon, style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 8),
                            Text(
                              step['title']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.brown),
                            ),
                          ],
                        ),
                        const Divider(height: 12),
                        Text(
                          step['description']!,
                          style: const TextStyle(fontSize: 12, height: 1.4, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
