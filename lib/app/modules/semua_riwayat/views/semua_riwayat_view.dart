import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_pages.dart';
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
          'SEMUA PENGADUAN',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.riwayatData.length,
            itemBuilder: (context, index) {
              final riwayat = controller.riwayatData[index];
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
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            riwayat['kategori pengaduan'] ?? "Tidak Tersedia",
                            style: GoogleFonts.lato(
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
                              color: _getStatusColor(riwayat['status']),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              riwayat['status'] ?? "Pending",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        riwayat['uraian pengaduan'] ?? "Uraian tidak tersedia",
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            riwayat['no handphone'] ?? "Tidak tersedia",
                            style: GoogleFonts.lato(
                              fontSize: 13,
                              color: Colors.blue.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
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
