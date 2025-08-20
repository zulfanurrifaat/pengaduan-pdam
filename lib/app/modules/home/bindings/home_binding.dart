import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // fenix true agar kalau terhapus, dibuat lagi otomatis
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
