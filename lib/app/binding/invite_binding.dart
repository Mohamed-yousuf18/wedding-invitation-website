import 'package:my_wedding_app/features/invite/controller/invite_controller.dart';
import 'package:get/get.dart';

class InviteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InviteController>(() => InviteController());
  }
}