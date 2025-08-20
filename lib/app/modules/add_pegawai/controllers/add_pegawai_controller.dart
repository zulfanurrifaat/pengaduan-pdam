import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  RxBool isloading = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addPegawai() async {
    if (nameC.text.isEmpty || emailC.text.isEmpty || passwordC.text.isEmpty) {
      Get.snackbar("Error", "Nama, email, dan password wajib diisi.");
      return;
    }

    if (!GetUtils.isEmail(emailC.text.trim())) {
      Get.snackbar("Error", "Format email tidak valid");
      return;
    }

    if (passwordC.text.length < 6) {
      Get.snackbar("Error", "Password minimal 6 karakter");
      return;
    }

    try {
      isloading.value = true;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text.trim(), password: passwordC.text.trim());

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        await firestore.collection("users").doc(uid).set({
          "uid": uid,
          "name": nameC.text.trim(),
          "email": emailC.text.trim(),
          "role": "user",
          "createdAt": DateTime.now().toIso8601String(),
        });

        await userCredential.user!.sendEmailVerification();

        Get.snackbar("Berhasil",
            "Akun pegawai berhasil dibuat. Verifikasi email telah dikirim.");
        nameC.clear();
        emailC.clear();
        passwordC.clear();
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
      isloading.value = false;
    }
  }
}
