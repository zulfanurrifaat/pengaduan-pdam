import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/form_pengajuan_controller.dart';

class FormPengajuanView extends GetView<FormPengajuanController> {
  const FormPengajuanView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController tanggalController = TextEditingController();
    final TextEditingController jamController = TextEditingController();

    String? selectedBidang;
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
            value: selectedBidang,
            onChanged: (String? newValue) {
              selectedBidang = newValue;
            },
            items: <String>[
              'Bidang Litbang TI',
              'Bidang Litbang Teknik',
              'Bidang Litbang ADM & UMUM',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: "Pilih Bidang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 15),
          DropdownButtonFormField<String>(
            value: selectedBidang,
            onChanged: (String? newValue) {
              selectedBidang = newValue;
            },
            items: <String>[
              'Bagian Umum',
              'Bagian Keuangan',
              'Bagian Humas',
              'Bagian Peralatan',
              'Bagian Perencanaan Teknik',
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
            value: selectedKategori,
            onChanged: (String? newValue) {
              selectedKategori = newValue;
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
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: tanggalController,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                tanggalController.text =
                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              }
            },
            decoration: InputDecoration(
              labelText: "Tanggal",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: jamController,
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                jamController.text = pickedTime.format(context);
              }
            },
            decoration: InputDecoration(
              labelText: "Jam",
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
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text("AJUKAN PENGADUAN"),
            ),
          ),
        ],
      ),
    );
  }
}
