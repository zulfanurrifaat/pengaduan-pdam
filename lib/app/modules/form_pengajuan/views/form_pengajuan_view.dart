import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pengaduan/app/modules/form_pengajuan/controllers/form_pengajuan_controller.dart'; // Import untuk menggunakan TextInputFormatter

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
            value: selectedKategori,
            onChanged: (String? newValue) {
              selectedKategori = newValue;
            },
            items: <String>[
              'Bagian Perencanaan Teknik',
              'Bagian Pengawasan Teknik',
              'Bagian Evaluasi & Pelaporan Teknik',
              'Bagian Sumber Air',
              'Bagian Instalasi Wilayah',
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
