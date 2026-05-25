// ============================================================
// app/routes/app_pages.dart
// Maps each route name to:
//   1. A SCREEN (the UI widget to show)
//   2. A BINDING (injects the controller before the screen loads)
//
// HOW GETX ROUTING WORKS:
//   GetPage = Route Name + Screen + Binding (controller injection)
//   Binding ensures controller is ready before UI builds
// ============================================================

import 'package:my_wedding_app/app/binding/home_binding.dart';
import 'package:my_wedding_app/app/binding/invite_binding.dart';
import 'package:my_wedding_app/app/binding/rsvp_binding.dart';
import 'package:my_wedding_app/app/binding/splash_binding.dart';
import 'package:my_wedding_app/features/home/view/home_screen.dart';
import 'package:my_wedding_app/features/invite/view/invite_screen.dart';
import 'package:my_wedding_app/features/rsvp/view/rsvp_screen.dart';
import 'package:my_wedding_app/features/splash/view/splash_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = [
    // SPLASH — shown for 3 seconds with animation, then auto-navigates
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),

    // HOME — main invitation screen with countdown, couple names, CTA
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),

    // INVITE — full scrollable invitation with all sections
    GetPage(
      name: AppRoutes.invite,
      page: () => const InviteScreen(),
      binding: InviteBinding(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 700),
    ),

    // RSVP — form screen to confirm attendance
    GetPage(
      name: AppRoutes.rsvp,
      page: () => const RsvpScreen(),
      binding: RsvpBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}