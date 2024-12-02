import 'package:get/get.dart';

import '../controllers/detail_pengaduan_controller.dart';

class DetailPengaduanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPengaduanController>(
      () => DetailPengaduanController(),
    );
  }
}
