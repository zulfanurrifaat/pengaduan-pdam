import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pengaduan/app/modules/form_pengajuan/controllers/form_pengajuan_controller.dart';

class FormPengajuanView extends GetView<FormPengajuanController> {
  const FormPengajuanView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController tanggalController = TextEditingController();
    final TextEditingController jamController = TextEditingController();
    final TextEditingController nomorHandphoneController =
        TextEditingController();

    String? selectedKategori;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('FORMULIR PENGADUAN'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownButtonFormField<String>(
            isExpanded: true,
            dropdownColor: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
            value: selectedKategori,
            onChanged: (String? newValue) {
              selectedKategori = newValue;
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
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 15),
          DropdownButtonFormField<String>(
            isExpanded: true,
            dropdownColor: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
            value: selectedKategori,
            onChanged: (String? newValue) {
              selectedKategori = newValue;
            },
            items: <String>[
              'Sistem Informasi',
              'Infrastruktur',
            ].map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            decoration: InputDecoration(
              labelText: "Kategori Pengaduan",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: nomorHandphoneController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "No Handphone",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            autocorrect: false,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: "Uraian Pengaduan",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: 280,
            child: ElevatedButton(
              onPressed: () {
                print('Pengaduan Ajukan');
                print('Tanggal: ${tanggalController.text}');
                print('Jam: ${jamController.text}');
                print('Nomor Handphone: ${nomorHandphoneController.text}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
              ),
              child: Text(
                "AJUKAN PENGADUAN",
                style: TextStyle(color: Colors.blue.shade400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
