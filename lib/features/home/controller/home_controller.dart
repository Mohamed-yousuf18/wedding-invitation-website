/*
// ============================================================
// features/home/controller/home_controller.dart
// ============================================================

import 'dart:async';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class HomeController extends GetxController {

  // ── COUNTDOWN STATE ───────────────────────────────────
  final RxString days    = '00'.obs;
  final RxString hours   = '00'.obs;
  final RxString minutes = '00'.obs;
  final RxString seconds = '00'.obs;
  final RxBool   weddingPassed = false.obs;

  // ✅ UPDATED: Mohamed Yousuf & Hajima Bee — 05/07/2026 at 10:30 AM
  final DateTime weddingDate = DateTime(2026, 7, 5, 10, 30, 0);

  // ── ANIMATION STATE ───────────────────────────────────
  final RxBool showSpotlight      = true.obs;
  final RxBool showConfetti       = false.obs;
  final RxDouble spotlightOpacity = 0.0.obs;
  final RxDouble namesOpacity     = 0.0.obs;
  final RxBool showHeroContent    = false.obs;

  Timer? _countdownTimer;

  @override
  void onInit() {
    super.onInit();
    _startSpotlightSequence();
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    super.onClose();
  }

  void _startSpotlightSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    spotlightOpacity.value = 1.0;

    await Future.delayed(const Duration(milliseconds: 1000));
    namesOpacity.value = 1.0;

    await Future.delayed(const Duration(milliseconds: 800));
    showConfetti.value = true;

    await Future.delayed(const Duration(milliseconds: 2000));
    spotlightOpacity.value = 0.0;
    namesOpacity.value = 0.0;

    await Future.delayed(const Duration(milliseconds: 600));
    showSpotlight.value = false;
    showHeroContent.value = true;
    showConfetti.value = false;

    _startCountdown();
  }

  void _startCountdown() {
    _updateCountdown();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
          (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    final now  = DateTime.now();
    final diff = weddingDate.difference(now);

    if (diff.isNegative) {
      weddingPassed.value = true;
      days.value    = '00';
      hours.value   = '00';
      minutes.value = '00';
      seconds.value = '00';
      _countdownTimer?.cancel();
      return;
    }

    days.value    = diff.inDays.toString().padLeft(2, '0');
    hours.value   = diff.inHours.remainder(24).toString().padLeft(2, '0');
    minutes.value = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
    seconds.value = diff.inSeconds.remainder(60).toString().padLeft(2, '0');
  }

  void openInvitation() {
    showConfetti.value = true;
    Future.delayed(const Duration(milliseconds: 800), () {
      Get.toNamed(AppRoutes.invite);
    });
  }
}*/
// ============================================================
// features/home/controller/home_controller.dart
// Mohamed Yousuf & Hajima Bee — July 05, 2026
//
// FLOW:
// 1. App open → Spotlight screen (names auto fade in)
// 2. 3 seconds → spotlight auto hide → home content show
// 3. User "Open Invitation ✦" tap → music start + navigate
// ============================================================

import 'dart:async';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class HomeController extends GetxController {

  // Countdown values
  final RxString days    = '00'.obs;
  final RxString hours   = '00'.obs;
  final RxString minutes = '00'.obs;
  final RxString seconds = '00'.obs;
  final RxBool weddingPassed = false.obs;

  // Wedding: July 05, 2026 at 10:30 AM
  final DateTime weddingDate = DateTime(2026, 7, 5, 10, 30, 0);

  // Screen state
  final RxBool showSpotlight   = true.obs;
  final RxBool showConfetti    = false.obs;
  final RxDouble namesOpacity  = 0.0.obs;
  final RxBool showHeroContent = false.obs;

  Timer? _countdownTimer;

  @override
  void onInit() {
    super.onInit();
    _runSpotlight();
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    super.onClose();
  }

  void _runSpotlight() async {
    // Step 1: Names fade in after 0.8s
    await Future.delayed(const Duration(milliseconds: 800));
    namesOpacity.value = 1.0;

    // Step 2: After 3s total — hide spotlight, show home
    await Future.delayed(const Duration(milliseconds: 2500));
    hideSpotlight();
  }

  void hideSpotlight() {
    showSpotlight.value   = false;
    showHeroContent.value = true;
    _startCountdown();
  }

  void _startCountdown() {
    _updateCountdown();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
          (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    final diff = weddingDate.difference(DateTime.now());

    if (diff.isNegative) {
      weddingPassed.value = true;
      days.value = hours.value = minutes.value = seconds.value = '00';
      _countdownTimer?.cancel();
      return;
    }

    days.value    = diff.inDays.toString().padLeft(2, '0');
    hours.value   = diff.inHours.remainder(24).toString().padLeft(2, '0');
    minutes.value = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
    seconds.value = diff.inSeconds.remainder(60).toString().padLeft(2, '0');
  }

  // Called from "Open Invitation ✦" button
  // Music already started in home_screen before this is called
  void openInvitation() {
    showConfetti.value = true;
    Future.delayed(const Duration(milliseconds: 600), () {
      Get.toNamed(AppRoutes.invite);
    });
  }
}