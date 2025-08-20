import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart'; // Import UUID package

class FormPengajuanController extends GetxController {
  final bagian = Rx<String?>(null);
  final kategoriPengaduan = Rx<String?>(null);
  final noHandphone = TextEditingController();
  final uraianPengaduan = TextEditingController();

  String? validateForm() {
    if (bagian.value == null || bagian.value!.isEmpty) {
      return "Bagian harus dipilih";
    }
    if (kategoriPengaduan.value == null || kategoriPengaduan.value!.isEmpty) {
      return "Kategori pengaduan harus dipilih";
    }
    if (noHandphone.text.isEmpty) {
      return "No Handphone harus diisi";
    }
    if (uraianPengaduan.text.isEmpty) {
      return "Uraian pengaduan harus diisi";
    }
    return null;
  }

  Future<void> submitPengaduan() async {
    final error = validateForm();
    if (error != null) {
      Get.snackbar(
        "Terjadi kesalahan",
        error,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black,
      );
      return;
    }

    try {
      var uuid = Uuid();
      String ticketId = uuid.v4();

      await FirebaseFirestore.instance.collection('pengaduan').add({
        'ticketId': ticketId,
        'bagian': bagian.value,
        'kategoriPengaduan': kategoriPengaduan.value,
        'noHandphone': noHandphone.text,
        'uraianPengaduan': uraianPengaduan.text,
        'tanggal': DateTime.now(),
      });

      Get.snackbar(
        "Berhasil",
        "Ticket pengaduan berhasil dikirim\nNomor Tiket: $ticketId",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black,
      );

      bagian.value = null;
      kategoriPengaduan.value = null;
      noHandphone.clear();
      uraianPengaduan.clear();
    } catch (e) {
      Get.snackbar(
        "Terjadi kesalahan",
        "Gagal mengirim ticket pengaduan: $e",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black,
      );
    }
  }
}
