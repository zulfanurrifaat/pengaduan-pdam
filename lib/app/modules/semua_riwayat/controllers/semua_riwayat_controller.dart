import 'package:get/get.dart';

class SemuaRiwayatController extends GetxController {
  var riwayatData = [
    {
      "bagian": "Laboratorium",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "081577234892",
      "uraian pengaduan":
          "Sistem pengelolaan data pelanggan mengalami gangguan",
      "status": "Pending"
    },
    {
      "bagian": "Instalasi Wilayah",
      "kategori pengaduan": "Infrastruktur",
      "no handphone": "089574352231",
      "uraian pengaduan": "Sistem monitoring instalasi wilayah eror",
      "status": "Pending"
    },
    {
      "bagian": "Pengawasan Teknik",
      "kategori pengaduan": "Infrastruktur",
      "no handphone": "089522036542",
      "uraian pengaduan": "printer eror",
      "status": "Diproses"
    },
    {
      "bagian": "Sumber Air",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "081567438892",
      "uraian pengaduan":
          "Sistem monitoring kualitas sumber air tidak memberikan data terbaru selama dua hari terakhir.",
      "status": "Diproses"
    },
    {
      "bagian": "Humas",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "089522036976",
      "uraian pengaduan":
          "Platform pengaduan online pelanggan mengalami kendala pada bagian pengunggahan dokumen pendukung.",
      "status": "Selesai"
    },
    {
      "bagian": "Peralatan",
      "kategori pengaduan": "Infrastruktur",
      "no handphone": "085521036592",
      "uraian pengaduan": "Komputer eror",
      "status": "Selesai"
    },
    {
      "bagian": "Keuangan",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "081572036532",
      "uraian pengaduan":
          "Sistem pembayaran online mengalami kendala, di mana tagihan pelanggan tidak muncul secara real-time ",
      "status": "Selesai"
    },
    {
      "bagian": "Perencanaan Teknik",
      "kategori pengaduan": "Infrastruktur",
      "no handphone": "089528036542",
      "uraian pengaduan": "printer eror",
      "status": "Selesai"
    },
    {
      "bagian": "Umum",
      "kategori pengaduan": "Sistem Informasi",
      "no handphone": "085522686542",
      "uraian pengaduan":
          "Website resmi PDAM mengalami gangguan saat diakses untuk cek tagihan.",
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
