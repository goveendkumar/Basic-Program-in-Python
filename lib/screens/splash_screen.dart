import 'package:flutter/material.dart';
import '../widgets/educational_diagrams.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onTimeout;
  const SplashScreen({Key? key, required this.onTimeout}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // Smooth pulsing animation for the 3D Om

    Future.delayed(const Duration(seconds: 3), widget.onTimeout);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B1A1A), // Deep Maroon background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pulse Animated 3D Om Logo Inside Golden Mandala
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SizedBox(
                  width: 180,
                  height: 180,
                  child: CustomPaint(
                    painter: OmLogoPainter(animationValue: _controller.value),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'SANATAN PATH',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37), // Gold accent
                letterSpacing: 1.5,
                shadows: [
                  Shadow(blurRadius: 10, color: Colors.black45, offset: Offset(2, 2)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your Guide to Eternal Wisdom',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFFFF9F0), // Warm Cream
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
            ),
          ],
        ),
      ),
    );
  }
}
