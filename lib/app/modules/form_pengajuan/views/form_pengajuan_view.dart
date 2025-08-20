import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pengaduan/app/routes/app_pages.dart';
import '../controllers/form_pengajuan_controller.dart';

class FormPengajuanView extends GetView<FormPengajuanController> {
  const FormPengajuanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'FORMULIR PENGADUAN',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Obx(() => DropdownButtonFormField<String>(
                isExpanded: true,
                dropdownColor: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                value: controller.bagian.value,
                onChanged: (String? newValue) {
                  controller.bagian.value = newValue;
                },
                items: <String>[
                  'Perencanaan Teknik',
                  'Pengawasan Teknik',
                  'Evaluasi & Pelaporan Teknik',
                  'Sumber Air',
                  'Instalasi Wilayah',
                  'Laboratorium',
                  'Evaluasi & Pelaporan Produksi',
                  'Transmisi & Distribusi ',
                  'Penanggulangan Kebocoran Air',
                  'Permesinan',
                  'Perlistrikan',
                  'Pemeliharaan Peralatan Teknik',
                  'Anggaran',
                  'Akuntansi',
                  'Piutang & Penagihan',
                  'Kas',
                  'Humas & Hukum',
                  'Pelayanan & Pemasaran',
                  'Baca Meter Air & Langganan',
                  'Pergudangan',
                  'Sumber Daya Manusia',
                  'Administrasi Umum',
                  'Aset',
                  'Koordinator Pengadaan Barang & Jasa Lainya',
                  'Koordinator Pengadaan Konstruksi & Jasa Konsultasi',
                  'Koordinator Pengawas Pelaksana Bidang Umum',
                  'Koordinator Pengawas Pelaksana Bidang Teknik',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Pilih Bagian",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )),
          const SizedBox(height: 15),
          Obx(() => DropdownButtonFormField<String>(
                isExpanded: true,
                dropdownColor: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                value: controller.kategoriPengaduan.value,
                onChanged: (String? newValue) {
                  controller.kategoriPengaduan.value = newValue;
                },
                items: <String>[
                  'Sistem Informasi',
                  'Infrastruktur',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Kategori Pengaduan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )),
          const SizedBox(height: 15),
          TextField(
            controller: controller.noHandphone,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "No Handphone",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: controller.uraianPengaduan,
            autocorrect: false,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: "Uraian Pengaduan",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 280,
            child: ElevatedButton(
              onPressed: () {
                controller.submitPengaduan();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
              ),
              child: const Text(
                "KIRIM TICKET PENGADUAN",
                style: TextStyle(
                  color: Color(0xFF0082C6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
