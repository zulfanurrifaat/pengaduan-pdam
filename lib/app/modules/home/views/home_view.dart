import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Container(
                  height: 330,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0082C6),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ======= HEADER LOGO & NOTIFIKASI =======
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/pdaamm.png',
                            width: 80,
                            height: 57,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "PERUMDAM",
                                style:
                                    TextStyle(fontSize: 8, color: Colors.white),
                              ),
                              Text(
                                "TIRTA WIJAYA",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.NOTIFIKASI);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ======= HALO USER =======
                  Obx(() => Text(
                        "Halo, ${controller.namaUser.value}",
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )),

                  const SizedBox(height: 15),

                  // ======= KOTAK AKTIVITAS =======
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Aktivitasmu bulan ini",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem("Total", controller.total),
                            _buildStatItem("Pending", controller.pending),
                            _buildStatItem("Diproses", controller.diproses),
                            _buildStatItem("Selesai", controller.selesai),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ======= TOMBOL BUAT TICKET =======
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.FORM_PENGAJUAN);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buat ticket pengaduan',
                            style: GoogleFonts.lato(
                              color: const Color(0xFF0082C6),
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.mail,
                            color: Color(0xFF0082C6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ======= JUDUL RIWAYAT =======
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Riwayat pengaduan",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.SEMUA_RIWAYAT);
                        },
                        child: Text(
                          "Lihat semua...",
                          style: GoogleFonts.lato(color: Colors.blue.shade400),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // ======= LISTVIEW RIWAYAT SCROLLABLE =======
                  Expanded(
                    child: Obx(
                      () {
                        if (controller.riwayatData.isEmpty) {
                          return const Center(
                              child: Text("Belum ada pengaduan"));
                        }
                        return ListView.builder(
                          itemCount: controller.riwayatData.length,
                          itemBuilder: (context, index) {
                            final riwayat = controller.riwayatData[index];
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_PENGADUAN,
                                    arguments: riwayat);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          riwayat['kategori pengaduan'] ??
                                              "Tidak Tersedia",
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
                                            color: _getStatusColor(
                                                riwayat['status']),
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                      riwayat['uraian pengaduan'] ??
                                          "Uraian tidak tersedia",
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
                                          riwayat['no handphone'] ??
                                              "Tidak tersedia",
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // ======= NAVBAR =======
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixed,
        backgroundColor: const Color(0xFF0082C6),
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.add, title: 'Ajukan'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 0,
        onTap: (int index) {
          if (index == 1) {
            Get.toNamed(Routes.FORM_PENGAJUAN);
          } else if (index == 0) {
            // Jangan reload Home lagi biar tidak duplikat
          } else if (index == 2) {
            Get.toNamed(Routes.PROFILE);
          }
        },
      ),
    );
  }

  // Warna status pengaduan
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

  // Item statistik
  Widget _buildStatItem(String title, RxInt value) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 5),
        Obx(
          () => Text(
            "${value.value}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade400,
            ),
          ),
        ),
      ],
    );
  }
}
