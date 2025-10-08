import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final bool fromTab;

  const HomeView({super.key, this.fromTab = false});

  const HomeView.fromTab({super.key}) : fromTab = true;

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
                  height: 350,
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
                  // LOGO + NOTIF
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/pdaamm.png',
                            width: 90,
                            height: 65,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "PERUMDAM",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "TIRTA WIJAYA",
                                style: TextStyle(
                                  fontSize: 15,
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
                  // HALO USER
                  Obx(
                    () => Text(
                      "Halo, ${controller.namaUser.value}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // KOTAK AKTIVITAS
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Aktivitasmu bulan ini",
                          style: TextStyle(
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

                  // TOMBOL BUAT TICKET
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.FORM_PENGAJUAN);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Buat ticket pengaduan',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF0082C6),
                            ),
                          ),
                          SizedBox(width: 15),
                          Icon(
                            Icons.mail,
                            color: Color(0xFF0082C6),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // JUDUL RIWAYAT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Riwayat pengaduan",
                        style: TextStyle(
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
                          style: TextStyle(color: Colors.blue.shade400),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // LISTVIEW RIWAYAT
                  Expanded(
                    child: Obx(() {
                      final items = List<Map<String, dynamic>>.from(
                          controller.riwayatData);
                      if (items.isEmpty) {
                        return const Center(child: Text("Belum ada pengaduan"));
                      }

                      final count = items.length >= 5 ? 5 : items.length;

                      return ListView.builder(
                        itemCount: count,
                        itemBuilder: (context, index) {
                          if (index >= items.length) {
                            return const SizedBox.shrink();
                          }
                          final riwayat = items[index];

                          //  tanggal dari 'tanggal' atau 'createdAt'
                          final ts =
                              (riwayat['tanggal'] ?? riwayat['createdAt']);
                          final tanggalStr = _formatTanggal(ts);

                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                Routes.DETAIL_PENGADUAN,
                                arguments: riwayat,
                              );
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
                                  Text(
                                    riwayat['namaPengirim'] ?? "User",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        riwayat['kategori pengaduan'] ??
                                            "Tidak Tersedia",
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
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone,
                                          size: 16, color: Colors.grey),
                                      const SizedBox(width: 5),
                                      Text(
                                        riwayat['no handphone'] ??
                                            "Tidak tersedia",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.blue.shade400,
                                        ),
                                      ),
                                      const SizedBox(width: 50),
                                      const Icon(Icons.calendar_today,
                                          size: 14, color: Colors.grey),
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
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // NAVBAR (tetap seperti semula)
      bottomNavigationBar: fromTab
          ? null
          : ConvexAppBar(
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
                } else if (index == 2) {
                  Get.toNamed(Routes.PROFILE);
                }
              },
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
