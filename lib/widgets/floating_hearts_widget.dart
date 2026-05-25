// ============================================================
// widgets/floating_hearts_widget.dart
//
// Renders animated floating hearts/petals in the background.
// Uses AnimationController + Transform for movement.
// ============================================================

import 'dart:math' as math;
import 'package:flutter/material.dart';

class FloatingHeartsWidget extends StatefulWidget {
  const FloatingHeartsWidget({super.key});

  @override
  State<FloatingHeartsWidget> createState() => _FloatingHeartsWidgetState();
}

class _FloatingHeartsWidgetState extends State<FloatingHeartsWidget>
    with TickerProviderStateMixin {

  late final List<_HeartParticle> _particles;

  @override
  void initState() {
    super.initState();
    final rand = math.Random();
    // Create 15 particles with random properties
    _particles = List.generate(15, (i) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 4 + rand.nextInt(5)),
      );
      controller.repeat(); // loops forever
      return _HeartParticle(
        controller: controller,
        left: rand.nextDouble(),       // horizontal position (0.0–1.0)
        delay: rand.nextDouble() * 4,  // stagger start time
        speed: 0.5 + rand.nextDouble(),
        size: 12.0 + rand.nextDouble() * 14,
        emoji: ['💗', '🌸', '✨', '💕', '🌺'][rand.nextInt(5)],
      );
    });
  }

  @override
  void dispose() {
    for (final p in _particles) {
      p.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _particles.map((p) => AnimatedBuilder(
        animation: p.controller,
        builder: (context, child) {
          // value goes 0.0 → 1.0 → 0.0 → ... (repeat)
          // We use it to move particle upward + fade
          final progress = p.controller.value;
          final yOffset = 1.0 - progress; // moves from bottom to top
          final opacity = progress < 0.2
              ? progress / 0.2        // fade in
              : progress > 0.8
              ? (1.0 - progress) / 0.2  // fade out
              : 1.0;

          return Positioned(
            left: MediaQuery.of(context).size.width * p.left,
            top: MediaQuery.of(context).size.height * yOffset,
            child: Opacity(
              opacity: (opacity * 0.5).clamp(0.0, 1.0),
              child: Text(
                p.emoji,
                style: TextStyle(fontSize: p.size),
              ),
            ),
          );
        },
      )).toList(),
    );
  }
}

class _HeartParticle {
  final AnimationController controller;
  final double left;
  final double delay;
  final double speed;
  final double size;
  final String emoji;

  _HeartParticle({
    required this.controller,
    required this.left,
    required this.delay,
    required this.speed,
    required this.size,
    required this.emoji,
  });
}