import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_pengaduan_controller.dart';

class DetailPengaduanView extends GetView<DetailPengaduanController> {
  const DetailPengaduanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'DETAIL PENGADUAN',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final riwayat = controller.data.value ?? const <String, dynamic>{};

        String? _val(List<String> keys) {
          for (final k in keys) {
            final v = riwayat[k];
            if (v is String && v.trim().isNotEmpty) return v;
          }
          return null;
        }

        final bagian = _val(['bagian', 'Bagian']);
        final kategoriPengaduan =
            _val(['kategoriPengaduan', 'kategori pengaduan']);
        final noHandphone = _val(['noHandphone', 'no handphone']);
        final uraianPengaduan = _val(['uraianPengaduan', 'uraian pengaduan']);

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow("Bagian", bagian),
                  const SizedBox(height: 8),
                  _buildRow("Kategori Pengaduan", kategoriPengaduan),
                  const SizedBox(height: 8),
                  _buildRow("No Handphone", noHandphone),
                  const SizedBox(height: 8),
                  _buildRow("Uraian Pengaduan", uraianPengaduan),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildRow(String title, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value ?? "Tidak tersedia",
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
