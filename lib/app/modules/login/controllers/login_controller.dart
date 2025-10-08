import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _isEmailFormatValid(String email) {
    final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return re.hasMatch(email);
  }

  Future<void> login() async {
    final email = emailC.text.trim();
    final pass = passC.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      Get.snackbar("Error", "Email dan password wajib diisi",
          snackPosition: SnackPosition.TOP);
      return;
    }
    if (!_isEmailFormatValid(email)) {
      Get.snackbar("Error", "Email tidak valid!",
          snackPosition: SnackPosition.TOP);
      return;
    }

    try {
      isLoading.value = true;

      final cred =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      final user = cred.user;

      // verifikasi email (sesuai logika lama)
      if (user != null && !user.emailVerified) {
        Get.snackbar(
          "Verifikasi Dibutuhkan",
          "Silakan verifikasi email Anda terlebih dahulu.",
          snackPosition: SnackPosition.TOP,
        );
        await auth.signOut();
        return;
      }

      if (user != null) {
        final snap = await firestore.collection("users").doc(user.uid).get();
        if (!snap.exists) {
          Get.snackbar("Error", "Data user tidak ditemukan",
              snackPosition: SnackPosition.TOP);
          return;
        }

        final role = (snap.data()?["role"] ?? "").toString();

        if (role == "admin") {
          Get.offAllNamed(Routes.HOME_ADMIN);
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      }
    } on FirebaseAuthException catch (e) {
      await _showAuthErrorSnackbar(email, e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendVerificationEmail() async {
    final email = emailC.text.trim();
    final pass = passC.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      Get.snackbar("Error", "Masukkan email & password terlebih dahulu",
          snackPosition: SnackPosition.TOP);
      return;
    }
    if (!_isEmailFormatValid(email)) {
      Get.snackbar("Error", "Email tidak valid!",
          snackPosition: SnackPosition.TOP);
      return;
    }

    try {
      final cred =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      final user = cred.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Get.snackbar("Sukses", "Email verifikasi telah dikirim ulang ke $email",
            snackPosition: SnackPosition.TOP);
        await auth.signOut();
      } else {
        Get.snackbar("Info", "Akun sudah terverifikasi.",
            snackPosition: SnackPosition.TOP);
      }
    } on FirebaseAuthException catch (e) {
      await _showAuthErrorSnackbar(email, e);
    }
  }

  Future<void> _showAuthErrorSnackbar(
      String email, FirebaseAuthException e) async {
    final code = (e.code).toLowerCase();
    final msg = (e.message ?? '').toLowerCase();

    if (code == 'invalid-email') {
      Get.snackbar("Error", "Email tidak valid!",
          snackPosition: SnackPosition.TOP);
      return;
    }
    if (code == 'user-not-found') {
      Get.snackbar("Error", "Akun dengan email ini belum terdaftar.",
          snackPosition: SnackPosition.TOP);
      return;
    }
    if (code == 'wrong-password') {
      Get.snackbar("Error", "Password salah!!",
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (code == 'invalid-credential' ||
        code == 'invalid-login-credentials' ||
        code == 'invalid_login_credentials') {
      try {
        final methods = await auth.fetchSignInMethodsForEmail(email);
        if (methods.isEmpty) {
          Get.snackbar("Error", "Email atau password salah",
              snackPosition: SnackPosition.TOP);
        } else {
          Get.snackbar("Error", "Password salah!!",
              snackPosition: SnackPosition.TOP);
        }
      } catch (_) {
        Get.snackbar("Error", "Email atau password salah",
            snackPosition: SnackPosition.TOP);
      }
      return;
    }

    if (code == 'network-request-failed') {
      Get.snackbar("Error", "Koneksi internet bermasalah. Coba lagi.",
          snackPosition: SnackPosition.TOP);
      return;
    }
    if (code == 'too-many-requests') {
      Get.snackbar("Error", "Terlalu banyak percobaan. Coba lagi nanti.",
          snackPosition: SnackPosition.TOP);
      return;
    }
    if (code == 'user-disabled') {
      Get.snackbar("Error", "Akun dinonaktifkan. Hubungi admin.",
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (code == 'unknown') {
      if (msg.contains('password')) {
        Get.snackbar("Error", "Password salah!!",
            snackPosition: SnackPosition.TOP);
        return;
      }
      if (msg.contains('no user record') || msg.contains('user not found')) {
        Get.snackbar("Error", "Akun dengan email ini belum terdaftar.",
            snackPosition: SnackPosition.TOP);
        return;
      }
      if (msg.contains('email') && msg.contains('invalid')) {
        Get.snackbar("Error", "Email tidak valid!",
            snackPosition: SnackPosition.TOP);
        return;
      }
    }

    Get.snackbar("Error", "Terjadi kesalahan",
        snackPosition: SnackPosition.TOP);
  }
}
