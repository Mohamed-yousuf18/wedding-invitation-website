/*
// ============================================================
// widgets/glassmorphism_card.dart
//
// A frosted-glass style card using BackdropFilter + blur.
// Used for countdown boxes, event cards, profile sections.
//
// HOW GLASSMORPHISM WORKS IN FLUTTER:
//   BackdropFilter(filter: ImageFilter.blur(...))
//   + semi-transparent Container background
//   + subtle border
//   = frosted glass look
// ============================================================

import 'dart:ui';
import 'package:flutter/material.dart';
import '../app/theme/app_theme.dart';

class GlassmorphismCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blurAmount;

  const GlassmorphismCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 12,
    this.blurAmount = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        // This blurs everything BEHIND the card (gives glass effect)
        filter: ImageFilter.blur(
          sigmaX: blurAmount,
          sigmaY: blurAmount,
        ),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            // Semi-transparent white tint
            color: Colors.white.withValues(alpha:0.05),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              // Gold-tinted subtle border
              color: AppColors.gold.withValues(alpha:0.18),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}*/


// ============================================================
// widgets/glassmorphism_card.dart — ScreenUtil responsive
// ============================================================

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app/theme/app_theme.dart';

class GlassmorphismCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blurAmount;

  const GlassmorphismCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = 12,
    this.blurAmount = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurAmount,
          sigmaY: blurAmount,
        ),
        child: Container(
          width: width,
          height: height,
          // Use passed padding or default with ScreenUtil
          padding: padding ?? EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(borderRadius.r),
            border: Border.all(
              color: AppColors.gold.withValues(alpha: 0.18),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}