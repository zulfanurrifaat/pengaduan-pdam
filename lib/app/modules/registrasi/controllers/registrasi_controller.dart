import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan/app/routes/app_pages.dart';

class RegistrasiController extends GetxController {
  var isLoading = false.obs;

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> register() async {
    if (nameC.text.isEmpty || emailC.text.isEmpty || passC.text.isEmpty) {
      Get.snackbar("Error", "Semua field harus diisi");
      return;
    }

    if (!GetUtils.isEmail(emailC.text.trim())) {
      Get.snackbar("Error", "Format email tidak valid");
      return;
    }

    if (passC.text.length < 6) {
      Get.snackbar("Error", "Password minimal 6 karakter");
      return;
    }

    try {
      isLoading.value = true;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailC.text.trim(),
        password: passC.text.trim(),
      );

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        await firestore.collection("users").doc(uid).set({
          "uid": uid,
          "name": nameC.text.trim(),
          "email": emailC.text.trim(),
          "role": "admin",
          "createdAt": DateTime.now().toIso8601String(),
        });

        await userCredential.user!.sendEmailVerification();

        Get.snackbar("Sukses",
            "Akun admin berhasil dibuat. Silakan cek email untuk verifikasi.");
        Get.offAllNamed(Routes.LOGIN);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Get.snackbar("Error", "Email tidak valid");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "Email sudah digunakan");
      } else if (e.code == 'weak-password') {
        Get.snackbar("Error", "Password terlalu lemah");
      } else {
        Get.snackbar("Error", e.message ?? "Terjadi kesalahan");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
