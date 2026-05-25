import 'package:my_wedding_app/features/rsvp/controller/rsvp_controller.dart';
import 'package:get/get.dart';

class RsvpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsvpController>(() => RsvpController());
  }
}