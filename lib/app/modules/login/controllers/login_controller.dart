import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pengaduan/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text.trim(),
          password: passC.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          if (!user.emailVerified) {
            Get.snackbar(
              "Verifikasi Dibutuhkan",
              "Silakan verifikasi email Anda terlebih dahulu.",
              snackPosition: SnackPosition.TOP,
            );
            await auth.signOut();
            return;
          }

          DocumentSnapshot userDoc =
              await firestore.collection("users").doc(user.uid).get();

          if (userDoc.exists) {
            String role = userDoc["role"];
            if (role == "admin") {
              Get.offAllNamed(Routes.HOME_ADMIN);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.snackbar("Error", "Data user tidak ditemukan",
                snackPosition: SnackPosition.TOP);
          }
        }
      } on FirebaseAuthException catch (e) {
        String message = "Terjadi kesalahan";
        if (e.code == 'invalid-email') {
          message = "Format email tidak valid.";
        } else if (e.code == 'user-not-found') {
          message = "Akun dengan email ini belum terdaftar.";
        } else if (e.code == 'wrong-password') {
          message = "Password yang Anda masukkan salah.";
        }
        Get.snackbar("Error", message, snackPosition: SnackPosition.TOP);
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Error", "Email dan password wajib diisi",
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      if (emailC.text.isEmpty || passC.text.isEmpty) {
        Get.snackbar("Error", "Masukkan email & password terlebih dahulu",
            snackPosition: SnackPosition.TOP);
        return;
      }

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailC.text.trim(),
        password: passC.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Get.snackbar(
            "Sukses", "Email verifikasi telah dikirim ulang ke ${emailC.text}",
            snackPosition: SnackPosition.TOP);
        await auth.signOut();
      } else {
        Get.snackbar("Info", "Akun sudah terverifikasi.",
            snackPosition: SnackPosition.TOP);
      }
    } on FirebaseAuthException catch (e) {
      String message = "Terjadi kesalahan";
      if (e.code == 'invalid-email') {
        message = "Format email tidak valid.";
      } else if (e.code == 'user-not-found') {
        message = "Email belum terdaftar.";
      } else if (e.code == 'wrong-password') {
        message = "Password salah.";
      }
      Get.snackbar("Error", message, snackPosition: SnackPosition.TOP);
    }
  }
}
