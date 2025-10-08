import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('UPDATE PASSWORD'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.currentPassC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password saat ini",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: controller.newPassC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password baru",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: controller.confirmPassC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Konfirmasi password baru",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(() => SizedBox(
                width: 280,
                child: ElevatedButton(
                  onPressed: controller.isLoading.isTrue
                      ? null
                      : controller.changePassword,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100),
                  child: Text(
                    controller.isLoading.isFalse
                        ? "UBAH PASSWORD"
                        : "LOADING...",
                    style: const TextStyle(color: Color(0xFF0082C6)),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
