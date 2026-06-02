/*
// ============================================================
// widgets/section_header.dart
//
// Used at the top of every section (Our Story, Events, etc.)
// Shows:   small label (CINZEL font, gold)
//          big title   (Cormorant Garamond, cream)
//          gold ornament rule below
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Small label above title (e.g. "Chapter One")
        Text(
          label.toUpperCase(),
          style: GoogleFonts.cinzel(
            fontSize: 10,
            letterSpacing: 3.0,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(height: 10),

        // Big section title
        Text(
          title,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 38,
            fontWeight: FontWeight.w300,
            color: AppColors.textLight,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Gold ornament divider
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _rule(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '✦',
                style: TextStyle(
                  color: AppColors.gold.withValues(alpha:0.7),
                  fontSize: 12,
                ),
              ),
            ),
            _rule(),
          ],
        ),
      ],
    );
  }

  Widget _rule() => Container(
    width: 60,
    height: 0.8,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.transparent,
          AppColors.gold.withValues(alpha:0.5),
          Colors.transparent,
        ],
      ),
    ),
  );
}*/


// ============================================================
// widgets/section_header.dart — ScreenUtil responsive
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Small label
        Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            fontSize: 10.sp,
            letterSpacing: 3.0,
            color: AppColors.gold,
          ),
        ),
        SizedBox(height: 10.h),

        // Big section title
        Text(
          title,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 34.sp,
            fontWeight: FontWeight.w300,
            color: AppColors.textLight,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),

        // Gold ornament divider
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _rule(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                '✦',
                style: TextStyle(
                  color: AppColors.gold.withValues(alpha: 0.7),
                  fontSize: 12.sp,
                ),
              ),
            ),
            _rule(),
          ],
        ),
      ],
    );
  }

  Widget _rule() => Container(
    width: 60.w,
    height: 0.8,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.transparent,
          AppColors.gold.withValues(alpha: 0.5),
          Colors.transparent,
        ],
      ),
    ),
  );
}