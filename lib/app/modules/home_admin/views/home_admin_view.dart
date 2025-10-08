import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pengaduan/app/modules/detail_pengaduan/views/detail_pengaduan_view.dart';
import 'package:pengaduan/app/modules/detail_pengaduan/controllers/detail_pengaduan_controller.dart';
import '../controllers/home_admin_controller.dart';

class HomeAdminView extends GetView<HomeAdminController> {
  const HomeAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'DAFTAR TICKET PENGADUAN',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final exporting = controller.isExporting.value;
              return Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: exporting ? null : controller.exportTicketsToPdf,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0082C6),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.picture_as_pdf,
                            size: 20, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          exporting ? "Mencetak..." : "Cetak data pengaduan",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),
            Container(
              height: 1,
              color: Colors.grey.shade300,
              margin: const EdgeInsets.only(bottom: 12),
            ),
            Expanded(
              child: Obx(() {
                final items =
                    List<Map<String, dynamic>>.from(controller.tickets);

                if (items.isEmpty) {
                  return const Center(
                    child: Text("Belum ada tiket pengaduan."),
                  );
                }

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final t = items[index];

                    final kategori = t['kategoriPengaduan'] ??
                        t['kategori pengaduan'] ??
                        "Tidak Tersedia";
                    final uraian = t['uraianPengaduan'] ??
                        t['uraian pengaduan'] ??
                        "Uraian tidak tersedia";
                    final namaPengirim = t['namaPengirim'] ?? "User";
                    final noHp = t['no handphone'] ??
                        t['noHandphone'] ??
                        "Tidak tersedia";
                    final status = t['status'] ?? "Pending";

                    final ts = (t['tanggal'] ?? t['createdAt']);
                    final tanggalStr = _formatTanggal(ts);

                    final nomorTiket =
                        t['ticketNumber'] ?? t['ticketId'] ?? '-';

                    final argsForDetail = {
                      'id': t['id'],
                      'bagian': t['bagian'] ?? t['Bagian'],
                      'kategoriPengaduan':
                          t['kategoriPengaduan'] ?? t['kategori pengaduan'],
                      'noHandphone': t['noHandphone'] ?? t['no handphone'],
                      'uraianPengaduan':
                          t['uraianPengaduan'] ?? t['uraian pengaduan'],
                    };

                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const DetailPengaduanView(),
                          arguments: argsForDetail,
                          binding: BindingsBuilder.put(
                            () => DetailPengaduanController(),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
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
                                Text(
                                  namaPengirim,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "No. Tiket: $nomorTiket",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        kategori,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  uraian,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
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
                                      noHp,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.blue.shade400,
                                      ),
                                    ),
                                    const SizedBox(width: 50),
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      tanggalStr,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 6),
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
                                _TicketMenuButton(ticket: t),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
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

  String _formatTanggal(dynamic v) {
    if (v == null) return '-';
    if (v is Timestamp) {
      return DateFormat('dd MMMM yyyy', 'id_ID').format(v.toDate());
    }
    if (v is DateTime) {
      return DateFormat('dd MMMM yyyy', 'id_ID').format(v);
    }
    return '-';
  }
}

class _TicketMenuButton extends StatelessWidget {
  final Map<String, dynamic> ticket;
  const _TicketMenuButton({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.blue.shade50,
      onSelected: (value) async {
        if (value == "Tanggapi") {
          _showResponseDialog(context, ticket);
        } else if (value == "Ubah Status") {
          _showStatusDialog(context, ticket);
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: "Tanggapi", child: Text("Tanggapi")),
        PopupMenuItem(value: "Ubah Status", child: Text("Ubah Status")),
      ],
      icon: const Icon(Icons.more_vert),
    );
  }

  static void _showResponseDialog(
      BuildContext context, Map<String, dynamic> t) {
    final responseController =
        TextEditingController(text: t['tanggapan'] ?? '');

    Get.dialog(
      AlertDialog(
        title: const Text("Tanggapi Ticket"),
        content: TextField(
          controller: responseController,
          decoration: const InputDecoration(labelText: "Masukkan Tanggapan"),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () async {
              final docId = t['id'] as String?;
              if (docId == null) {
                Get.snackbar("Error", "ID dokumen tidak ditemukan",
                    snackPosition: SnackPosition.TOP);
                return;
              }
              final text = responseController.text.trim();
              if (text.isEmpty) {
                Get.snackbar("Error", "Tanggapan tidak boleh kosong",
                    snackPosition: SnackPosition.TOP);
                return;
              }

              final ok = await Get.find<HomeAdminController>()
                  .respondToTicket(docId, text);

              if (ok) {
                Get.back();
                Future.delayed(const Duration(milliseconds: 80), () {
                  Get.snackbar("Berhasil", "Tanggapan sudah terkirim ke user..",
                      snackPosition: SnackPosition.TOP);
                });
              }
            },
            child: const Text("Kirim"),
          ),
        ],
      ),
    );
  }

  static void _showStatusDialog(BuildContext context, Map<String, dynamic> t) {
    Get.dialog(
      AlertDialog(
        title: const Text("Ubah Status Ticket"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Pending"),
              onTap: () async {
                final ok = await _updateStatusAndCloseDialog(t, "Pending");
                if (ok) {
                  Get.snackbar("Berhasil", "Status telah diubah!",
                      snackPosition: SnackPosition.TOP);
                }
              },
            ),
            ListTile(
              title: const Text("Diproses"),
              onTap: () async {
                final ok = await _updateStatusAndCloseDialog(t, "Diproses");
                if (ok) {
                  Get.snackbar("Berhasil", "Status telah diubah!",
                      snackPosition: SnackPosition.TOP);
                }
              },
            ),
            ListTile(
              title: const Text("Selesai"),
              onTap: () async {
                final ok = await _updateStatusAndCloseDialog(t, "Selesai");
                if (ok) {
                  Get.snackbar("Berhasil", "Status telah diubah!",
                      snackPosition: SnackPosition.TOP);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool> _updateStatusAndCloseDialog(
      Map<String, dynamic> t, String status) async {
    final docId = t['id'] as String?;
    if (docId == null) {
      Get.snackbar("Error", "ID dokumen tidak ditemukan",
          snackPosition: SnackPosition.TOP);
      return false;
    }
    final ok =
        await Get.find<HomeAdminController>().updateTicketStatus(docId, status);
    if (ok) Get.back();
    return ok;
  }
}
