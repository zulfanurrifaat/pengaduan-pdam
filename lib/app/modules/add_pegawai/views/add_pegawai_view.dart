import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('TAMBAH PEGAWAI'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
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
            obscureText: true,
            controller: controller.passwordC,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isloading.isTrue
                  ? null
                  : () async {
                      await controller.addPegawai();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                controller.isloading.isFalse ? "TAMBAH PEGAWAI" : "LOADING...",
                style: const TextStyle(
                  color: Color(0xFF0082C6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
