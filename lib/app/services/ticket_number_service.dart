import 'package:cloud_firestore/cloud_firestore.dart';

class TicketNumberService {
  static final FirebaseFirestore _fs = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>> reserveNext() async {
    final counterRef = _fs.collection('counters').doc('tickets');

    return _fs.runTransaction((tx) async {
      final snap = await tx.get(counterRef);

      int last = 0;
      int? storedYear;

      if (snap.exists) {
        final data = snap.data();
        last = (data?['last'] as int?) ?? 0;
        storedYear = (data?['year'] as int?);
      }

      final nowYear = DateTime.now().year;

      if (storedYear != null && storedYear != nowYear) {
        last = 0;
      }

      final next = last + 1;

      tx.set(
          counterRef,
          {
            'last': next,
            'year': nowYear,
            'updatedAt': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true));

      final padded = next.toString().padLeft(5, '0');
      final ticketNumber = 'TKT-$nowYear-$padded';

      return {
        'number': ticketNumber,
        'index': next,
      };
    });
  }
}
