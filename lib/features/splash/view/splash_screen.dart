/*
// ============================================================
// features/splash/view/splash_screen.dart
//
// HOW THIS SCREEN WORKS:
// 1. Gets the SplashController (already created by Binding)
// 2. Wraps animated parts in Obx() — auto-rebuilds on .obs changes
// 3. AnimatedContainer / AnimatedOpacity do the smooth transitions
//
// KEY FLUTTER CONCEPTS USED:
//   AnimatedOpacity  → smooth fade in/out
//   AnimatedScale    → smooth grow/shrink
//   Stack            → layers widgets on top of each other
//   Positioned       → place widget at exact position inside Stack
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/splash_controller.dart';
import '../../../app/theme/app_theme.dart';
import '../../../widgets/floating_hearts_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Find<> gets the controller that Binding already created.
    // Never use Get.put() here — Binding already did that.
    final controller = Get.find<SplashController>();

    return Scaffold(
      body: Container(
        // Full-screen dark romantic gradient background
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF2D0E1A), Color(0xFF0D0407)],
          ),
        ),
        child: Stack(
          children: [
            // Layer 1: Floating hearts in background
            const FloatingHeartsWidget(),

            // Layer 2: Center content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ── RINGS + HEART ICON ─────────────────
                  Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: controller.logoOpacity.value,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 800),
                      scale: controller.logoScale.value,
                      curve: Curves.elasticOut, // springy bounce
                      child: _buildRingsIcon(),
                    ),
                  )),

                  const SizedBox(height: 40),

                  // ── APP NAME ───────────────────────────
                  Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 700),
                    opacity: controller.titleOpacity.value,
                    child: Text(
                      'My Wedding Invitation',
                      style: GoogleFonts.cinzel(
                        fontSize: 22,
                        color: AppColors.goldLight,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),

                  const SizedBox(height: 12),

                  // ── SUBTITLE ───────────────────────────
                  Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 700),
                    opacity: controller.subtitleOpacity.value,
                    child: Text(
                      'A day to remember, forever',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 16,
                        color: AppColors.rose.withValues(alpha:0.8),
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.0,
                      ),
                    ),
                  )),
                ],
              ),
            ),

            // Layer 3: Loading dots at bottom
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Obx(() => AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: controller.subtitleOpacity.value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _loadingDot(delay: 0),
                    const SizedBox(width: 8),
                    _loadingDot(delay: 200),
                    const SizedBox(width: 8),
                    _loadingDot(delay: 400),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  // ── RINGS ICON ──────────────────────────────────────────
  Widget _buildRingsIcon() {
    return SizedBox(
      width: 140,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left ring
          Positioned(
            left: 10,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gold, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha:0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
          ),
          // Right ring (overlaps left)
          Positioned(
            right: 10,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.goldLight, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldLight.withValues(alpha:0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
          ),
          // Heart in center
          const Text(
            '💗',
            style: TextStyle(fontSize: 32),
          ),
        ],
      ),
    );
  }

  // ── ANIMATED DOT ────────────────────────────────────────
  Widget _loadingDot({required int delay}) {
    // TweenAnimationBuilder animates between two values
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      builder: (context, val, _) {
        return Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gold.withValues(alpha: val),
          ),
        );
      },
    );
  }
}*/
// ============================================================
// features/splash/view/splash_screen.dart
//
// CHANGE: Auto navigate போகல.
// Instead: "Enter Invitation ✦" button — tap பண்ணும்போது
//   1. Music start (user gesture = browser allow ✅)
//   2. Home screen navigate
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/splash_controller.dart';
import '../../../app/theme/app_theme.dart';
import '../../../widgets/floating_hearts_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF2D0E1A), Color(0xFF0D0407)],
          ),
        ),
        child: Stack(
          children: [
            // Layer 1: Floating hearts
            const FloatingHeartsWidget(),

            // Layer 2: Center content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Rings + Heart icon
                  Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: controller.logoOpacity.value,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 800),
                      scale: controller.logoScale.value,
                      curve: Curves.elasticOut,
                      child: _buildRingsIcon(),
                    ),
                  )),

                  const SizedBox(height: 32),

                  // Couple names (big & elegant)
                  Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 700),
                    opacity: controller.titleOpacity.value,
                    child: Column(
                      children: [
                        Text(
                          'Mohamed Yousuf',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 30,
                            fontWeight: FontWeight.w300,
                            color: AppColors.goldLight,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          '&',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            color: AppColors.rose,
                          ),
                        ),
                        Text(
                          'Hajima Bee',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 30,
                            fontWeight: FontWeight.w300,
                            color: AppColors.goldLight,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  )),

                  const SizedBox(height: 10),

                  // Wedding date subtitle
                  Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 700),
                    opacity: controller.subtitleOpacity.value,
                    child: Column(
                      children: [
                        Text(
                          'Wedding Invitation',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            color: AppColors.gold.withValues(alpha: 0.7),
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'July 05, 2026  ·  10:30 AM',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 14,
                            color: AppColors.rose.withValues(alpha: 0.6),
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  )),

                  const SizedBox(height: 48),

                  // ══════════════════════════════════════════
                  // ENTER BUTTON — music trigger இங்கே
                  // User tap = gesture = browser music allow ✅
                  // ══════════════════════════════════════════
                  Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 700),
                    opacity: controller.subtitleOpacity.value,
                    child: GestureDetector(
                      onTap: () => controller.enterWithMusic(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.goldDark,
                              AppColors.gold,
                              AppColors.goldLight,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gold.withValues(alpha: 0.45),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Color(0xFF1A0A05),
                              size: 16,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Open Invitation',
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2.5,
                                color: const Color(0xFF1A0A05),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),

            // Layer 3: Loading dots (show before button appears)
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Obx(() => AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                // Dots hide ஆகும் when button shows
                opacity: controller.subtitleOpacity.value > 0 ? 0.0 : 1.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _loadingDot(delay: 0),
                    const SizedBox(width: 8),
                    _loadingDot(delay: 200),
                    const SizedBox(width: 8),
                    _loadingDot(delay: 400),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRingsIcon() {
    return SizedBox(
      width: 140,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 10,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gold, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.goldLight, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldLight.withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          const Text('💗', style: TextStyle(fontSize: 32)),
        ],
      ),
    );
  }

  Widget _loadingDot({required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      builder: (context, val, _) {
        return Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gold.withValues(alpha: val),
          ),
        );
      },
    );
  }
}