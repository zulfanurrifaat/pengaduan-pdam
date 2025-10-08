import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  final RxBool isLoading = false.obs;

  final TextEditingController currentPassC = TextEditingController();
  final TextEditingController newPassC = TextEditingController();
  final TextEditingController confirmPassC = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> changePassword() async {
    final current = currentPassC.text.trim();
    final next = newPassC.text.trim();
    final confirm = confirmPassC.text.trim();

    if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
      Get.snackbar("Error", "Semua field wajib diisi",
          snackPosition: SnackPosition.TOP);
      return;
    }
    if (next.length < 6) {
      Get.snackbar("Error", "Password baru minimal 6 karakter",
          snackPosition: SnackPosition.TOP);
      return;
    }
    if (next != confirm) {
      Get.snackbar("Error", "Konfirmasi password tidak sama",
          snackPosition: SnackPosition.TOP);
      return;
    }

    final user = auth.currentUser;
    if (user == null || user.email == null) {
      Get.snackbar("Error", "User tidak ditemukan. Silakan login ulang.",
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final cred =
          EmailAuthProvider.credential(email: user.email!, password: current);
      await user.reauthenticateWithCredential(cred);

      await user.updatePassword(next);

      // Bersihkan field
      currentPassC.clear();
      newPassC.clear();
      confirmPassC.clear();

      Get.snackbar("Berhasil", "Password berhasil diperbarui",
          snackPosition: SnackPosition.TOP);
    } on FirebaseAuthException catch (e) {
      final code = (e.code).toLowerCase();

      if (code == 'wrong-password') {
        Get.snackbar("Error", "Password saat ini salah",
            snackPosition: SnackPosition.TOP);
      } else if (code == 'weak-password') {
        Get.snackbar("Error", "Password baru terlalu lemah",
            snackPosition: SnackPosition.TOP);
      } else if (code == 'requires-recent-login') {
        Get.snackbar("Error", "Sesi kadaluarsa. Silakan login ulang.",
            snackPosition: SnackPosition.TOP);
      } else if (code == 'network-request-failed') {
        Get.snackbar("Error", "Koneksi internet bermasalah. Coba lagi.",
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Error", "Password lama salah",
            snackPosition: SnackPosition.TOP);
      }
    } catch (_) {
      Get.snackbar("Error", "Terjadi kesalahan",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
}
