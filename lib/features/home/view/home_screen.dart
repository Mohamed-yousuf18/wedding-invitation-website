// /*
// // ============================================================
// // features/home/view/home_screen.dart
// // Updated for: Mohamed Yousuf & Hajima Bee
// // ============================================================
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:confetti/confetti.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controller/home_controller.dart';
// import '../../../app/theme/app_theme.dart';
// import '../../../widgets/floating_hearts_widget.dart';
// import '../../../widgets/glassmorphism_card.dart';
// import '../../../widgets/gold_button.dart';
// import '../../../features/music/controller/music_controller.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
//     with TickerProviderStateMixin {
//
//   late final HomeController controller;
//   late final MusicController musicController;
//   late final ConfettiController _confettiController;
//   late final AnimationController _heroAnimController;
//   late final Animation<double> _heroFadeAnim;
//   late final Animation<Offset> _heroSlideAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     controller      = Get.find<HomeController>();
//     musicController = Get.find<MusicController>();
//
//     _confettiController = ConfettiController(
//       duration: const Duration(seconds: 4),
//     );
//
//     _heroAnimController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _heroFadeAnim = CurvedAnimation(
//       parent: _heroAnimController,
//       curve: Curves.easeOut,
//     );
//
//     _heroSlideAnim = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _heroAnimController,
//       curve: Curves.easeOut,
//     ));
//
//     ever(controller.showHeroContent, (bool show) {
//       if (show) _heroAnimController.forward();
//     });
//
//     ever(controller.showConfetti, (bool show) {
//       if (show) {
//         _confettiController.play();
//         musicController.startMusic();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _confettiController.dispose();
//     _heroAnimController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _buildBackground(),
//           const FloatingHeartsWidget(),
//           Obx(() => controller.showHeroContent.value
//               ? _buildHeroContent()
//               : const SizedBox.shrink()),
//           Obx(() => controller.showSpotlight.value
//               ? _buildSpotlight()
//               : const SizedBox.shrink()),
//           Align(
//             alignment: Alignment.topCenter,
//             child: ConfettiWidget(
//               confettiController: _confettiController,
//               blastDirectionality: BlastDirectionality.explosive,
//               numberOfParticles: 30,
//               colors: const [
//                 AppColors.gold,
//                 AppColors.rose,
//                 AppColors.goldLight,
//                 Colors.white,
//               ],
//               gravity: 0.3,
//             ),
//           ),
//           Positioned(
//             bottom: 32,
//             right: 20,
//             child: _buildMusicButton(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBackground() {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(seconds: 3),
//       builder: (context, value, child) {
//         return Container(
//           decoration: BoxDecoration(
//             gradient: RadialGradient(
//               center: const Alignment(0, -0.3),
//               radius: 1.4,
//               colors: [
//                 Color.lerp(const Color(0xFF1A0810),
//                     const Color(0xFF3D1525), value)!,
//                 const Color(0xFF1A0A05),
//                 const Color(0xFF0D0407),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // ── SPOTLIGHT INTRO — shows groom & bride names ───────────
//   Widget _buildSpotlight() {
//     return Obx(() => AnimatedOpacity(
//       duration: const Duration(milliseconds: 800),
//       opacity: controller.spotlightOpacity.value,
//       child: Container(
//         color: Colors.black,
//         child: Stack(
//           children: [
//             Center(
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [
//                       Colors.white.withValues(alpha:0.08),
//                       Colors.transparent,
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Center(
//               child: Obx(() => AnimatedOpacity(
//                 duration: const Duration(milliseconds: 1000),
//                 opacity: controller.namesOpacity.value,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // ✅ GROOM NAME
//                     Text(
//                       'Mohamed Yousuf',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.cormorantGaramond(
//                         fontSize: 38,
//                         fontWeight: FontWeight.w300,
//                         color: AppColors.goldLight,
//                         letterSpacing: 2,
//                       ),
//                     ),
//                     Text(
//                       '&',
//                       style: GoogleFonts.cormorantGaramond(
//                         fontSize: 28,
//                         fontStyle: FontStyle.italic,
//                         color: AppColors.rose,
//                         letterSpacing: 2,
//                       ),
//                     ),
//                     // ✅ BRIDE NAME
//                     Text(
//                       'Hajima Bee',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.cormorantGaramond(
//                         fontSize: 38,
//                         fontWeight: FontWeight.w300,
//                         color: AppColors.goldLight,
//                         letterSpacing: 2,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       'invite you to celebrate',
//                       style: GoogleFonts.cormorantGaramond(
//                         fontSize: 16,
//                         fontStyle: FontStyle.italic,
//                         color: AppColors.rose.withValues(alpha:0.7),
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//             ),
//             Positioned(
//               bottom: 48,
//               right: 24,
//               child: TextButton(
//                 onPressed: () => controller.showSpotlight.value = false,
//                 child: Text(
//                   'Skip',
//                   style: GoogleFonts.lato(
//                     color: Colors.white.withValues(alpha:0.4),
//                     fontSize: 12,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   Widget _buildHeroContent() {
//     return FadeTransition(
//       opacity: _heroFadeAnim,
//       child: SlideTransition(
//         position: _heroSlideAnim,
//         child: SingleChildScrollView(
//           child: SafeArea(
//             child: Column(
//               children: [
//                 const SizedBox(height: 40),
//                 _buildDateBadge(),
//                 const SizedBox(height: 32),
//                 _buildCouplePhoto(),
//                 const SizedBox(height: 8),
//                 Text(
//                   '✦  ✦  ✦',
//                   style: TextStyle(
//                     color: AppColors.gold.withValues(alpha:0.7),
//                     letterSpacing: 8,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildCoupleNames(),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Two hearts, one beautiful beginning',
//                   style: GoogleFonts.cormorantGaramond(
//                     fontSize: 17,
//                     fontStyle: FontStyle.italic,
//                     color: AppColors.rose.withValues(alpha:0.85),
//                     letterSpacing: 0.5,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),
//                 _buildCountdown(),
//                 const SizedBox(height: 40),
//                 GoldButton(
//                   label: 'Open Invitation  ✦',
//                   onPressed: controller.openInvitation,
//                 ),
//                 const SizedBox(height: 48),
//                 Column(
//                   children: [
//                     Text(
//                       'SCROLL TO EXPLORE',
//                       style: GoogleFonts.cinzel(
//                         fontSize: 9,
//                         letterSpacing: 3,
//                         color: AppColors.gold.withValues(alpha:0.4),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     TweenAnimationBuilder<double>(
//                       tween: Tween(begin: 0.0, end: 8.0),
//                       duration: const Duration(milliseconds: 1000),
//                       curve: Curves.easeInOut,
//                       builder: (_, val, child) => Transform.translate(
//                         offset: Offset(0, val),
//                         child: child,
//                       ),
//                       child: Icon(
//                         Icons.keyboard_arrow_down,
//                         color: AppColors.gold.withValues(alpha:0.4),
//                         size: 22,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 32),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ✅ UPDATED DATE BADGE
//   Widget _buildDateBadge() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppColors.gold.withValues(alpha:0.3)),
//       ),
//       child: Text(
//         'JULY 05, 2026  ·  10:30 AM',
//         style: GoogleFonts.cinzel(
//           fontSize: 10,
//           letterSpacing: 2.5,
//           color: AppColors.gold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCouplePhoto() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: 190,
//           height: 190,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: RadialGradient(
//               colors: [
//                 AppColors.gold.withValues(alpha:0.15),
//                 Colors.transparent,
//               ],
//             ),
//           ),
//         ),
//         Container(
//           width: 160,
//           height: 160,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: const LinearGradient(
//               colors: [Color(0xFF4A1828), Color(0xFF2D0E1A)],
//             ),
//             border: Border.all(
//               color: AppColors.gold.withValues(alpha:0.5),
//               width: 3,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.gold.withValues(alpha:0.2),
//                 blurRadius: 30,
//                 spreadRadius: 5,
//               ),
//             ],
//           ),
//           child: const Center(
//             child: Text('💑', style: TextStyle(fontSize: 64)),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ✅ UPDATED COUPLE NAMES
//   Widget _buildCoupleNames() {
//     return Column(
//       children: [
//         Text(
//           'Mohamed Yousuf',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.cormorantGaramond(
//             fontSize: 42,
//             fontWeight: FontWeight.w300,
//             color: AppColors.textLight,
//             height: 1.0,
//             letterSpacing: 1.5,
//           ),
//         ),
//         Text(
//           '&',
//           style: GoogleFonts.cormorantGaramond(
//             fontSize: 32,
//             fontStyle: FontStyle.italic,
//             color: AppColors.gold,
//             height: 1.0,
//           ),
//         ),
//         Text(
//           'Hajima Bee',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.cormorantGaramond(
//             fontSize: 42,
//             fontWeight: FontWeight.w300,
//             color: AppColors.textLight,
//             height: 1.0,
//             letterSpacing: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCountdown() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Obx(() => _countdownBox(controller.days.value, 'DAYS')),
//         _countdownDivider(),
//         Obx(() => _countdownBox(controller.hours.value, 'HOURS')),
//         _countdownDivider(),
//         Obx(() => _countdownBox(controller.minutes.value, 'MINS')),
//         _countdownDivider(),
//         Obx(() => _countdownBox(controller.seconds.value, 'SECS')),
//       ],
//     );
//   }
//
//   Widget _countdownBox(String value, String label) {
//     return GlassmorphismCard(
//       width: 72,
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
//       child: Column(
//         children: [
//           Text(value, style: AppTextStyles.countdownNum),
//           const SizedBox(height: 4),
//           Text(label, style: AppTextStyles.countdownLabel),
//         ],
//       ),
//     );
//   }
//
//   Widget _countdownDivider() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       child: Text(
//         ':',
//         style: GoogleFonts.cinzel(
//           fontSize: 28,
//           color: AppColors.gold.withValues(alpha:0.4),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMusicButton() {
//     return Obx(() => GestureDetector(
//       onTap: musicController.toggleMusic,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         width: 52,
//         height: 52,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: AppColors.gold.withValues(alpha:
//               musicController.isPlaying.value ? 0.8 : 0.4,
//             ),
//             width: 1.5,
//           ),
//           color: Colors.black.withValues(alpha:0.3),
//           boxShadow: musicController.isPlaying.value
//               ? [BoxShadow(
//             color: AppColors.gold.withValues(alpha:0.3),
//             blurRadius: 16,
//             spreadRadius: 2,
//           )]
//               : [],
//         ),
//         child: Icon(
//           musicController.isPlaying.value
//               ? Icons.music_note
//               : Icons.music_off,
//           color: musicController.isPlaying.value
//               ? AppColors.goldLight
//               : AppColors.gold.withValues(alpha:0.5),
//           size: 22,
//         ),
//       ),
//     ));
//   }
// }*/
// // ============================================================
// // features/home/view/home_screen.dart
// // Mohamed Yousuf & Hajima Bee
// //
// // MUSIC FIX: Spotlight-ல separate button இல்லை.
// // "Open Invitation ✦" button tap = music start + navigate
// // ============================================================
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:confetti/confetti.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controller/home_controller.dart';
// import '../../../app/theme/app_theme.dart';
// import '../../../widgets/floating_hearts_widget.dart';
// import '../../../widgets/glassmorphism_card.dart';
// import '../../../widgets/gold_button.dart';
// import '../../../features/music/controller/music_controller.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
//     with TickerProviderStateMixin {
//
//   late final HomeController controller;
//   late final MusicController musicController;
//   late final ConfettiController _confettiController;
//   late final AnimationController _heroAnimController;
//   late final Animation<double> _heroFadeAnim;
//   late final Animation<Offset> _heroSlideAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     controller      = Get.find<HomeController>();
//     musicController = Get.find<MusicController>();
//
//     _confettiController = ConfettiController(
//       duration: const Duration(seconds: 4),
//     );
//
//     _heroAnimController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _heroFadeAnim = CurvedAnimation(
//       parent: _heroAnimController,
//       curve: Curves.easeOut,
//     );
//
//     _heroSlideAnim = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _heroAnimController,
//       curve: Curves.easeOut,
//     ));
//
//     ever(controller.showHeroContent, (bool show) {
//       if (show) _heroAnimController.forward();
//     });
//
//     ever(controller.showConfetti, (bool show) {
//       if (show) _confettiController.play();
//     });
//   }
//
//   @override
//   void dispose() {
//     _confettiController.dispose();
//     _heroAnimController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _buildBackground(),
//           const FloatingHeartsWidget(),
//
//           // Spotlight screen — names காட்டுவோம்
//           Obx(() => controller.showSpotlight.value
//               ? _buildSpotlight()
//               : const SizedBox.shrink()),
//
//           // Home content — countdown + Open Invitation button
//           Obx(() => controller.showHeroContent.value
//               ? _buildHeroContent()
//               : const SizedBox.shrink()),
//
//           // Confetti
//           Align(
//             alignment: Alignment.topCenter,
//             child: ConfettiWidget(
//               confettiController: _confettiController,
//               blastDirectionality: BlastDirectionality.explosive,
//               numberOfParticles: 30,
//               colors: const [
//                 AppColors.gold, AppColors.rose,
//                 AppColors.goldLight, Colors.white,
//               ],
//               gravity: 0.3,
//             ),
//           ),
//
//           // Music FAB — bottom right
//           Positioned(
//             bottom: 32,
//             right: 20,
//             child: _buildMusicFab(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ══════════════════════════════════════════════════════
//   // SPOTLIGHT — Just names, auto hide பண்ணும்
//   // Controller-ல timer வச்சிருக்கோம் — 3 sec-ல hide ஆகும்
//   // ══════════════════════════════════════════════════════
//   Widget _buildSpotlight() {
//     return Container(
//       color: Colors.black,
//       child: Stack(
//         children: [
//           // Soft center glow
//           Center(
//             child: Container(
//               width: 320,
//               height: 320,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [
//                     Colors.white.withValues(alpha:0.07),
//                     Colors.transparent,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Names
//           Center(
//             child: Obx(() => AnimatedOpacity(
//               duration: const Duration(milliseconds: 800),
//               opacity: controller.namesOpacity.value,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
//                     style: GoogleFonts.cormorantGaramond(
//                       fontSize: 18,
//                       color: AppColors.gold.withValues(alpha:0.65),
//                       letterSpacing: 1,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   Text(
//                     'Mohamed Yousuf',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.cormorantGaramond(
//                       fontSize: 40,
//                       fontWeight: FontWeight.w300,
//                       color: AppColors.goldLight,
//                       letterSpacing: 2,
//                     ),
//                   ),
//                   Text(
//                     '&',
//                     style: GoogleFonts.cormorantGaramond(
//                       fontSize: 28,
//                       fontStyle: FontStyle.italic,
//                       color: AppColors.rose,
//                     ),
//                   ),
//                   Text(
//                     'Hajima Bee',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.cormorantGaramond(
//                       fontSize: 40,
//                       fontWeight: FontWeight.w300,
//                       color: AppColors.goldLight,
//                       letterSpacing: 2,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'invite you to their wedding',
//                     style: GoogleFonts.cormorantGaramond(
//                       fontSize: 15,
//                       fontStyle: FontStyle.italic,
//                       color: AppColors.rose.withValues(alpha:0.55),
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ],
//               ),
//             )),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ══════════════════════════════════════════════════════
//   // HOME CONTENT
//   // "Open Invitation ✦" button → music start + navigate
//   // ══════════════════════════════════════════════════════
//   Widget _buildHeroContent() {
//     return FadeTransition(
//       opacity: _heroFadeAnim,
//       child: SlideTransition(
//         position: _heroSlideAnim,
//         child: SingleChildScrollView(
//           child: SafeArea(
//             child: Column(
//               children: [
//                 const SizedBox(height: 40),
//                 _buildDateBadge(),
//                 const SizedBox(height: 32),
//                 _buildCouplePhoto(),
//                 const SizedBox(height: 8),
//                 Text(
//                   '✦  ✦  ✦',
//                   style: TextStyle(
//                     color: AppColors.gold.withValues(alpha:0.7),
//                     letterSpacing: 8,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildCoupleNames(),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Two hearts, one beautiful beginning',
//                   style: GoogleFonts.cormorantGaramond(
//                     fontSize: 17,
//                     fontStyle: FontStyle.italic,
//                     color: AppColors.rose.withValues(alpha:0.85),
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),
//                 _buildCountdown(),
//                 const SizedBox(height: 40),
//
//                 // ══════════════════════════════════════════
//                 // "Open Invitation ✦" — tap பண்ணும்போது
//                 //   1. music start
//                 //   2. confetti
//                 //   3. invite screen navigate
//                 // ══════════════════════════════════════════
//                 GoldButton(
//                   label: 'Step Into Forever  ➤',
//                   onPressed: () {
//                     // Music start — user gesture இருக்கு so browser allow
//
//
//                     // Confetti + navigate
//                     controller.openInvitation();
//                   },
//                 ),
//
//                 const SizedBox(height: 48),
//                 // Column(
//                 //   children: [
//                 //     Text(
//                 //       'SCROLL TO EXPLORE',
//                 //       style: GoogleFonts.cinzel(
//                 //         fontSize: 9,
//                 //         letterSpacing: 3,
//                 //         color: AppColors.gold.withValues(alpha:0.4),
//                 //       ),
//                 //     ),
//                 //     const SizedBox(height: 6),
//                 //     TweenAnimationBuilder<double>(
//                 //       tween: Tween(begin: 0.0, end: 8.0),
//                 //       duration: const Duration(milliseconds: 1000),
//                 //       curve: Curves.easeInOut,
//                 //       builder: (_, val, child) => Transform.translate(
//                 //         offset: Offset(0, val),
//                 //         child: child,
//                 //       ),
//                 //       child: Icon(
//                 //         Icons.keyboard_arrow_down,
//                 //         color: AppColors.gold.withValues(alpha:0.4),
//                 //         size: 22,
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 // const SizedBox(height: 80),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBackground() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: RadialGradient(
//           center: Alignment(0, -0.3),
//           radius: 1.4,
//           colors: [
//             Color(0xFF3D1525),
//             Color(0xFF1A0A05),
//             Color(0xFF0D0407),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDateBadge() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppColors.gold.withValues(alpha:0.3)),
//       ),
//       child: Text(
//         'JULY 05, 2026  ·  10:30 AM',
//         style: GoogleFonts.cinzel(
//           fontSize: 10,
//           letterSpacing: 2.5,
//           color: AppColors.gold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCouplePhoto() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: 190,
//           height: 190,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: RadialGradient(
//               colors: [
//                 AppColors.gold.withValues(alpha:0.15),
//                 Colors.transparent,
//               ],
//             ),
//           ),
//         ),
//         Container(
//           width: 160,
//           height: 160,
//
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//
//             gradient: const LinearGradient(
//               colors: [
//                 Color(0xFF4A1828),
//                 Color(0xFF2D0E1A),
//               ],
//             ),
//
//             border: Border.all(
//               color: AppColors.gold.withValues(alpha: 0.5),
//               width: 3,
//             ),
//
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.gold.withValues(alpha: 0.2),
//                 blurRadius: 30,
//                 spreadRadius: 5,
//               ),
//             ],
//           ),
//
//           child: ClipOval(
//             child: Image.asset(
//               "assets/images/COUPLE_II.png",
//
//               fit: BoxFit.cover,
//
//               // ✅ NULL / ERROR HANDLE
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   color: const Color(0xFF2D0E1A),
//
//                   child: const Center(
//                     child: Icon(
//                       Icons.favorite,
//                       color: Colors.white54,
//                       size: 50,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget _buildCoupleNames() {
//     return Column(
//       children: [
//         Text(
//           'Mohamed Yousuf',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.cormorantGaramond(
//             fontSize: 42,
//             fontWeight: FontWeight.w300,
//             color: AppColors.textLight,
//             height: 1.0,
//             letterSpacing: 1.5,
//           ),
//         ),
//         Text(
//           '&',
//           style: GoogleFonts.cormorantGaramond(
//             fontSize: 32,
//             fontStyle: FontStyle.italic,
//             color: AppColors.gold,
//             height: 1.0,
//           ),
//         ),
//         Text(
//           'Hajima Bee',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.cormorantGaramond(
//             fontSize: 42,
//             fontWeight: FontWeight.w300,
//             color: AppColors.textLight,
//             height: 1.0,
//             letterSpacing: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCountdown() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Obx(() => _cdBox(controller.days.value, 'DAYS')),
//         _cdDivider(),
//         Obx(() => _cdBox(controller.hours.value, 'HOURS')),
//         _cdDivider(),
//         Obx(() => _cdBox(controller.minutes.value, 'MINS')),
//         _cdDivider(),
//         Obx(() => _cdBox(controller.seconds.value, 'SECS')),
//       ],
//     );
//   }
//
//   Widget _cdBox(String value, String label) {
//     return GlassmorphismCard(
//       width: 72,
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
//       child: Column(
//         children: [
//           Text(value, style: AppTextStyles.countdownNum),
//           const SizedBox(height: 4),
//           Text(label, style: AppTextStyles.countdownLabel),
//         ],
//       ),
//     );
//   }
//
//   Widget _cdDivider() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       child: Text(
//         ':',
//         style: GoogleFonts.cinzel(
//           fontSize: 28,
//           color: AppColors.gold.withValues(alpha:0.4),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMusicFab() {
//     return Obx(() {
//       final playing = musicController.isPlaying.value;
//       return GestureDetector(
//         onTap: musicController.toggleMusic,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           width: 52,
//           height: 52,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: AppColors.gold.withValues(alpha:playing ? 0.8 : 0.4),
//               width: 1.5,
//             ),
//             color: Colors.black.withValues(alpha:0.4),
//             boxShadow: playing
//                 ? [BoxShadow(
//               color: AppColors.gold.withValues(alpha:0.3),
//               blurRadius: 16,
//               spreadRadius: 2,
//             )]
//                 : [],
//           ),
//           child: Icon(
//             playing ? Icons.music_note : Icons.music_note_outlined,
//             color: playing
//                 ? AppColors.goldLight
//                 : AppColors.gold.withValues(alpha:0.5),
//             size: 22,
//           ),
//         ),
//       );
//     });
//   }
// }

// ============================================================
// features/home/view/home_screen.dart
// ScreenUtil responsive — mobile web friendly
// Mohamed Yousuf & Hajima Bee
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/home_controller.dart';
import '../../../app/theme/app_theme.dart';
import '../../../widgets/floating_hearts_widget.dart';
import '../../../widgets/glassmorphism_card.dart';
import '../../../widgets/gold_button.dart';
import '../../../features/music/controller/music_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {

  late final HomeController controller;
  late final MusicController musicController;
  late final ConfettiController _confettiController;
  late final AnimationController _heroAnimController;
  late final Animation<double> _heroFadeAnim;
  late final Animation<Offset> _heroSlideAnim;

  @override
  void initState() {
    super.initState();
    controller      = Get.find<HomeController>();
    musicController = Get.find<MusicController>();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 4),
    );

    _heroAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _heroFadeAnim = CurvedAnimation(
      parent: _heroAnimController,
      curve: Curves.easeOut,
    );

    _heroSlideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _heroAnimController,
      curve: Curves.easeOut,
    ));

    ever(controller.showHeroContent, (bool show) {
      if (show) _heroAnimController.forward();
    });

    ever(controller.showConfetti, (bool show) {
      if (show) _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _heroAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          const FloatingHeartsWidget(),

          // Spotlight screen
          Obx(() => controller.showSpotlight.value
              ? _buildSpotlight()
              : const SizedBox.shrink()),

          // Home content
          Obx(() => controller.showHeroContent.value
              ? _buildHeroContent()
              : const SizedBox.shrink()),

          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 30,
              colors: const [
                AppColors.gold, AppColors.rose,
                AppColors.goldLight, Colors.white,
              ],
              gravity: 0.3,
            ),
          ),

          // Music FAB
          Positioned(
            bottom: 32.h,
            right: 20.w,
            child: _buildMusicFab(),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // SPOTLIGHT
  // ══════════════════════════════════════════════════════
  Widget _buildSpotlight() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 320.w,
              height: 320.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.07),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Obx(() => AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: controller.namesOpacity.value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 18.sp,
                        color: AppColors.gold.withValues(alpha: 0.65),
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      'Mohamed Yousuf',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.goldLight,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      '&',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 28.sp,
                        fontStyle: FontStyle.italic,
                        color: AppColors.rose,
                      ),
                    ),
                    Text(
                      'Hajima Bee',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.goldLight,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'invite you to their wedding',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 15.sp,
                        fontStyle: FontStyle.italic,
                        color: AppColors.rose.withValues(alpha: 0.55),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // HOME CONTENT
  // ══════════════════════════════════════════════════════
  Widget _buildHeroContent() {
    return FadeTransition(
      opacity: _heroFadeAnim,
      child: SlideTransition(
        position: _heroSlideAnim,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  _buildDateBadge(),
                  SizedBox(height: 32.h),
                  _buildCouplePhoto(),
                  SizedBox(height: 8.h),
                  Text(
                    '✦  ✦  ✦',
                    style: TextStyle(
                      color: AppColors.gold.withValues(alpha: 0.7),
                      letterSpacing: 8,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildCoupleNames(),
                  SizedBox(height: 12.h),
                  Text(
                    'Two hearts, one beautiful beginning',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 17.sp,
                      fontStyle: FontStyle.italic,
                      color: AppColors.rose.withValues(alpha: 0.85),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),
                  _buildCountdown(),
                  SizedBox(height: 40.h),
                  GoldButton(
                    label: 'Step Into Forever  ➤',
                    onPressed: () {
                      controller.openInvitation();
                    },
                  ),
                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.3),
          radius: 1.4,
          colors: [
            Color(0xFF3D1525),
            Color(0xFF1A0A05),
            Color(0xFF0D0407),
          ],
        ),
      ),
    );
  }

  Widget _buildDateBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
      ),
      child: Text(
        'JULY 05, 2026  ·  10:30 AM',
        style: GoogleFonts.cinzel(
          fontSize: 10.sp,
          letterSpacing: 2.5,
          color: AppColors.gold,
        ),
      ),
    );
  }

  Widget _buildCouplePhoto() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 190.w,
          height: 190.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.gold.withValues(alpha: 0.15),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Container(
          width: 160.w,
          height: 160.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF4A1828), Color(0xFF2D0E1A)],
            ),
            border: Border.all(
              color: AppColors.gold.withValues(alpha: 0.5),
              width: 3.w,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.2),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              "assets/images/COUPLE_II.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF2D0E1A),
                  child: const Center(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white54,
                      size: 50,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCoupleNames() {
    return Column(
      children: [
        Text(
          'Mohamed Yousuf',
          textAlign: TextAlign.center,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 42.sp,
            fontWeight: FontWeight.w300,
            color: AppColors.textLight,
            height: 1.0,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          '&',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 32.sp,
            fontStyle: FontStyle.italic,
            color: AppColors.gold,
            height: 1.0,
          ),
        ),
        Text(
          'Hajima Bee',
          textAlign: TextAlign.center,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 42.sp,
            fontWeight: FontWeight.w300,
            color: AppColors.textLight,
            height: 1.0,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCountdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => _cdBox(controller.days.value, 'DAYS')),
        _cdDivider(),
        Obx(() => _cdBox(controller.hours.value, 'HOURS')),
        _cdDivider(),
        Obx(() => _cdBox(controller.minutes.value, 'MINS')),
        _cdDivider(),
        Obx(() => _cdBox(controller.seconds.value, 'SECS')),
      ],
    );
  }

  Widget _cdBox(String value, String label) {
    return GlassmorphismCard(
      width: 72.w,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.countdownNum),
          SizedBox(height: 4.h),
          Text(label, style: AppTextStyles.countdownLabel),
        ],
      ),
    );
  }

  Widget _cdDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Text(
        ':',
        style: GoogleFonts.cinzel(
          fontSize: 28.sp,
          color: AppColors.gold.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  Widget _buildMusicFab() {
    return Obx(() {
      final playing = musicController.isPlaying.value;
      return GestureDetector(
        onTap: musicController.toggleMusic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 52.w,
          height: 52.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.gold.withValues(alpha: playing ? 0.8 : 0.4),
              width: 1.5,
            ),
            color: Colors.black.withValues(alpha: 0.4),
            boxShadow: playing
                ? [BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.3),
              blurRadius: 16,
              spreadRadius: 2,
            )]
                : [],
          ),
          child: Icon(
            playing ? Icons.music_note : Icons.music_note_outlined,
            color: playing
                ? AppColors.goldLight
                : AppColors.gold.withValues(alpha: 0.5),
            size: 22.sp,
          ),
        ),
      );
    });
  }
}