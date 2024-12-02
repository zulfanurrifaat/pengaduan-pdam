import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('PROFILE'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 45,
              backgroundImage: const AssetImage('assets/images/foto.png'),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 20),
            Text(
              'ZULFA NURRIFAAT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'zulfanurrifaat@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Update Profile"),
                    onTap: () {
                      Get.toNamed(Routes.UPDATE_PROFILE);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.vpn_key),
                    title: const Text("Update Password"),
                    onTap: () {
                      Get.toNamed(Routes.UPDATE_PASSWORD);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                    onTap: () {
                      Get.offAllNamed(Routes.LOGIN);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixed,
        backgroundColor: Colors.blue.shade400,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.add, title: 'Ajukan'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 2,
        onTap: (int index) {
          if (index == 0) {
            Get.offNamed(Routes.HOME);
          } else if (index == 1) {
            Get.toNamed(Routes.FORM_PENGAJUAN);
          } else if (index == 2) {
            print('Sudah berada di halaman Profile');
          }
        },
      ),
    );
  }
}
