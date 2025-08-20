import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../controllers/home_admin_controller.dart';
import 'package:pengaduan/app/routes/app_pages.dart';
import 'package:pengaduan/app/modules/profile/views/profile_view.dart';

class HomeAdminView extends GetView<HomeAdminController> {
  const HomeAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0; //

    return StatefulBuilder(
      builder: (context, setState) {
        final pages = [
          _buildHome(context),
          const ProfileView(isFromAdminMainPage: true),
        ];

        return Scaffold(
          body: pages[currentIndex],
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.react,
            backgroundColor: const Color(0xFF0082C6),
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.people, title: 'Profile'),
            ],
            initialActiveIndex: currentIndex,
            onTap: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'DASHBOARD ADMIN',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daftar Ticket Pengaduan",
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (controller.tickets.isEmpty) {
                  return const Center(
                    child: Text("Belum ada tiket pengaduan."),
                  );
                }
                return ListView.builder(
                  itemCount: controller.tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = controller.tickets[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: Colors.grey.shade200,
                      child: ListTile(
                        title: Text(
                          ticket['kategori'] ?? "Kategori Tidak Tersedia",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          ticket['uraian'] ?? "Uraian Tidak Tersedia",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        trailing: PopupMenuButton<String>(
                          color: Colors.blue.shade50,
                          onSelected: (value) {
                            if (value == "Tanggapi") {
                              _showResponseDialog(context, ticket, index);
                            } else if (value == "Ubah Status") {
                              _showStatusDialog(context, ticket, index);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: "Tanggapi",
                              child: Text("Tanggapi"),
                            ),
                            const PopupMenuItem(
                              value: "Ubah Status",
                              child: Text("Ubah Status"),
                            ),
                          ],
                        ),
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

  void _showResponseDialog(
      BuildContext context, Map<String, dynamic> ticket, int index) {
    final responseController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text("Tanggapi Ticket"),
        content: TextField(
          controller: responseController,
          decoration: const InputDecoration(
            labelText: "Masukkan Tanggapan",
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (responseController.text.isNotEmpty) {
                controller.respondToTicket(index, responseController.text);
                Get.back();
              } else {
                Get.snackbar("Error", "Tanggapan tidak boleh kosong");
              }
            },
            child: const Text("Kirim"),
          ),
        ],
      ),
    );
  }

  void _showStatusDialog(
      BuildContext context, Map<String, dynamic> ticket, int index) {
    Get.dialog(
      AlertDialog(
        title: const Text("Ubah Status Ticket"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Pending"),
              onTap: () {
                controller.updateTicketStatus(index, "Pending");
                Get.back();
              },
            ),
            ListTile(
              title: const Text("Diproses"),
              onTap: () {
                controller.updateTicketStatus(index, "Diproses");
                Get.back();
              },
            ),
            ListTile(
              title: const Text("Selesai"),
              onTap: () {
                controller.updateTicketStatus(index, "Selesai");
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
