import 'package:my_wedding_app/features/home/controller/home_controller.dart';
import 'package:my_wedding_app/features/music/controller/music_controller.dart';
import 'package:get/get.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    // Music controller persists across screens — use permanent:true
    Get.put<MusicController>(MusicController(), permanent: true);
  }
}