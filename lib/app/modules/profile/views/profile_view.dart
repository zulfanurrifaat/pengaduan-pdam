import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:pengaduan/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final bool isFromAdminMainPage; // ✅ untuk bedakan versi admin/user

  const ProfileView({Key? key, this.isFromAdminMainPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('PROFILE'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snap.hasData && snap.data!.data() != null) {
            Map<String, dynamic> user = snap.data!.data()!;
            String defaultImage =
                "https://ui-avatars.com/api/?name=${user['name']}&timestamp=${DateTime.now().millisecondsSinceEpoch}";

            bool isAdmin = user["role"] == "admin";

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // === Foto Profil ===
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          (user["profile"] != null && user["profile"] != "")
                              ? "${user["profile"]}?timestamp=${DateTime.now().millisecondsSinceEpoch}"
                              : defaultImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  user['name']?.toString().toUpperCase() ?? "-",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  user['email'] ?? "-",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 50),

                // === Update Profile ===
                ListTile(
                  onTap: () =>
                      Get.toNamed(Routes.UPDATE_PROFILE, arguments: user),
                  leading: const Icon(Icons.person, color: Color(0xFF0082C6)),
                  title: const Text("Update Profile"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                ),
                Divider(color: Colors.grey.shade200, thickness: 1),

                // === Update Password ===
                ListTile(
                  onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                  leading: const Icon(Icons.vpn_key, color: Color(0xFF0082C6)),
                  title: const Text("Update Password"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                ),
                Divider(color: Colors.grey.shade200, thickness: 1),

                // === Tambah Pegawai hanya untuk admin ===
                if (isAdmin) ...[
                  ListTile(
                    onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                    leading:
                        const Icon(Icons.person_add, color: Color(0xFF0082C6)),
                    title: const Text("Tambah Pegawai"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                  Divider(color: Colors.grey.shade200, thickness: 1),
                ],

                // === Logout ===
                ListTile(
                  onTap: () => controller.logout(),
                  leading: const Icon(Icons.logout, color: Color(0xFF0082C6)),
                  title: const Text("Logout"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                ),
                Divider(color: Colors.grey.shade200, thickness: 1),

                const SizedBox(height: 20),
              ],
            );
          }

          return const Center(
            child: Text("Tidak dapat memuat data user."),
          );
        },
      ),

      // ✅ Bottom Nav hanya muncul untuk user biasa
      bottomNavigationBar: isFromAdminMainPage
          ? null
          : ConvexAppBar(
              style: TabStyle.fixed,
              backgroundColor: const Color(0xFF0082C6),
              items: const [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.add, title: 'Ajukan'),
                TabItem(icon: Icons.people, title: 'Profile'),
              ],
              initialActiveIndex: 2, // aktifkan tab Profile
              onTap: (int index) {
                if (index == 1) {
                  Get.toNamed(Routes.FORM_PENGAJUAN);
                } else if (index == 0) {
                  Get.offAllNamed(Routes.HOME);
                } else if (index == 2) {
                  // sudah di profile, jangan reload
                }
              },
            ),
    );
  }
}
