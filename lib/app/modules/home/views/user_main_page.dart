import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:pengaduan/app/modules/home/views/home_view.dart';
import 'package:pengaduan/app/modules/profile/views/profile_view.dart';
import 'package:pengaduan/app/routes/app_pages.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeView(fromTab: true),
      const SizedBox.shrink(),
      ProfileView(isFromAdminMainPage: false)
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex == 1 ? 0 : _currentIndex,
        children: [pages[0], pages[2]],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixed,
        backgroundColor: const Color(0xFF0082C6),
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.add, title: 'Ajukan'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (int index) {
          if (index == 1) {
            Get.toNamed(Routes.FORM_PENGAJUAN);
            return;
          }
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
