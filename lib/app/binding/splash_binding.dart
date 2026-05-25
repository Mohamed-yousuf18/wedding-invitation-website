// ============================================================
// app/bindings/splash_binding.dart
//
// WHAT IS A BINDING?
// A Binding is like a "setup" class that runs BEFORE the screen loads.
// It creates (injects) the controller so the screen can use it immediately.
//
// WHY USE IT?
// Without Binding, you'd create the controller manually inside the widget.
// With Binding, GetX manages the lifecycle automatically:
//   - Creates controller when screen opens
//   - Destroys controller when screen closes (memory cleanup)
// ============================================================

import 'package:get/get.dart';
import '../../features/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // lazyPut = only creates the controller when first accessed (efficient)
    Get.lazyPut<SplashController>(() => SplashController());
  }
}