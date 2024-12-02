import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan/app/routes/app_pages.dart';

import '../controllers/semua_riwayat_controller.dart';

class SemuaRiwayatView extends GetView<SemuaRiwayatController> {
  const SemuaRiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('SEMUA PENGADUAN'),
        centerTitle: true,
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: controller.riwayatData.length,
            itemBuilder: (context, index) {
              final riwayat = controller.riwayatData[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_PENGADUAN,
                          arguments: ({
                            'bagian': riwayat['bagian'],
                            'kategori pengaduan': riwayat['kategori pengaduan'],
                            'no handphone': riwayat['no handphone'],
                            'uraian pengaduan': riwayat['uraian pengaduan'],
                          }));
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bagian: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  "${riwayat['bagian']}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kategori Pengaduan: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  "${riwayat['kategori pengaduan']}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "No Handphone: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  "${riwayat['no handphone']}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Uraian Pengaduan: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  "${riwayat['uraian pengaduan']}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
