import 'package:get/get.dart';

import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/form_pengajuan/bindings/form_pengajuan_binding.dart';
import '../modules/form_pengajuan/views/form_pengajuan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/registrasi/bindings/registrasi_binding.dart';
import '../modules/registrasi/views/registrasi_view.dart';
import '../modules/semua_riwayat/bindings/semua_riwayat_binding.dart';
import '../modules/semua_riwayat/views/semua_riwayat_view.dart';
import '../modules/start/bindings/start_binding.dart';
import '../modules/start/views/start_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.START;

  static final routes = [
    GetPage(
      name: _Paths.START,
      page: () => const StartView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRASI,
      page: () => const RegistrasiView(),
      binding: RegistrasiBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FORM_PENGAJUAN,
      page: () => const FormPengajuanView(),
      binding: FormPengajuanBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SEMUA_RIWAYAT,
      page: () => const SemuaRiwayatView(),
      binding: SemuaRiwayatBinding(),
    ),
  ];
}