import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pengaduan/app/modules/detail_pengaduan/views/detail_pengaduan_view.dart';
import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'date': '12 Desember 2024',
        'title':
            'Pengaduan anda sedang di proses! Cek detail pengaduan disini.',
        'bagian': 'Keuangan',
        'kategori pengaduan': 'Sistem Informasi',
        'no handphone': '081234567890',
        'uraian pengaduan': 'Komputer eror',
      },
      {
        'date': '10 Desember 2024',
        'title': 'Pengaduan anda sedang pending! Cek detail pengaduan disini.',
        'bagian': 'Administrasi Umum',
        'kategori pengaduan': 'Sistem Informasi',
        'no handphone': '081234567891',
        'uraian pengaduan':
            'Sistem pengelolaan data pelanggan sering mengalami gangguan ',
      },
      {
        'date': '7 Desember 2024',
        'title': 'Pengaduan anda selesai! Cek detail pengaduan disini.',
        'bagian': 'Administrasi Umum',
        'kategori pengaduan': 'Sistem Informasi',
        'no handphone': '081234567891',
        'uraian pengaduan': 'Printer eror',
      },
      {
        'date': '5 Desember 2024',
        'title': 'Pengaduan anda selesai! Cek detail pengaduan disini.',
        'bagian': 'Sumber Daya Manusia',
        'kategori pengaduan': 'Sistem Informasi',
        'no handphone': '081234567891',
        'uraian pengaduan': 'Printer eror',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Kotak Masuk',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            color: Colors.grey.shade100,
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue[100],
                child: Icon(
                  Icons.notifications_active,
                  color: const Color(0xFF0082C6),
                  size: 24,
                ),
              ),
              title: Text(
                notification['title']!,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                notification['date']!,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: () {
                Get.to(
                  () => DetailPengaduanView(),
                  arguments: notification,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
