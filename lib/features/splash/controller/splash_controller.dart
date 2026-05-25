/*
// ============================================================
// features/splash/controller/splash_controller.dart
//
// WHAT IS A GETX CONTROLLER?
// Think of it as the "brain" behind a screen.
// The Screen (View) just displays UI.
// The Controller handles logic, timers, state changes.
//
// GetxController gives us:
//   onInit()  → runs automatically when controller is created
//   onClose() → runs automatically when controller is destroyed
//   .obs      → makes variables "reactive" (UI auto-updates)
//   update()  → manually trigger UI rebuild
// ============================================================

import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class SplashController extends GetxController {

  // ── REACTIVE VARIABLES ────────────────────────────────
  // .obs makes these "observable" — when they change,
  // any Obx() widget watching them will rebuild automatically.

  final RxDouble logoOpacity   = 0.0.obs; // starts invisible
  final RxDouble logoScale     = 0.5.obs; // starts small
  final RxDouble titleOpacity  = 0.0.obs;
  final RxDouble subtitleOpacity = 0.0.obs;

  // ── LIFECYCLE ─────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _startAnimationSequence();
  }

  // ── ANIMATION SEQUENCE ────────────────────────────────
  // Each animation fires with a delay, creating a
  // "staggered" reveal effect.
  void _startAnimationSequence() async {
    // Step 1: After 300ms — logo appears + grows
    await Future.delayed(const Duration(milliseconds: 300));
    logoOpacity.value  = 1.0;
    logoScale.value    = 1.0;

    // Step 2: After 800ms — title fades in
    await Future.delayed(const Duration(milliseconds: 800));
    titleOpacity.value = 1.0;

    // Step 3: After 400ms — subtitle fades in
    await Future.delayed(const Duration(milliseconds: 400));
    subtitleOpacity.value = 1.0;

    // Step 4: After 1.5 more seconds — navigate to Home
    await Future.delayed(const Duration(milliseconds: 1500));
    _navigateToHome();
  }

  void _navigateToHome() {
    // offAll = replaces entire navigation stack
    // (user can't go "back" to splash with back button)
    Get.offAllNamed(AppRoutes.home);
  }
}*/
// ============================================================
// features/splash/controller/splash_controller.dart
//
// CHANGE FROM BEFORE:
// ❌ Old: auto navigate after 3 seconds
// ✅ New: show button → user tap → music start → navigate
//
// enterWithMusic() — button tap handler
//   1. MusicController get பண்றோம்
//   2. startMusic() call — user gesture உள்ளே இருக்கோம் ✅
//   3. Home screen navigate
// ============================================================

import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../features/music/controller/music_controller.dart';

class SplashController extends GetxController {

  // Animation observables
  final RxDouble logoOpacity      = 0.0.obs;
  final RxDouble logoScale        = 0.5.obs;
  final RxDouble titleOpacity     = 0.0.obs;
  final RxDouble subtitleOpacity  = 0.0.obs; // button opacity too

  @override
  void onInit() {
    super.onInit();
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Step 1: 300ms → rings icon appear
    await Future.delayed(const Duration(milliseconds: 300));
    logoOpacity.value = 1.0;
    logoScale.value   = 1.0;

    // Step 2: 800ms → couple names fade in
    await Future.delayed(const Duration(milliseconds: 800));
    titleOpacity.value = 1.0;

    // Step 3: 600ms → date + ENTER BUTTON appear
    await Future.delayed(const Duration(milliseconds: 600));
    subtitleOpacity.value = 1.0;

    // ✅ No auto navigate — user button tap பண்ணணும்
  }

  // ════════════════════════════════════════════════════
  // Called when user taps "ENTER INVITATION" button
  // இந்த function-க்குள்ளே இருக்கோம் = user gesture ✅
  // Browser music play allow பண்ணும்
  // ════════════════════════════════════════════════════
  void enterWithMusic() {
    // MusicController permanent: true ஆ create ஆகிருக்கு
    // home_binding.dart-ல. இங்க Get.find() பண்றோம்.
    // Splash navigate ஆகுறதுக்கு முன்னாடி music start பண்றோம்
    try {
      final music = Get.find<MusicController>();
      music.startMusic();
    } catch (_) {
      // MusicController இல்லன்னா (first time) — put பண்றோம்
      final music = Get.put(MusicController(), permanent: true);
      music.startMusic();
    }

    // Home screen navigate — offAllNamed = back button போகாது
    Get.offAllNamed(AppRoutes.home);
  }
}