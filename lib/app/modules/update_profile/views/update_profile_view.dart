import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.nameC.text = user["name"] ?? "";
    controller.emailC.text = user["email"] ?? "";

    final String defaultImage =
        "https://ui-avatars.com/api/?name=${Uri.encodeComponent(user['name'] ?? 'User')}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('UPDATE PROFILE'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Email (read-only)
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.emailC,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Photo Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    final String? photoUrl = (user["profile"] != null &&
                            (user["profile"] as String).isNotEmpty)
                        ? user["profile"] as String
                        : null;
                    return Column(
                      children: [
                        ClipOval(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              photoUrl ?? defaultImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.deleteProfile(user["uid"]);
                          },
                          child: const Text("hapus"),
                        ),
                      ],
                    );
                  }
                },
              ),
              TextButton(
                onPressed: controller.pickImage,
                child: const Text(
                  "pilih foto",
                  style: TextStyle(color: Color(0xFF0082C6)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
              ),
              onPressed:
                  controller.isLoading.isTrue ? null : controller.updateProfile,
              child: Text(
                controller.isLoading.isFalse ? "UPDATE PROFILE" : "LOADING...",
                style: const TextStyle(color: Color(0xFF0082C6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
