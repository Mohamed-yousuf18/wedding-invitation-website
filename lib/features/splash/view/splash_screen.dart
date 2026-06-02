// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:my_wedding_app/app/theme/app_theme.dart';
// import 'package:my_wedding_app/features/splash/controller/splash_controller.dart';
// import 'package:my_wedding_app/widgets/floating_hearts_widget.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<SplashController>();
//
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: RadialGradient(
//             center: Alignment.center,
//             radius: 1.2,
//             colors: [Color(0xFF2D0E1A), Color(0xFF0D0407)],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Layer 1: Floating hearts
//             const FloatingHeartsWidget(),
//
//             // Layer 2: Center content
//             Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//                     // ── RINGS + HEART ICON ──────────────────
//                     Obx(() => AnimatedOpacity(
//                       duration: const Duration(milliseconds: 800),
//                       opacity: controller.logoOpacity.value,
//                       child: AnimatedScale(
//                         duration: const Duration(milliseconds: 800),
//                         scale: controller.logoScale.value,
//                         curve: Curves.elasticOut,
//                         child: _buildRingsIcon(),
//                       ),
//                     )),
//
//                     const SizedBox(height: 32),
//
//                     // ── GROOM NAME + QUALIFICATIONS ─────────
//                     Obx(() => AnimatedOpacity(
//                       duration: const Duration(milliseconds: 700),
//                       opacity: controller.titleOpacity.value,
//                       child: Column(
//                         children: [
//                           // Groom name
//                           Text(
//                             'Mohamed Yousuf',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.cormorantGaramond(
//                               fontSize: 30,
//                               fontWeight: FontWeight.w300,
//                               color: AppColors.goldLight,
//                               letterSpacing: 2,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//
//                           // Groom qualification + role
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               _qualBadge('M.Sc.,', isGroom: true),
//                               const SizedBox(width: 6),
//                               Text('·',
//                                 style: TextStyle(
//                                   color: AppColors.gold.withValues(alpha: 0.4),
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 'Software Developer',
//                                 style: GoogleFonts.lato(
//                                   fontSize: 11,
//                                   color: AppColors.rose.withValues(alpha: 0.65),
//                                   fontStyle: FontStyle.italic,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           const SizedBox(height: 16),
//
//                           // Ampersand
//                           Text(
//                             '&',
//                             style: GoogleFonts.cormorantGaramond(
//                               fontSize: 22,
//                               fontStyle: FontStyle.italic,
//                               color: AppColors.rose,
//                             ),
//                           ),
//
//                           const SizedBox(height: 16),
//
//                           // Bride name
//                           Text(
//                             'Hajima Bee',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.cormorantGaramond(
//                               fontSize: 30,
//                               fontWeight: FontWeight.w300,
//                               color: AppColors.goldLight,
//                               letterSpacing: 2,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//
//                           // Bride qualifications + role
//                           Wrap(
//                             alignment: WrapAlignment.center,
//                             spacing: 6,
//                             runSpacing: 4,
//                             children: [
//                               _qualBadge('B.Sc,', isGroom: false),
//                               _qualBadge('MBA.,', isGroom: false),
//                               Text('·',
//                                 style: TextStyle(
//                                   color: AppColors.gold.withValues(alpha: 0.4),
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               Text(
//                                 'Muballiga',
//                                 style: GoogleFonts.lato(
//                                   fontSize: 11,
//                                   color: AppColors.rose.withValues(alpha: 0.65),
//                                   fontStyle: FontStyle.italic,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )),
//
//                     const SizedBox(height: 16),
//
//                     // ── DATE SUBTITLE ───────────────────────
//                     Obx(() => AnimatedOpacity(
//                       duration: const Duration(milliseconds: 700),
//                       opacity: controller.subtitleOpacity.value,
//                       child: Column(
//                         children: [
//                           Text(
//                             'Nikkah Invitation',
//                             style: GoogleFonts.cinzel(
//                               fontSize: 11,
//                               color: AppColors.gold.withValues(alpha: 0.7),
//                               letterSpacing: 3,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'July 05, 2026  ·  10:30 AM',
//                             style: GoogleFonts.cormorantGaramond(
//                               fontSize: 14,
//                               color: AppColors.rose.withValues(alpha: 0.6),
//                               fontStyle: FontStyle.italic,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//
//                     const SizedBox(height: 40),
//
//                     // ── OPEN INVITATION BUTTON ──────────────
//                     Obx(() => AnimatedOpacity(
//                       duration: const Duration(milliseconds: 700),
//                       opacity: controller.subtitleOpacity.value,
//                       child: GestureDetector(
//                         onTap: () => controller.enterWithMusic(),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 40, vertical: 16,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             gradient: const LinearGradient(
//                               colors: [
//                                 AppColors.goldDark,
//                                 AppColors.gold,
//                                 AppColors.goldLight,
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AppColors.gold.withValues(alpha: 0.45),
//                                 blurRadius: 24,
//                                 spreadRadius: 2,
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(
//                                 Icons.favorite,
//                                 color: Color(0xFF1A0A05),
//                                 size: 16,
//                               ),
//                               const SizedBox(width: 10),
//                               Text(
//                                 'Open Invitation',
//                                 style: GoogleFonts.cinzel(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                   letterSpacing: 2.5,
//                                   color: const Color(0xFF1A0A05),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Layer 3: Loading dots (before button appears)
//             Positioned(
//               bottom: 48,
//               left: 0,
//               right: 0,
//               child: Obx(() => AnimatedOpacity(
//                 duration: const Duration(milliseconds: 400),
//                 opacity: controller.subtitleOpacity.value > 0 ? 0.0 : 1.0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _loadingDot(delay: 0),
//                     const SizedBox(width: 8),
//                     _loadingDot(delay: 200),
//                     const SizedBox(width: 8),
//                     _loadingDot(delay: 400),
//                   ],
//                 ),
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ── QUALIFICATION BADGE ──────────────────────────────────
//   Widget _qualBadge(String text, {required bool isGroom}) {
//     final color = isGroom ? AppColors.gold : AppColors.rose;
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withValues(alpha: 0.35)),
//         color: color.withValues(alpha: 0.06),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.cinzel(
//           fontSize: 9,
//           color: color.withValues(alpha: 0.85),
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }
//
//   // ── RINGS ICON ───────────────────────────────────────────
//   Widget _buildRingsIcon() {
//     return SizedBox(
//       width: 140,
//       height: 100,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Positioned(
//             left: 10,
//             child: Container(
//               width: 72,
//               height: 72,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: AppColors.gold, width: 3),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.gold.withValues(alpha: 0.4),
//                     blurRadius: 20,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             child: Container(
//               width: 72,
//               height: 72,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: AppColors.goldLight, width: 3),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.goldLight.withValues(alpha: 0.4),
//                     blurRadius: 20,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const Text('💗', style: TextStyle(fontSize: 32)),
//         ],
//       ),
//     );
//   }
//
//   // ── LOADING DOT ──────────────────────────────────────────
//   Widget _loadingDot({required int delay}) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.3, end: 1.0),
//       duration: Duration(milliseconds: 600 + delay),
//       builder: (context, val, _) {
//         return Container(
//           width: 6,
//           height: 6,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: AppColors.gold.withValues(alpha: val),
//           ),
//         );
//       },
//     );
//   }
// }

// ============================================================
// features/splash/view/splash_screen.dart
// ScreenUtil responsive — mobile web friendly
// Mohamed Yousuf & Hajima Bee
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_wedding_app/app/theme/app_theme.dart';
import 'package:my_wedding_app/features/splash/controller/splash_controller.dart';
import 'package:my_wedding_app/widgets/floating_hearts_widget.dart';

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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // ── RINGS + HEART ICON ──────────────────
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

                      SizedBox(height: 32.h),

                      // ── GROOM NAME + QUALIFICATIONS ─────────
                      Obx(() => AnimatedOpacity(
                        duration: const Duration(milliseconds: 700),
                        opacity: controller.titleOpacity.value,
                        child: Column(
                          children: [
                            // Groom name
                            Text(
                              'Mohamed Yousuf',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w300,
                                color: AppColors.goldLight,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 6.h),

                            // Groom qualification + role
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _qualBadge('M.Sc.,', isGroom: true),
                                SizedBox(width: 6.w),
                                Text(
                                  '·',
                                  style: TextStyle(
                                    color: AppColors.gold.withValues(alpha: 0.4),
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Software Developer',
                                  style: GoogleFonts.lato(
                                    fontSize: 11.sp,
                                    color: AppColors.rose.withValues(alpha: 0.65),
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            // Ampersand
                            Text(
                              '&',
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 22.sp,
                                fontStyle: FontStyle.italic,
                                color: AppColors.rose,
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Bride name
                            Text(
                              'Hajima Bee',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w300,
                                color: AppColors.goldLight,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 6.h),

                            // Bride qualifications + role
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 6.w,
                              runSpacing: 4.h,
                              children: [
                                _qualBadge('B.Sc,', isGroom: false),
                                _qualBadge('MBA.,', isGroom: false),
                                // Text(
                                //   '·',
                                //   style: TextStyle(
                                //     color: AppColors.gold.withValues(alpha: 0.4),
                                //     fontSize: 14.sp,
                                //   ),
                                // ),
                                _qualBadge('Muballiga', isGroom: false),
                                // Text(
                                //   'Muballiga',
                                //   style: GoogleFonts.lato(
                                //     fontSize: 11.sp,
                                //     color: AppColors.rose.withValues(alpha: 0.65),
                                //     fontStyle: FontStyle.italic,
                                //     letterSpacing: 0.5,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      )),

                      SizedBox(height: 16.h),

                      // ── DATE SUBTITLE ───────────────────────
                      Obx(() => AnimatedOpacity(
                        duration: const Duration(milliseconds: 700),
                        opacity: controller.subtitleOpacity.value,
                        child: Column(
                          children: [
                            Text(
                              'Nikkah Invitation',
                              style: GoogleFonts.cinzel(
                                fontSize: 11.sp,
                                color: AppColors.gold.withValues(alpha: 0.7),
                                letterSpacing: 3,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'July 05, 2026  ·  10:30 AM',
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 14.sp,
                                color: AppColors.rose.withValues(alpha: 0.6),
                                fontStyle: FontStyle.italic,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      )),

                      SizedBox(height: 40.h),

                      // ── OPEN INVITATION BUTTON ──────────────
                      Obx(() => AnimatedOpacity(
                        duration: const Duration(milliseconds: 700),
                        opacity: controller.subtitleOpacity.value,
                        child: GestureDetector(
                          onTap: () => controller.enterWithMusic(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                              vertical: 16.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
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
                                Icon(
                                  Icons.favorite,
                                  color: const Color(0xFF1A0A05),
                                  size: 16.sp,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Open Invitation',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 12.sp,
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

                      SizedBox(height: 60.h),
                    ],
                  ),
                ),
              ),
            ),

            // Layer 3: Loading dots (before button appears)
            Positioned(
              bottom: 48.h,
              left: 0,
              right: 0,
              child: Obx(() => AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: controller.subtitleOpacity.value > 0 ? 0.0 : 1.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _loadingDot(delay: 0),
                    SizedBox(width: 8.w),
                    _loadingDot(delay: 200),
                    SizedBox(width: 8.w),
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

  // ── QUALIFICATION BADGE ──────────────────────────────────
  Widget _qualBadge(String text, {required bool isGroom}) {
    final color = isGroom ? AppColors.gold : AppColors.rose;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.35)),
        color: color.withValues(alpha: 0.06),
      ),
      child: Text(
        text,
        style: GoogleFonts.cinzel(
          fontSize: 9.sp,
          color: color.withValues(alpha: 0.85),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // ── RINGS ICON ───────────────────────────────────────────
  Widget _buildRingsIcon() {
    return SizedBox(
      width: 140.w,
      height: 100.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 10.w,
            child: Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.gold,
                  width: 3.w,
                ),
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
            right: 10.w,
            child: Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.goldLight,
                  width: 3.w,
                ),
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
          Text(
            '💗',
            style: TextStyle(fontSize: 32.sp),
          ),
        ],
      ),
    );
  }

  // ── LOADING DOT ──────────────────────────────────────────
  Widget _loadingDot({required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      builder: (context, val, _) {
        return Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gold.withValues(alpha: val),
          ),
        );
      },
    );
  }
}