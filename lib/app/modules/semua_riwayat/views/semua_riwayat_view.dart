import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/semua_riwayat_controller.dart';

class SemuaRiwayatView extends GetView<SemuaRiwayatController> {
  const SemuaRiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    final riwayatData = [
      {"tanggal": "20-11-2024", "waktu": "09.11", "bagian": "Laboratotium"},
      {
        "tanggal": "21-11-2024",
        "waktu": "10.00",
        "bagian": "Instalasi Wilayah"
      },
      {
        "tanggal": "22-11-2024",
        "waktu": "11.30",
        "bagian": "Pengawasan Teknik"
      },
      {"tanggal": "23-11-2024", "waktu": "13.45", "bagian": "Sumber Air"},
      {"tanggal": "24-11-2024", "waktu": "15.20", "bagian": "Humas"},
      {"tanggal": "24-11-2024", "waktu": "15.20", "bagian": "Peralatan"},
      {"tanggal": "24-11-2024", "waktu": "15.20", "bagian": "Keuangan"},
      {
        "tanggal": "24-11-2024",
        "waktu": "15.20",
        "bagian": "Perencanaan Teknik"
      },
      {"tanggal": "24-11-2024", "waktu": "15.20", "bagian": "Umum"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('SEMUA PENGADUAN'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: riwayatData.length,
          itemBuilder: (context, index) {
            final riwayat = riwayatData[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    print("Item ${index + 1} diklik");
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal : ${riwayat['tanggal']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Waktu : ${riwayat['waktu']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Bagian : ${riwayat['bagian']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
