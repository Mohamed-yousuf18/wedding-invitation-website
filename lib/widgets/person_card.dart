/*
// ============================================================
// widgets/person_card.dart
//
// Profile card for Bride & Groom section.
// Features:
//   - Tap/hover triggers glow animation
//   - Glassmorphism background
//   - Image avatar with gold ring
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme/app_theme.dart';

class PersonCard extends StatefulWidget {

  // ✅ IMAGE PATH
  final String imagePath;

  final String name;
  final String role;
  final String bio;

  const PersonCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.role,
    required this.bio,
  });

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      // Mobile tap glow
      onTapDown: (_) => setState(() => _hovered = true),
      onTapUp: (_) => setState(() => _hovered = false),
      onTapCancel: () => setState(() => _hovered = false),

      child: MouseRegion(

        // Web hover glow
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,

          // Slight floating effect
          transform: Matrix4.translationValues(
            0,
            _hovered ? -4 : 0,
            0,
          ),

          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            border: Border.all(
              color: _hovered
                  ? AppColors.gold.withValues(alpha: 0.5)
                  : AppColors.gold.withValues(alpha: 0.15),
              width: _hovered ? 1.5 : 1,
            ),

            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: _hovered ? 0.07 : 0.03),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),

            boxShadow: _hovered
                ? [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.12),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ]
                : [],
          ),

          child: Column(
            children: [

              // =====================================================
              // PROFILE IMAGE
              // =====================================================

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),

                width: 110,
                height: 110,

                padding: const EdgeInsets.all(3),

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFD27D),
                      Color(0xFFC9A227),
                    ],
                  ),

                  boxShadow: _hovered
                      ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.25),
                      blurRadius: 25,
                      spreadRadius: 3,
                    ),
                  ]
                      : [],
                ),

                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),

                  child: ClipOval(
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =====================================================
              // NAME
              // =====================================================

              Text(
                widget.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textLight,
                ),
              ),

              const SizedBox(height: 6),

              // =====================================================
              // ROLE
              // =====================================================

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.gold.withValues(alpha: 0.08),
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.15),
                  ),
                ),

                child: Text(
                  widget.role.toUpperCase(),
                  style: GoogleFonts.cinzel(
                    fontSize: 9,
                    letterSpacing: 2.5,
                    color: AppColors.gold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =====================================================
              // BIO
              // =====================================================

              Text(
                widget.bio,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: AppColors.textMuted,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/


// ============================================================
// widgets/person_card.dart — ScreenUtil responsive
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme/app_theme.dart';

class PersonCard extends StatefulWidget {
  final String imagePath;
  final String name;
  final String role;
  final String bio;

  const PersonCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.role,
    required this.bio,
  });

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:   (_) => setState(() => _hovered = true),
      onTapUp:     (_) => setState(() => _hovered = false),
      onTapCancel: ()  => setState(() => _hovered = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: _hovered
                  ? AppColors.gold.withValues(alpha: 0.5)
                  : AppColors.gold.withValues(alpha: 0.15),
              width: _hovered ? 1.5 : 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: _hovered ? 0.07 : 0.03),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),
            boxShadow: _hovered
                ? [BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.12),
              blurRadius: 30,
              spreadRadius: 2,
            )]
                : [],
          ),
          child: Column(
            children: [
              // ── PROFILE IMAGE ────────────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 90.w,
                height: 90.w,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD27D), Color(0xFFC9A227)],
                  ),
                  boxShadow: _hovered
                      ? [BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.25),
                    blurRadius: 25,
                    spreadRadius: 3,
                  )]
                      : [],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // ── NAME ─────────────────────────────────────
              Text(
                widget.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textLight,
                ),
              ),

              SizedBox(height: 6.h),

              // ── ROLE BADGE ───────────────────────────────
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.gold.withValues(alpha: 0.08),
                  border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.15)),
                ),
                child: Text(
                  widget.role.toUpperCase(),
                  style: GoogleFonts.cinzel(
                    fontSize: 8.sp,
                    letterSpacing: 2.5,
                    color: AppColors.gold,
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // ── BIO ──────────────────────────────────────
              Text(
                widget.bio,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 12.sp,
                  fontStyle: FontStyle.italic,
                  color: AppColors.textMuted,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}