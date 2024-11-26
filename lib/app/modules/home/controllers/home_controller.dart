import 'package:get/get.dart';

class HomeController extends GetxController {
 
  var riwayatData = [
    {
      "tanggal": "20-11-2024",
      "waktu": "09.11",
      "bagian": "Laboratotium",
      "status": "Selesai"
    },
    {
      "tanggal": "21-11-2024",
      "waktu": "10.00",
      "bagian": "Instalasi Wilayah",
      "status": "Pending"
    },
    {
      "tanggal": "22-11-2024",
      "waktu": "11.30",
      "bagian": "Pengawasan Teknik",
      "status": "Diproses"
    },
    {
      "tanggal": "23-11-2024",
      "waktu": "13.45",
      "bagian": "Sumber Air",
      "status": "Selesai"
    },
    {
      "tanggal": "24-11-2024",
      "waktu": "15.20",
      "bagian": "Humas",
      "status": "Pending"
    },
    {
      "tanggal": "24-11-2024",
      "waktu": "15.20",
      "bagian": "Peralatan",
      "status": "Diproses"
    },
    {
      "tanggal": "24-11-2024",
      "waktu": "15.20",
      "bagian": "Keuangan",
      "status": "Selesai"
    },
    {
      "tanggal": "24-11-2024",
      "waktu": "15.20",
      "bagian": "Perencanaan Teknik",
      "status": "Diproses"
    },
    {
      "tanggal": "24-11-2024",
      "waktu": "15.20",
      "bagian": "Umum",
      "status": "Selesai"
    },
  ].obs;

  var total = 0.obs;
  var pending = 0.obs;
  var diproses = 0.obs;
  var selesai = 0.obs;

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

  @override
  void onInit() {
    super.onInit();

    hitungStatusPengaduan();
  }
}
