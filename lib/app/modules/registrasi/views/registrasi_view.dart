import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/registrasi_controller.dart';

class RegistrasiView extends GetView<RegistrasiController> {
  const RegistrasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("REGISTRASI ADMIN"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller.emailC,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: controller.nameC,
              decoration: InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 15),
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
            const SizedBox(height: 25),
            Obx(() {
              return SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    foregroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: controller.isLoading.isTrue
                      ? null
                      : () {
                          controller.register();
                        },
                  child: controller.isLoading.isTrue
                      ? const CircularProgressIndicator(color: Colors.blue)
                      : const Text("DAFTAR ADMIN"),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
