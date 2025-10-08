import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pengaduan/app/modules/detail_pengaduan/controllers/detail_pengaduan_controller.dart';
import 'package:pengaduan/app/modules/detail_pengaduan/views/detail_pengaduan_view.dart';
import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Kotak Masuk', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        final notifications = controller.items;
        if (notifications.isEmpty) {
          return const Center(child: Text('Belum ada notifikasi'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final n = notifications[index];

            final String type = (n['type'] ?? '').toString();
            final String title = (n['title'] ?? '').toString();
            final String body = (n['body'] ?? '').toString();
            final String? notifId = n['id'] as String?;
            final String? ticketId = n['ticketId'] as String?;
            final Timestamp? ts = n['createdAt'] as Timestamp?;
            final bool read = n['read'] == true;

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
                  child: const Icon(
                    Icons.notifications_active,
                    color: Color(0xFF0082C6),
                    size: 24,
                  ),
                ),
                title: Text(
                  type == 'response' ? 'Tanggapan dari admin:' : title,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: read ? FontWeight.w500 : FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (type == 'response')
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: Text(
                          body.isEmpty ? '-' : body,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    Text(
                      _formatTanggal(ts),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () async {
                  if (notifId != null) {
                    await controller.markAsRead(notifId);
                  }
                  final data = await controller.fetchTicketById(ticketId);
                  if (data != null) {
                    Get.to(
                      () => const DetailPengaduanView(),
                      arguments: data,
                      binding: BindingsBuilder.put(
                        () => DetailPengaduanController(),
                      ),
                    );
                  } else {
                    Get.snackbar("Info", "Detail pengaduan tidak ditemukan.",
                        snackPosition: SnackPosition.TOP);
                  }
                },
              ),
            );
          },
        );
      }),
    );
  }

  String _formatTanggal(Timestamp? ts) {
    if (ts == null) return '-';
    final d = ts.toDate();
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    final b = bulan[d.month - 1];
    return '${d.day} $b ${d.year}';
  }
}
