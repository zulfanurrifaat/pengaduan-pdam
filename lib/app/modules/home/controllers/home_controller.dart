import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  var riwayatData = [
    {
      "bagian": "Administrasi Umum",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "081577234892",
      "uraian pengaduan":
          "Sistem pengelolaan data pelanggan mengalami gangguan",
      "status": "Selesai"
    },
    {
      "bagian": "Keuangan",
      "kategori pengaduan": "Infrastruktur",
      "no handphone": "089574352231",
      "uraian pengaduan": "Jaringan down",
      "status": "Selesai"
    },
    {
      "bagian": "Humas",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "089522036542",
      "uraian pengaduan": "Software desain eror",
      "status": "Selesai"
    },
    {
      "bagian": "Keuangan",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "081567438892",
      "uraian pengaduan": "Printer rusak",
      "status": "Selesai"
    },
    {
      "bagian": "Humas",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "089522036976",
      "uraian pengaduan": "Printer eror",
      "status": "Selesai"
    },
    {
      "bagian": "Sumber Daya Manusia",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "085521036592",
      "uraian pengaduan": "Data Pegawai corrupt",
      "status": "Selesai"
    },
  ].obs;

  var total = 0.obs;
  var pending = 0.obs;
  var diproses = 0.obs;
  var selesai = 0.obs;

  /// 👉 tambahan supaya nama user dinamis
  var namaUser = "".obs;

  @override
  void onInit() {
    super.onInit();
    hitungStatusPengaduan();
    ambilNamaUser(); // panggil saat controller diinisialisasi
  }

  void hitungStatusPengaduan() {
    total.value = riwayatData.length;
    pending.value = riwayatData
        .where((riwayat) => riwayat['status'] == 'Pending')
        .toList()
        .length;

    diproses.value = riwayatData
        .where((riwayat) => riwayat['status'] == 'Diproses')
        .toList()
        .length;

    selesai.value = riwayatData
        .where((riwayat) => riwayat['status'] == 'Selesai')
        .toList()
        .length;
  }

  /// 🔑 ambil nama user dari Firestore berdasarkan UID Firebase Auth
  void ambilNamaUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        namaUser.value = snapshot.data()?['name'] ?? "User";
      } else {
        namaUser.value = "User";
      }
    } else {
      namaUser.value = "User";
    }
  }
}
