import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NotifikasiController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  final items = <Map<String, dynamic>>[].obs;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subNotif;
  StreamSubscription<User?>? _subAuth;

  @override
  void onInit() {
    super.onInit();
    _subAuth = _auth.userChanges().listen((_) => _listenNotifications());
    _listenNotifications();
  }

  void _listenNotifications() {
    _subNotif?.cancel();
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      items.clear();
      return;
    }
    _subNotif = _fs
        .collection('users')
        .doc(uid)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snap) {
      final list = snap.docs.map((d) {
        final data = Map<String, dynamic>.from(d.data());
        data['id'] = d.id;
        return data;
      }).toList();
      items.assignAll(list);
    }, onError: (e) {
      Get.snackbar("Error", "Gagal memuat notifikasi: $e",
          snackPosition: SnackPosition.TOP);
      items.clear();
    });
  }

  Future<void> markAsRead(String notifId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    try {
      await _fs
          .collection('users')
          .doc(uid)
          .collection('notifications')
          .doc(notifId)
          .update({'read': true});
    } catch (_) {}
  }

  Future<Map<String, dynamic>?> fetchTicketById(String? ticketId) async {
    if (ticketId == null || ticketId.isEmpty) return null;
    try {
      final snap = await _fs.collection('pengaduan').doc(ticketId).get();
      if (!snap.exists) return null;
      final data = Map<String, dynamic>.from(snap.data()!);
      data['id'] = snap.id;
      return data;
    } catch (_) {
      return null;
    }
  }

  @override
  void onClose() {
    _subNotif?.cancel();
    _subAuth?.cancel();
    super.onClose();
  }
}
