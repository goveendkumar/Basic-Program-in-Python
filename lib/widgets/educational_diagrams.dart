import 'dart:math';
import 'package:flutter/material.dart';

class EducationalDiagram extends StatelessWidget {
  final String? diagramType;

  const EducationalDiagram({Key? key, required this.diagramType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (diagramType == null) return const SizedBox.shrink();

    Widget diagramWidget;
    String title;
    String caption;

    switch (diagramType) {
      case 'Samsara':
        title = "SAMSARA CYCLE DIAGRAM";
        caption = "Samsara Loop: Birth → Life → Death → Rebirth. Driven by Karma and Desire.";
        diagramWidget = SizedBox(
          height: 180,
          child: CustomPaint(
            size: const Size(double.infinity, 180),
            painter: SamsaraPainter(),
          ),
        );
        break;
      case 'Karma':
        title = "KARMA CAUSE & EFFECT LOOP";
        caption = "Karma Loop: Intention → Action (Karma) → Consequences (Karma Phala).";
        diagramWidget = SizedBox(
          height: 180,
          child: CustomPaint(
            size: const Size(double.infinity, 180),
            painter: KarmaPainter(),
          ),
        );
        break;
      case 'Dharma':
        title = "DHARMA COHESION PATHWAY";
        caption = "Dharma Pathway: Duty → Right Conduct → Cosmic Harmony → Responsible Living.";
        diagramWidget = SizedBox(
          height: 180,
          child: CustomPaint(
            size: const Size(double.infinity, 180),
            painter: DharmaPainter(),
          ),
        );
        break;
      case 'Moksha':
        title = "MOKSHA LIBERATION FLOW";
        caption = "Moksha Flow: Spiritual Path → Purification → Ego Dissolution → Union / Freedom.";
        diagramWidget = SizedBox(
          height: 180,
          child: CustomPaint(
            size: const Size(double.infinity, 180),
            painter: MokshaPainter(),
          ),
        );
        break;
      case 'Yoga':
        title = "FOUR YOGA PATHWAYS";
        caption = "Karma Yoga (Action), Jnana Yoga (Wisdom), Bhakti Yoga (Love), Raja Yoga (Dhyana).";
        diagramWidget = const FourYogasWidget();
        break;
      case 'Gunas':
        title = "THE THREE GUNAS (MODES OF NATURE)";
        caption = "Sattva (Clarity & Peace) ↑ Rajas (Passion & Motion) ⇄ Tamas (Inertia & Confusion) ↓";
        diagramWidget = const ThreeGunasWidget();
        break;
      default:
        return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.orange, width: 1.5),
      ),
      elevation: 4,
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.psychology, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.orange, thickness: 1),
            const SizedBox(height: 8),
            diagramWidget,
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                caption,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Samsara (Cycle of Birth-Rebirth)
class SamsaraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2.5;

    final paintCircle = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Draw Wheel of Samsara
    canvas.drawCircle(center, radius, paintCircle);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final stages = [
      {'label': 'Birth (Janma)', 'angle': 0.0},
      {'label': 'Life (Samsara)', 'angle': pi / 2},
      {'label': 'Death (Mrityu)', 'angle': pi},
      {'label': 'Rebirth (Punarjanma)', 'angle': 3 * pi / 2},
    ];

    for (var stage in stages) {
      final angle = stage['angle'] as double;
      final label = stage['label'] as String;

      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      // Draw stage dots
      canvas.drawCircle(Offset(x, y), 8, Paint()..color = Colors.orange);

      // Draw labels
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(color: Colors.brown, fontSize: 10, fontWeight: FontWeight.bold),
      );
      textPainter.layout();

      // Position text outside circle
      final textOffset = Offset(
        x + (cos(angle) * 12) - (textPainter.width / 2),
        y + (sin(angle) * 12) - (textPainter.height / 2),
      );
      textPainter.paint(canvas, textOffset);
    }

    // Draw central hub representing ignorance/desires
    canvas.drawCircle(center, 15, Paint()..color = Colors.red.shade200);
    textPainter.text = const TextSpan(
      text: 'Karma',
      style: TextStyle(color: Colors.red, fontSize: 8, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for Karma (Cause and Effect Loop)
class KarmaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final paintDot = Paint()..color = Colors.brown;

    // Draw arrows or sequence lines horizontally
    final centerY = size.height / 2;
    final startX = 40.0;
    final endX = size.width - 40.0;
    final step = (endX - startX) / 2;

    // Draw connecting line
    canvas.drawLine(Offset(startX, centerY), Offset(endX, centerY), paintLine);

    final points = [
      {'label': 'Intention / Choice', 'x': startX, 'icon': '🧠'},
      {'label': 'Action (Karma)', 'x': startX + step, 'icon': '⚡'},
      {'label': 'Result (Phala)', 'x': endX, 'icon': '🍏'},
    ];

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var p in points) {
      final x = p['x'] as double;
      final label = p['label'] as String;
      final icon = p['icon'] as String;

      canvas.drawCircle(Offset(x, centerY), 12, paintDot);

      // Icon
      textPainter.text = TextSpan(
        text: icon,
        style: const TextStyle(fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, centerY - textPainter.height / 2));

      // Label below
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(color: Colors.brown, fontSize: 10, fontWeight: FontWeight.bold),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, centerY + 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for Dharma (Balance scale / Straight Path)
class DharmaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final scalePaint = Paint()
      ..color = Colors.amber.shade900
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Base Pillar of Scale (Dharma)
    canvas.drawLine(Offset(center.dx, center.dy - 40), Offset(center.dx, center.dy + 40), scalePaint);
    canvas.drawLine(Offset(center.dx - 30, center.dy + 40), Offset(center.dx + 30, center.dy + 40), scalePaint);

    // Balance Beam
    canvas.drawLine(Offset(center.dx - 50, center.dy - 30), Offset(center.dx + 50, center.dy - 30), scalePaint);

    // Left Scale Pan (Cosmic Order / Rta)
    canvas.drawCircle(Offset(center.dx - 50, center.dy + 10), 10, Paint()..color = Colors.orange);
    // Right Scale Pan (Righteous Duty / Svadharma)
    canvas.drawCircle(Offset(center.dx + 50, center.dy + 10), 10, Paint()..color = Colors.orange);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = const TextSpan(
      text: 'Cosmic Order (Rta)',
      style: TextStyle(color: Colors.brown, fontSize: 9, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - 90, center.dy + 25));

    textPainter.text = const TextSpan(
      text: 'Duty (Svadharma)',
      style: TextStyle(color: Colors.brown, fontSize: 9, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx + 15, center.dy + 25));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for Moksha (Ascending flow)
class MokshaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final startX = size.width / 4;
    final endX = 3 * size.width / 4;

    final paintSpark = Paint()..color = Colors.yellow;

    // Draw ascending spiritual steps
    final stepsPaint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(startX, centerY + 30);
    path.lineTo(startX + 40, centerY + 10);
    path.lineTo(startX + 80, centerY - 10);
    path.lineTo(endX, centerY - 30);

    canvas.drawPath(path, stepsPaint);

    // Divine Sun/Glow at the end of the path
    canvas.drawCircle(Offset(endX, centerY - 30), 20, paintSpark);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    textPainter.text = const TextSpan(
      text: '☀️ Moksha (Liberation)',
      style: TextStyle(color: Colors.orange, fontSize: 11, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(endX - 45, centerY - 65));

    textPainter.text = const TextSpan(
      text: 'Ego Dissolution',
      style: TextStyle(color: Colors.brown, fontSize: 9),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(startX + 40, centerY + 20));

    textPainter.text = const TextSpan(
      text: 'Spiritual Practices',
      style: TextStyle(color: Colors.brown, fontSize: 9),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(startX - 20, centerY + 45));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Layout Widget for Yogas
class FourYogasWidget extends StatelessWidget {
  const FourYogasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final yogas = [
      {'title': 'Karma Yoga', 'subtitle': 'Path of Selfless Action', 'color': Colors.orange, 'icon': Icons.pan_tool},
      {'title': 'Jnana Yoga', 'subtitle': 'Path of Wisdom', 'color': Colors.blue, 'icon': Icons.menu_book},
      {'title': 'Bhakti Yoga', 'subtitle': 'Path of Pure Devotion', 'color': Colors.red, 'icon': Icons.favorite},
      {'title': 'Raja Yoga', 'subtitle': 'Path of Meditation', 'color': Colors.green, 'icon': Icons.self_improvement},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: yogas.length,
      itemBuilder: (context, idx) {
        final yoga = yogas[idx];
        final materialColor = yoga['color'] as MaterialColor;
        return Container(
          decoration: BoxDecoration(
            color: materialColor.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: materialColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Icon(yoga['icon'] as IconData, color: materialColor, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      yoga['title'] as String,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: materialColor.shade900),
                    ),
                    Text(
                      yoga['subtitle'] as String,
                      style: const TextStyle(fontSize: 9, color: Colors.black87),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

// Layout Widget for Gunas
class ThreeGunasWidget extends StatelessWidget {
  const ThreeGunasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gunas = [
      {
        'title': 'Sattva',
        'sub': 'Clarity, Peace, Wisdom',
        'color': Colors.green.shade50,
        'borderColor': Colors.green,
        'icon': '🌿'
      },
      {
        'title': 'Rajas',
        'sub': 'Activity, Passion, Desire',
        'color': Colors.orange.shade50,
        'borderColor': Colors.orange,
        'icon': '🔥'
      },
      {
        'title': 'Tamas',
        'sub': 'Inertia, Confusion, Darkness',
        'color': Colors.blueGrey.shade50,
        'borderColor': Colors.blueGrey,
        'icon': '🌑'
      },
    ];

    return Column(
      children: gunas.map((g) {
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: g['color'] as Color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: g['borderColor'] as Color, width: 1.2),
          ),
          child: Row(
            children: [
              Text(g['icon'] as String, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(g['title'] as String, style: TextStyle(fontWeight: FontWeight.bold, color: g['borderColor'] as Color)),
                    Text(g['sub'] as String, style: const TextStyle(fontSize: 10, color: Colors.black87)),
                  ],
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}

// --- APP BRANDING LOGO: "SANATAN PATH" ---
// Beautiful 3D Glowing Om inside deep maroon circle with gold mandala background
class OmLogoPainter extends CustomPainter {
  final double animationValue; // to support pulse/glow scale animation

  OmLogoPainter({this.animationValue = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // 1. Draw Deep Maroon (#8B1A1A) Background Circle
    final baseCirclePaint = Paint()
      ..color = const Color(0xFF8B1A1A)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, baseCirclePaint);

    // 2. Draw Subtle Gold Mandala Pattern (8 petals)
    final mandalaPaint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i < 8; i++) {
      final angle = (i * 2 * pi) / 8;
      final petalCenter = Offset(
        center.dx + (radius * 0.45) * cos(angle),
        center.dy + (radius * 0.45) * sin(angle),
      );
      canvas.drawCircle(petalCenter, radius * 0.35, mandalaPaint);
    }

    // Outer mandala dotted boundary
    final outerRingPaint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius * 0.9, outerRingPaint);

    // 3. Draw 3D Glowing Gold Gradient for Om symbol text
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final pulseScale = 1.0 + (0.05 * sin(animationValue * 2 * pi));

    textPainter.text = TextSpan(
      text: 'ॐ',
      style: TextStyle(
        fontSize: radius * 1.1 * pulseScale,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFFD4AF37), Color(0xFFFFD700)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromCircle(center: center, radius: radius * 0.5))
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1.5 * pulseScale),
        shadows: [
          Shadow(
            color: const Color(0xFFFFD700).withOpacity(0.8),
            blurRadius: 15 * pulseScale,
            offset: const Offset(0, 0),
          ),
          const Shadow(
            color: Colors.black45,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2.05),
    );
  }

  @override
  bool shouldRepaint(covariant OmLogoPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
