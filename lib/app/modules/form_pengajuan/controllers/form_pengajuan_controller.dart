import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/ticket_number_service.dart';

class FormPengajuanController extends GetxController {
  final bagian = "".obs;
  final kategoriPengaduan = "".obs;
  final noHandphone = TextEditingController();
  final uraianPengaduan = TextEditingController();
  final isLoading = false.obs;

  final listBagian = <String>[
    'Perencanaan Teknik',
    'Pengawasan Teknik',
    'Evaluasi & Pelaporan Teknik',
    'Sumber Air',
    'Instalasi Wilayah',
    'Laboratorium',
    'Evaluasi & Pelaporan Produksi',
    'Transmisi & Distribusi ',
    'Penanggulangan Kebocoran Air',
    'Permesinan',
    'Perlistrikan',
    'Pemeliharaan Peralatan Teknik',
    'Anggaran',
    'Akuntansi',
    'Piutang & Penagihan',
    'Kas',
    'Humas & Hukum',
    'Pelayanan & Pemasaran',
    'Baca Meter Air & Langganan',
    'Pergudangan',
    'Sumber Daya Manusia',
    'Administrasi Umum',
    'Aset',
    'Koordinator Pengadaan Barang & Jasa Lainya',
    'Koordinator Pengadaan Konstruksi & Jasa Konsultasi',
    'Koordinator Pengawas Pelaksana Bidang Umum',
    'Koordinator Pengawas Pelaksana Bidang Teknik',
  ];

  final listKategori = <String>[
    'Sistem Informasi',
    'Infrastruktur',
  ];

  String? validateForm() {
    if (bagian.value.isEmpty) return "Semua kolom harus dipilih & diisi !!";
    if (kategoriPengaduan.value.isEmpty) {
      return "Kategori pengaduan harus dipilih";
    }
    if (noHandphone.text.isEmpty) return "No Handphone harus diisi";
    if (uraianPengaduan.text.isEmpty) return "Uraian pengaduan harus diisi";
    return null;
  }

  Future<void> submitPengaduan() async {
    final error = validateForm();
    if (error != null) {
      Get.snackbar("Terjadi kesalahan", error,
          snackPosition: SnackPosition.TOP, colorText: Colors.black);
      return;
    }

    try {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar("Error", "Anda harus login terlebih dahulu",
            snackPosition: SnackPosition.TOP, colorText: Colors.black);
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final namaPengirim =
          userDoc.exists ? (userDoc.data()?['name'] ?? 'User') : 'User';

      final ticketInfo = await TicketNumberService.reserveNext();
      final ticketId = ticketInfo['number'] as String;
      final ticketIndex = ticketInfo['index'] as int;

      await FirebaseFirestore.instance
          .collection('pengaduan')
          .doc(ticketId)
          .set({
        'ticketId': ticketId,
        'ticketIndex': ticketIndex,
        'uid': user.uid,
        'namaPengirim': namaPengirim,
        'bagian': bagian.value,
        'kategoriPengaduan': kategoriPengaduan.value,
        'noHandphone': noHandphone.text,
        'uraianPengaduan': uraianPengaduan.text,
        'status': 'Pending',
        'tanggal': FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        "Berhasil",
        "Ticket pengaduan berhasil dikirim\nNomor Tiket: $ticketId",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black,
      );

      bagian.value = "";
      kategoriPengaduan.value = "";
      noHandphone.clear();
      uraianPengaduan.clear();
    } catch (e) {
      Get.snackbar("Terjadi kesalahan", "Gagal mengirim ticket: $e",
          snackPosition: SnackPosition.TOP, colorText: Colors.black);
    } finally {
      isLoading.value = false;
    }
  }
}
