import 'package:get/get.dart';

import '../controllers/form_pengajuan_controller.dart';

class FormPengajuanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormPengajuanController>(
      () => FormPengajuanController(),
    );
  }
}
