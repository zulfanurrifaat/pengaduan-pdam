import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/pdam.png',
                        width: 48,
                        height: 48,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PERUMDAM",
                            style: TextStyle(
                                fontSize: 10, color: Colors.blue.shade400),
                          ),
                          Text(
                            "TIRTA WIJAYA",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue.shade400,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade100,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Halo, Zulfa Nurrifaat",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Aktivitasmu bulan ini",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Total"),
                            SizedBox(height: 5),
                            Text(
                              "50",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade400),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Pending"),
                            SizedBox(height: 5),
                            Text(
                              "10",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade400),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Diproses"),
                            SizedBox(height: 5),
                            Text(
                              "30",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade400),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Selesai"),
                            SizedBox(height: 5),
                            Text(
                              "10",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.FORM_PENGAJUAN);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 15,
                    shadowColor: Colors.blue.shade400,
                    backgroundColor: Colors.blue.shade400,
                    side: BorderSide(color: Colors.blue, width: 1),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Buat pengaduan baru'),
                      SizedBox(width: 15),
                      Icon(
                        Icons.mail,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Riwayat pengaduan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.SEMUA_RIWAYAT);
                    },
                    child: Text("Lihat semua..."),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    for (var i = 0; i < 7; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tanggal : 20-11-2024",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Waktu : 09.11",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Bidang : Litbang TI",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixed,
        backgroundColor: Colors.blue.shade400,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.add, title: 'Ajukan'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 0,
        onTap: (int index) {
          if (index == 1) {
            Get.toNamed(Routes.FORM_PENGAJUAN);
          } else if (index == 0) {
            Get.offAllNamed(Routes.HOME);
          } else if (index == 2) {
            Get.toNamed(Routes.PROFILE);
          }
        },
      ),
    );
  }
}
