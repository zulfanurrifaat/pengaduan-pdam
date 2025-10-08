import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailPengaduanController extends GetxController {
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  final Rxn<Map<String, dynamic>> data = Rxn<Map<String, dynamic>>();

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _sub;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is Map<String, dynamic>) {
      final map = Map<String, dynamic>.from(args);
      final docId = _extractId(map);

      if (docId != null && docId.isNotEmpty) {
        _listenDoc(docId);
      } else {
        data.value = map;
      }
    } else if (args is String) {
      final id = args.trim();
      if (id.isNotEmpty) {
        _listenDoc(id);
      } else {
        data.value = <String, dynamic>{};
      }
    } else {
      data.value = <String, dynamic>{};
    }
  }

  String? _extractId(Map<String, dynamic> m) {
    final candidates = ['id', 'ticketId', 'docId', 'documentId'];
    for (final k in candidates) {
      final v = m[k];
      if (v is String && v.trim().isNotEmpty) return v.trim();
    }
    return null;
  }

  void _listenDoc(String docId) {
    _sub?.cancel();
    _sub = _fs.collection('pengaduan').doc(docId).snapshots().listen((snap) {
      if (snap.exists) {
        final d = Map<String, dynamic>.from(snap.data()!);
        d['id'] = snap.id;
        _normalizeKeysInPlace(d);
        data.value = d;
      } else {
        data.value = <String, dynamic>{'id': docId};
      }
    }, onError: (_) {});
  }

  void _normalizeKeysInPlace(Map<String, dynamic> d) {
    d['kategoriPengaduan'] = d['kategoriPengaduan'] ?? d['kategori pengaduan'];
    d['kategori pengaduan'] = d['kategori pengaduan'] ?? d['kategoriPengaduan'];

    d['noHandphone'] = d['noHandphone'] ?? d['no handphone'];
    d['no handphone'] = d['no handphone'] ?? d['noHandphone'];

    d['uraianPengaduan'] = d['uraianPengaduan'] ?? d['uraian pengaduan'];
    d['uraian pengaduan'] = d['uraian pengaduan'] ?? d['uraianPengaduan'];

    d['bagian'] = d['bagian'] ?? d['Bagian'];
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
