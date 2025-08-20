import 'package:get/get.dart';
import 'package:pengaduan/app/modules/profile/controllers/profile_controller.dart';
import 'package:pengaduan/app/modules/home_admin/controllers/home_admin_controller.dart';

class HomeAdminBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ daftarkan controller yang dibutuhkan di AdminMainPage
    Get.put(ProfileController());
    Get.put(HomeAdminController());
  }
}
