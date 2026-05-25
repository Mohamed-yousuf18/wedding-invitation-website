/*
// // ============================================================
// // features/music/controller/music_controller.dart
// //
// // Controls background music playback.
// // Uses audioplayers package.
// //
// // NOTE: Place your audio file at:
// //   assets/audio/wedding_music.mp3
// //
// // You can download a royalty-free romantic tune from:
// //   https://pixabay.com/music/search/romantic/
// // ============================================================
//
// import 'package:get/get.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// class MusicController extends GetxController {
//
//   // Whether music is currently playing
//   final RxBool isPlaying = false.obs;
//
//   // AudioPlayer instance from audioplayers package
//   late final AudioPlayer _player;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _player = AudioPlayer();
//
//     // Loop the music infinitely
//     _player.setReleaseMode(ReleaseMode.loop);
//   }
//
//   @override
//   void onClose() {
//     _player.dispose();
//     super.onClose();
//   }
//
//   // ── PUBLIC METHODS ────────────────────────────────────
//
//   void startMusic() async {
//     if (!isPlaying.value) {
//       await _player.play(
//         AssetSource('audio/wedding_music.mp3'),
//         volume: 0.4, // gentle background volume
//       );
//       isPlaying.value = true;
//     }
//   }
//
//   void toggleMusic() async {
//     if (isPlaying.value) {
//       await _player.pause();
//       isPlaying.value = false;
//     } else {
//       await _player.resume();
//       isPlaying.value = true;
//     }
//   }
//
//   void stopMusic() async {
//     await _player.stop();
//     isPlaying.value = false;
//   }
// }

// ============================================================
// features/music/controller/music_controller.dart
//
// Background Music Controller
// Uses audioplayers package
//
// Audio File Path:
// assets/audio/wedding_music.mp3
// ============================================================

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MusicController extends GetxController {

  // ── REACTIVE STATE ─────────────────────────────
  final RxBool isPlaying = false.obs;

  // ── AUDIO PLAYER ───────────────────────────────
  late final AudioPlayer _player;

  // ── INIT ───────────────────────────────────────
  @override
  void onInit() {
    super.onInit();

    _player = AudioPlayer();

    // Loop music infinitely
    _player.setReleaseMode(ReleaseMode.loop);

    // Optional volume
    _player.setVolume(0.4);
  }

  // ── DISPOSE ────────────────────────────────────
  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }

  // ── START MUSIC ────────────────────────────────
  Future<void> startMusic() async {
    try {

      // Avoid replaying
      if (isPlaying.value) return;

      await _player.play(
        AssetSource('audio/wedding_music.mp3'),
      );

      isPlaying.value = true;

    } catch (e) {
      print('Music Start Error: $e');
    }
  }

  // ── TOGGLE MUSIC ───────────────────────────────
  Future<void> toggleMusic() async {
    try {

      if (isPlaying.value) {

        await _player.pause();
        isPlaying.value = false;

      } else {

        await _player.resume();
        isPlaying.value = true;
      }

    } catch (e) {
      print('Music Toggle Error: $e');
    }
  }

  // ── STOP MUSIC ─────────────────────────────────
  Future<void> stopMusic() async {
    try {

      await _player.stop();
      isPlaying.value = false;

    } catch (e) {
      print('Music Stop Error: $e');
    }
  }
}*/
// ============================================================
// features/music/controller/music_controller.dart
// Simple - audioplayers package use பண்றோம் (works fine)
// ============================================================

import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicController extends GetxController {

  final RxBool isPlaying = false.obs;

  late final AudioPlayer _player;

  @override
  void onInit() {
    super.onInit();
    _player = AudioPlayer();
    _player.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }

  // User button tap பண்ணும்போது இதை call பண்றோம்
  // audioplayers - user gesture இருந்தா web-லயும் work ஆகும்
  void startMusic() async {
    if (isPlaying.value) return;
    await _player.play(
      AssetSource('audio/wedding_music.mp3'),
      volume: 0.4,
    );
    isPlaying.value = true;
  }

  void toggleMusic() async {
    if (isPlaying.value) {
      await _player.pause();
      isPlaying.value = false;
    } else {
      await _player.resume();
      isPlaying.value = true;
    }
  }

  void stopMusic() async {
    await _player.stop();
    isPlaying.value = false;
  }
}