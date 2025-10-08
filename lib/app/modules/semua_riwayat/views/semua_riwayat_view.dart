import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan/app/routes/app_pages.dart';
import '../controllers/semua_riwayat_controller.dart';

class SemuaRiwayatView extends GetView<SemuaRiwayatController> {
  const SemuaRiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'SEMUA RIWAYAT PENGADUAN',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          final list = List<Map<String, dynamic>>.from(controller.items);

          if (list.isEmpty) {
            return const Center(child: Text('Belum ada pengaduan'));
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              if (index < 0 || index >= list.length) {
                return const SizedBox.shrink();
              }
              final riwayat = list[index];

              final namaPengirim = riwayat['namaPengirim'] ?? 'User';
              final kategori = riwayat['kategori pengaduan'] ??
                  riwayat['kategoriPengaduan'] ??
                  'Tidak Tersedia';
              final uraian = riwayat['uraian pengaduan'] ??
                  riwayat['uraianPengaduan'] ??
                  'Uraian tidak tersedia';
              final noHp = riwayat['no handphone'] ??
                  riwayat['noHandphone'] ??
                  'Tidak tersedia';
              final status = riwayat['status'] ?? 'Pending';
              final tanggalLabel = riwayat['tanggalFormatted'] ?? '-';

              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_PENGADUAN, arguments: riwayat);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama pengirim
                      Text(
                        namaPengirim,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Kategori + badge status (SAMAA seperti di HomeView)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kategori,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(status),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Uraian
                      Text(
                        uraian,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // No HP + ikon kalender + tanggal (SAMA persis gaya HomeView)
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            noHp,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue.shade400,
                            ),
                          ),
                          const SizedBox(width: 50),
                          const Icon(Icons.calendar_today,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            tanggalLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Pending":
        return Colors.red;
      case "Diproses":
        return Colors.blue;
      case "Selesai":
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
