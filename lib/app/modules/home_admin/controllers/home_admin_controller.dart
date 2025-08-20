import 'package:get/get.dart';

class HomeAdminController extends GetxController {
  var tickets = <Map<String, dynamic>>[
    {
      "kategori": "Jaringan",
      "uraian": "Jaringan internet lambat.",
      "status": "Pending",
      "response": null,
    },
    {
      "kategori": "Aplikasi",
      "uraian": "Aplikasi sering crash.",
      "status": "Diproses",
      "response": null,
    },
  ].obs;

  void respondToTicket(int index, String response) {
    tickets[index]['response'] = response;
    update();
  }

  void updateTicketStatus(int index, String status) {
    tickets[index]['status'] = status;
    update();
  }
}
