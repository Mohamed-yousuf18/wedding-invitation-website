// ============================================================
// app/routes/app_routes.dart
// Defines all the named routes (URL-like paths) for the app.
//
// HOW IT WORKS:
// Instead of Navigator.push(context, MaterialPageRoute(...))
// you just call: Get.toNamed(AppRoutes.home)
// GetX handles the navigation automatically.
// ============================================================

class AppRoutes {
  // Private constructor — prevents instantiation
  AppRoutes._();

  // Route names (like URLs in a website)
  static const splash = '/';           // First screen shown
  static const home   = '/home';       // Main invitation landing
  static const invite = '/invite';     // Full invitation details
  static const rsvp   = '/rsvp';       // RSVP form screen
}