import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:pengaduan/app/modules/home_admin/views/home_admin_view.dart';
import 'package:pengaduan/app/modules/profile/views/profile_view.dart';
import 'package:pengaduan/app/modules/profile/controllers/profile_controller.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // ✅ Pastikan ProfileController terdaftar sekali saja
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = const [
      HomeAdminView(),
      ProfileView(isFromAdminMainPage: true),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: const Color(0xFF0082C6),
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
