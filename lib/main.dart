// ============================================================
// main.dart
// Entry point of the Wedding Invitation App
// - Initializes Flutter bindings
// - Sets up GetX (no need for context/BuildContext)
// - Uses GetMaterialApp instead of MaterialApp
// ============================================================

import 'package:my_wedding_app/app/routes/app_pages.dart';
import 'package:my_wedding_app/app/routes/app_routes.dart';
import 'package:my_wedding_app/app/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_wedding_app/features/music/controller/music_controller.dart';

import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(MusicController());

  // Lock to portrait mode (optional — remove for landscape support)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Make status bar transparent (for immersive look)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const WeddingApp());
}

class WeddingApp extends StatelessWidget {
  const WeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // App title shown in task switcher
      title: 'My Wedding Invitation',

      // Hide the debug banner in top-right corner
      debugShowCheckedModeBanner: false,

      // Our custom romantic theme (defined in app/theme/app_theme.dart)
      theme: AppTheme.lightTheme,

      // Starting route — goes to Splash Screen first
      initialRoute: AppRoutes.splash,

      // All route definitions (Splash → Home → Invite → RSVP)
      getPages: AppPages.pages,

      // Smooth default transition between all pages
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 600),
    );
  }
}