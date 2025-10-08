import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

import 'package:pengaduan/app/services/pdf_report_service.dart';

class HomeAdminController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final tickets = <Map<String, dynamic>>[].obs;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _sub;

  final isExporting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _listenTickets();
  }

  void _listenTickets() {
    _sub?.cancel();
    _sub = firestore.collection('pengaduan').snapshots().listen((snapshot) {
      final list = snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = doc.id;
        _normalizeKeysInPlace(data);
        return data;
      }).toList();

      list.sort((a, b) {
        final ta = a['tanggal'] ?? a['createdAt'] ?? a['updatedAt'];
        final tb = b['tanggal'] ?? b['createdAt'] ?? b['updatedAt'];
        if (ta == null && tb == null) return 0;
        if (ta == null) return 1;
        if (tb == null) return -1;
        try {
          return (tb as Timestamp).compareTo(ta as Timestamp);
        } catch (_) {
          return tb.toString().compareTo(ta.toString());
        }
      });

      tickets.assignAll(list);
    }, onError: (e) {
      Get.snackbar("Error", "Gagal memuat tiket: $e",
          snackPosition: SnackPosition.TOP);
      tickets.clear();
    });
  }

  void _normalizeKeysInPlace(Map<String, dynamic> d) {
    d['kategoriPengaduan'] = d['kategoriPengaduan'] ?? d['kategori pengaduan'];
    d['kategori pengaduan'] = d['kategori pengaduan'] ?? d['kategoriPengaduan'];

    d['noHandphone'] = d['noHandphone'] ?? d['no handphone'];
    d['no handphone'] = d['no handphone'] ?? d['noHandphone'];

    d['uraianPengaduan'] = d['uraianPengaduan'] ?? d['uraian pengaduan'];
    d['uraian pengaduan'] = d['uraian pengaduan'] ?? d['uraianPengaduan'];

    d['namaPengirim'] = d['namaPengirim'] ?? d['nama pengirim'];

    // tanggal fallback
    d['tanggal'] = d['tanggal'] ?? d['createdAt'] ?? d['updatedAt'];

    // identitas tiket (untuk tampilan & notifikasi)
    d['ticketNumber'] = d['ticketNumber'] ?? d['ticketId'] ?? d['id'];
    d['ticketId'] = d['ticketId'] ?? d['id'];
  }

  /// Kirim tanggapan - update dokumen + notifikasi user (dengan prefix nomor tiket).
  Future<bool> respondToTicket(String ticketId, String response) async {
    try {
      final docRef = firestore.collection('pengaduan').doc(ticketId);
      final snap = await docRef.get();
      final data = snap.data();
      if (data == null) throw "Dokumen pengaduan tidak ditemukan";
      final uid = (data['uid'] ?? '').toString();

      // prefix nomor tiket untuk konsistensi notifikasi
      final ticketNumber =
          (data['ticketNumber'] ?? data['ticketId'] ?? '').toString();
      final prefix = ticketNumber.isNotEmpty ? '[$ticketNumber] ' : '';

      await docRef.update({
        'tanggapan': response,
        'updatedAt': FieldValue.serverTimestamp(),
        'lastUpdatedBy': 'admin',
      });

      if (uid.isNotEmpty) {
        await firestore
            .collection('users')
            .doc(uid)
            .collection('notifications')
            .add({
          'type': 'response',
          'ticketId': ticketId,
          'title': '${prefix}Tanggapan dari admin:',
          'body': response,
          'createdAt': FieldValue.serverTimestamp(),
          'read': false,
        });
      }

      return true;
    } catch (e) {
      Get.snackbar("Error", "Gagal mengirim tanggapan: $e",
          snackPosition: SnackPosition.TOP);
      return false;
    }
  }

  /// Ubah status - update dokumen + notifikasi user (dengan prefix nomor tiket).
  Future<bool> updateTicketStatus(String ticketId, String status) async {
    try {
      final docRef = firestore.collection('pengaduan').doc(ticketId);
      final snap = await docRef.get();
      final data = snap.data();
      if (data == null) throw "Dokumen pengaduan tidak ditemukan";
      final uid = (data['uid'] ?? '').toString();

      // prefix nomor tiket untuk konsistensi notifikasi
      final ticketNumber =
          (data['ticketNumber'] ?? data['ticketId'] ?? '').toString();
      final prefix = ticketNumber.isNotEmpty ? '[$ticketNumber] ' : '';

      await docRef.update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
        'lastUpdatedBy': 'admin',
      });

      String title;
      switch (status) {
        case 'Diproses':
          title =
              '${prefix}Pengaduan anda sedang di proses, Cek detailnya disini!!';
          break;
        case 'Selesai':
          title =
              '${prefix}Pengaduan anda sudah selesai!, Cek detailnya disini!!';
          break;
        case 'Pending':
        default:
          title =
              '${prefix}Pengaduan anda sedang pending!, Cek detailnya disini!!';
          break;
      }

      if (uid.isNotEmpty) {
        await firestore
            .collection('users')
            .doc(uid)
            .collection('notifications')
            .add({
          'type': 'status',
          'ticketId': ticketId,
          'title': title,
          'body': '',
          'createdAt': FieldValue.serverTimestamp(),
          'read': false,
        });
      }

      return true;
    } catch (e) {
      Get.snackbar("Error", "Gagal mengubah status: $e",
          snackPosition: SnackPosition.TOP);
      return false;
    }
  }

  /// Export tiket ke PDF
  Future<void> exportTicketsToPdf() async {
    if (isExporting.value) return;
    isExporting.value = true;
    try {
      final file = await PdfReportService.buildTicketsPdf(
        tickets: tickets.toList(),
        generatedBy: 'Admin',
      );
      await OpenFilex.open(file.path);
      Get.snackbar("Sukses", "Laporan PDF berhasil dibuat.",
          snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar("Error", "Gagal membuat PDF: $e",
          snackPosition: SnackPosition.TOP);
    } finally {
      isExporting.value = false;
    }
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
