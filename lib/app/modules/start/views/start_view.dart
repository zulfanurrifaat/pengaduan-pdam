import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pengaduan/app/routes/app_pages.dart';

import '../controllers/start_controller.dart';

class StartView extends GetView<StartController> {
  const StartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/pengaduan.png', width: 300, height: 250),
            SizedBox(height: 15),
            Text(
              "APLIKASI PENGADUAN",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text("Selamat datang di aplikasi pengaduan"),
            Text("Masuk atau daftar jika belum memiliki akun!"),
            SizedBox(height: 15),
            SizedBox(
              width: 280,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.LOGIN);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100),
                child: Text(
                  "Masuk",
                  style: TextStyle(
                    color: Colors.blue.shade400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 280,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.REGISTRASI);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400),
                child: Text(
                  "Daftar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
