import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  final namaUser = 'User'.obs;

  final riwayatData = <Map<String, dynamic>>[].obs;

  final total = 0.obs;
  final pending = 0.obs;
  final diproses = 0.obs;
  final selesai = 0.obs;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _sub;

  @override
  void onInit() {
    super.onInit();
    _loadUserName();
    _listenPengaduanUser();
  }

  Future<void> _loadUserName() async {
    final user = _auth.currentUser;
    if (user == null) {
      namaUser.value = 'User';
      return;
    }
    try {
      final snap = await _fs.collection('users').doc(user.uid).get();
      if (snap.exists) {
        final data = snap.data()!;
        final display = (data['name'] as String?)?.trim();
        namaUser.value = (display != null && display.isNotEmpty)
            ? display
            : (user.displayName ?? 'User');
      } else {
        namaUser.value = user.displayName ?? 'User';
      }
    } catch (_) {
      namaUser.value = user.displayName ?? 'User';
    }
  }

  void _listenPengaduanUser() {
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
        return m;
      }).toList();

      riwayatData.assignAll(list);
      _hitungStat(list);
    });
  }

  void _normalizeKeysInPlace(Map<String, dynamic> d) {
    d['kategoriPengaduan'] = d['kategoriPengaduan'] ?? d['kategori pengaduan'];
    d['kategori pengaduan'] = d['kategori pengaduan'] ?? d['kategoriPengaduan'];
    d['noHandphone'] = d['noHandphone'] ?? d['no handphone'];
    d['no handphone'] = d['no handphone'] ?? d['noHandphone'];
    d['uraianPengaduan'] = d['uraianPengaduan'] ?? d['uraian pengaduan'];
    d['uraian pengaduan'] = d['uraian pengaduan'] ?? d['uraianPengaduan'];
    d['bagian'] = d['bagian'] ?? d['Bagian'];

    // ⬇️ fallback tanggal agar view bisa selalu menampilkan
    d['tanggal'] = d['tanggal'] ?? d['createdAt'] ?? d['updatedAt'];
  }

  void _hitungStat(List<Map<String, dynamic>> list) {
    total.value = list.length;
    pending.value = list.where((e) => (e['status'] ?? '') == 'Pending').length;
    diproses.value =
        list.where((e) => (e['status'] ?? '') == 'Diproses').length;
    selesai.value = list.where((e) => (e['status'] ?? '') == 'Selesai').length;
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
