import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'package:pengaduan/app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const Text(
            "LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),

          // EMAIL
          TextField(
            controller: controller.emailC,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),

          // PASSWORD
          TextField(
            controller: controller.passC,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // LOGIN
          Obx(() => ElevatedButton(
                onPressed: controller.isLoading.isTrue
                    ? null
                    : () => controller.login(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  controller.isLoading.isFalse ? "MASUK" : "LOADING...",
                  style: const TextStyle(
                    color: Color(0xFF0082C6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          const SizedBox(height: 15),

          // RESET PASSWORD
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.FORGOT_PASSWORD);
            },
            child: const Text(
              "Lupa Password?",
              style: TextStyle(color: Colors.red),
            ),
          ),

          // KIRIM ULANG VERIFIKASI
          TextButton(
            onPressed: () async {
              await controller.resendVerificationEmail();
            },
            child: const Text(
              "Kirim Ulang Verifikasi",
              style: TextStyle(color: Color(0xFF0082C6)),
            ),
          ),
        ],
      ),
    );
  }
}
