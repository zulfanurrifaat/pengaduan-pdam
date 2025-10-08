import 'package:get/get.dart';
import '../controllers/semua_riwayat_controller.dart';

class SemuaRiwayatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SemuaRiwayatController>(() => SemuaRiwayatController());
  }
}
