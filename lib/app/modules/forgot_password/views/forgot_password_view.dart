import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('RESET PASSWORD'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
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
          Obx(
            () => ElevatedButton(
              onPressed:
                  controller.isLoading.isTrue ? null : controller.sendEmail,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100),
              child: Text(
                controller.isLoading.isFalse
                    ? "KIRIM RESET PASSWORD"
                    : "LOADING...",
                style: const TextStyle(color: Color(0xFF0082C6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
