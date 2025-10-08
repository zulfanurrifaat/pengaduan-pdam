import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final RxBool isLoading = false.obs;
  final TextEditingController emailC = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool _isEmailFormatValid(String email) {
    final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return re.hasMatch(email);
  }

  Future<void> sendEmail() async {
    final email = emailC.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Error", "Email wajib diisi",
          snackPosition: SnackPosition.TOP);
      return;
    }
    if (!_isEmailFormatValid(email)) {
      Get.snackbar("Error", "Email tidak valid!",
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (isLoading.value) return;
    isLoading.value = true;

    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Berhasil",
        "Email reset password telah dikirim. Silakan periksa email kamu.",
        snackPosition: SnackPosition.TOP,
      );
    } on FirebaseAuthException catch (e) {
      final code = (e.code).toLowerCase();

      if (code == 'invalid-email') {
        Get.snackbar("Error", "Email tidak valid!",
            snackPosition: SnackPosition.TOP);
      } else if (code == 'user-not-found') {
        Get.snackbar("Info", "Jika email terdaftar, link reset akan dikirim.",
            snackPosition: SnackPosition.TOP);
      } else if (code == 'network-request-failed') {
        Get.snackbar("Error", "Koneksi internet bermasalah. Coba lagi.",
            snackPosition: SnackPosition.TOP);
      } else if (code == 'too-many-requests') {
        Get.snackbar("Error", "Terlalu banyak percobaan. Coba lagi nanti.",
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Error", "Tidak dapat mengirim email reset password",
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
