import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/semua_riwayat_controller.dart';

class SemuaRiwayatView extends GetView<SemuaRiwayatController> {
  const SemuaRiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    final riwayatData = [
      {"tanggal": "20-11-2024", "waktu": "09.11", "bidang": "Litbang TI"},
      {"tanggal": "21-11-2024", "waktu": "10.00", "bidang": "Litbang Teknik"},
      {"tanggal": "22-11-2024", "waktu": "11.30", "bidang": "Litbang Teknik"},
      {
        "tanggal": "23-11-2024",
        "waktu": "13.45",
        "bidang": "Litbang ADM & UMUM"
      },
      {"tanggal": "24-11-2024", "waktu": "15.20", "bidang": "Litbang TI"},
      {
        "tanggal": "24-11-2024",
        "waktu": "15.20",
        "bidang": "Litbang ADM & UMUM"
      },
      {"tanggal": "24-11-2024", "waktu": "15.20", "bidang": "Litbang Teknik"},
      {"tanggal": "24-11-2024", "waktu": "15.20", "bidang": "Litbang TI"},
      {
        "tanggal": "24-11-2024",
        "waktu": "15.20",
        "bidang": "Litbang ADM & UMUM"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('SEMUA RIWAYAT'),
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
                          "Bidang : ${riwayat['bidang']}",
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
