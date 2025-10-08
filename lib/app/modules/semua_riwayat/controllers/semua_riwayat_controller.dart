import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SemuaRiwayatController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _fs = FirebaseFirestore.instance;

  /// daftar semua riwayat user (terbaru di atas)
  final items = <Map<String, dynamic>>[].obs;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _sub;

  @override
  void onInit() {
    super.onInit();
    _listenAllRiwayat();
  }

  void _listenAllRiwayat() {
    final user = _auth.currentUser;
    if (user == null) return;

    _sub?.cancel();
    _sub = _fs
        .collection('pengaduan')
        .where('uid', isEqualTo: user.uid)
        .orderBy('tanggal', descending: true)
        .snapshots()
        .listen((snap) {
      final list = snap.docs.map((d) {
        final m = Map<String, dynamic>.from(d.data());
        m['id'] = d.id;
        _normalizeKeysInPlace(m);
        m['tanggalFormatted'] = _formatTanggal(_pickTimestamp(m));
        return m;
      }).toList();

      items.assignAll(list);
    }, onError: (e) {
      Get.snackbar("Error", "Gagal memuat riwayat: $e",
          snackPosition: SnackPosition.TOP);
      items.clear();
    });
  }

  /// Ambil timestamp utama (tanggal > createdAt > updatedAt)
  Timestamp? _pickTimestamp(Map<String, dynamic> m) {
    final a = m['tanggal'];
    final b = m['createdAt'];
    final c = m['updatedAt'];
    if (a is Timestamp) return a;
    if (b is Timestamp) return b;
    if (c is Timestamp) return c;
    return null;
  }

  /// Format: 12 Desember 2024 (locale: id_ID)
  String _formatTanggal(Timestamp? ts) {
    if (ts == null) return '-';
    try {
      final d = ts.toDate();
      return DateFormat('d MMMM yyyy', 'id_ID').format(d);
    } catch (_) {
      return '-';
    }
  }

  /// Samakan key yang mungkin beda penamaan
  void _normalizeKeysInPlace(Map<String, dynamic> d) {
    d['kategoriPengaduan'] = d['kategoriPengaduan'] ?? d['kategori pengaduan'];
    d['kategori pengaduan'] = d['kategori pengaduan'] ?? d['kategoriPengaduan'];

    d['noHandphone'] = d['noHandphone'] ?? d['no handphone'];
    d['no handphone'] = d['no handphone'] ?? d['noHandphone'];

    d['uraianPengaduan'] = d['uraianPengaduan'] ?? d['uraian pengaduan'];
    d['uraian pengaduan'] = d['uraian pengaduan'] ?? d['uraianPengaduan'];

    d['namaPengirim'] = d['namaPengirim'] ?? d['nama pengirim'];
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
