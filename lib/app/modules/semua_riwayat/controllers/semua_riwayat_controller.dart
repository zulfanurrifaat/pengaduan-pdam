import 'package:get/get.dart';

class SemuaRiwayatController extends GetxController {
  var riwayatData = [
    {
      "bagian": "Laboratorium",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "081577234892",
      "uraian pengaduan":
          "Sistem pengelolaan data pelanggan sering mengalami gangguan",
      "status": "Selesai"
    },
    {
      "bagian": "Instalasi Wilayah",
      "kategori pengaduan": "Infrastruktur",
      "no handphone": "089574352231",
      "uraian pengaduan": "Banyak pipa bocor karena sudah tua",
      "status": "Pending"
    },
    {
      "bagian": "Pengawasan Teknik",
      "kategori pengaduan": "Infrastruktur",
      "no handphone": "089522036542",
      "uraian pengaduan": "",
      "status": "Diproses"
    },
    {
      "bagian": "Sumber Air",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "081567438892",
      "uraian pengaduan": "",
      "status": "Selesai"
    },
    {
      "bagian": "Humas",
      "kategori pengaduan": "Infrastruktur",
      "no handphone": "089522036976",
      "uraian pengaduan": "",
      "status": "Pending"
    },
    {
      "bagian": "Peralatan",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "085521036592",
      "uraian pengaduan": "",
      "status": "Diproses"
    },
    {
      "bagian": "Keuangan",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "081572036532",
      "uraian pengaduan": "",
      "status": "Selesai"
    },
    {
      "bagian": "Perencanaan Teknik",
      "kategori pengaduan": "Infrastruktur",
      "no handphone": "089528036542",
      "uraian pengaduan": "",
      "status": "Diproses"
    },
    {
      "bagian": "Umum",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "085522686542",
      "uraian pengaduan": "",
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
