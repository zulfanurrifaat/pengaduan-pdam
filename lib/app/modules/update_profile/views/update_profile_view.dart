import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  const UpdateProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('UPDATE PROFILE'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            readOnly: true,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Photo Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ClipOval(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/foto.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "hapus",
                      style: TextStyle(color: Colors.blue.shade400),
                      
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "pilih foto",
                  style: TextStyle(color: Colors.blue.shade400),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade100),
            onPressed: () {},
            child: Text(
              "UPDATE PROFILE",
              style: TextStyle(color: Colors.blue.shade400),
            ),
          )
        ],
      ),
    );
  }
}
