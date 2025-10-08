import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  final RxBool isLoading = false.obs;

  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> pickImage() async {
    try {
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked != null) {
        image = picked;
        update();
      }
    } catch (_) {
      Get.snackbar("Error", "Gagal memilih gambar",
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> updateProfile() async {
    final user = auth.currentUser;
    if (user == null) {
      Get.snackbar("Error", "User tidak ditemukan. Silakan login ulang.",
          snackPosition: SnackPosition.TOP);
      return;
    }

    final uid = user.uid;
    final name = nameC.text.trim();
    final email = emailC.text.trim();

    if (name.isEmpty || email.isEmpty) {
      Get.snackbar("Error", "Nama & email tidak boleh kosong",
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final data = <String, dynamic>{"name": name};

      if (image != null) {
        final file = File(image!.path);
        final ext = image!.name.split(".").last;
        final ref = storage.ref().child('users/$uid/profile.$ext');

        await ref.putFile(file);
        final urlImage = await ref.getDownloadURL();
        data["profile"] = urlImage;
      }

      await firestore.collection("users").doc(uid).update(data);
      await user.updateDisplayName(name);

      image = null;
      update();
      Get.snackbar("Berhasil", "Berhasil update profile",
          snackPosition: SnackPosition.TOP);
    } catch (_) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat update profile",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProfile(String? uidArg) async {
    final user = auth.currentUser;
    final uid =
        (uidArg?.trim().isNotEmpty ?? false) ? uidArg! : (user?.uid ?? "");

    if (uid.isEmpty) {
      Get.snackbar("Error", "User tidak ditemukan",
          snackPosition: SnackPosition.TOP);
      return;
    }

    try {
      await firestore.collection("users").doc(uid).update({
        "profile": FieldValue.delete(),
      });

      Get.back();
      Get.snackbar("Berhasil", "Berhasil delete profile picture.",
          snackPosition: SnackPosition.TOP);
    } catch (_) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat delete profile picture.",
          snackPosition: SnackPosition.TOP);
    } finally {
      image = null;
      update();
    }
  }
}
