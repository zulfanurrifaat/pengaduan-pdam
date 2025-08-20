import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
            Image.asset('assets/images/pengaduann.png',
                width: 300, height: 250),
            Text(
              "TICKETING PENGADUAN",
              style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.LOGIN);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Color(0xFF0082C6),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.REGISTRASI);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0082C6),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  "DAFTAR ADMIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
