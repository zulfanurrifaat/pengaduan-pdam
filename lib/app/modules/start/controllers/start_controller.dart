import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pengaduan/app/routes/app_pages.dart';

class StartController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _fs = FirebaseFirestore.instance;

  StreamSubscription<User?>? _sub;
  bool _navigated = false;

  @override
  void onInit() {
    super.onInit();

    _sub = _auth.authStateChanges().listen((user) {
      _maybeNavigate(user);
    });

    _maybeNavigate(_auth.currentUser);
  }

  Future<void> _maybeNavigate(User? user) async {
    if (_navigated) return;

    if (user == null) return;

    if (!user.emailVerified) return;

    try {
      final snap = await _fs.collection('users').doc(user.uid).get();
      final role = (snap.data()?['role'] ?? '').toString();

      _navigated = true;

      if (role == 'admin') {
        Get.offAllNamed(Routes.HOME_ADMIN);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (_) {
      // Gagal baca role -> tetap di Start biar user bisa login ulang
    }
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
