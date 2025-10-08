import 'package:get/get.dart';
import 'package:pengaduan/app/modules/profile/controllers/profile_controller.dart';
import 'package:pengaduan/app/modules/home_admin/controllers/home_admin_controller.dart';

class HomeAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
    Get.put(HomeAdminController());
    Get.lazyPut<HomeAdminController>(() => HomeAdminController(), fenix: true);
  }
}
