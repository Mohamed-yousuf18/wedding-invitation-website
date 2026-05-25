// ============================================================
// widgets/gold_button.dart
//
// Reusable gold gradient button used across all screens.
// Has a glow pulse animation and press scale effect.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme/app_theme.dart';

class GoldButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;

  const GoldButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
  });

  @override
  State<GoldButton> createState() => _GoldButtonState();
}

class _GoldButtonState extends State<GoldButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnim;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    // Glow pulses back and forth every 1.5 seconds
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _glowAnim = Tween<double>(begin: 0.35, end: 0.65).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedBuilder(
          animation: _glowAnim,
          builder: (context, child) => Container(
            width: widget.width,
            padding: const EdgeInsets.symmetric(
                horizontal: 40, vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [
                  AppColors.goldDark,
                  AppColors.gold,
                  AppColors.goldLight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha:_glowAnim.value),
                  blurRadius: 24,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.5,
                color: AppColors.bgDark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}