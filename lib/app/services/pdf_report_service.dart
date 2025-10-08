import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PdfReportService {
  static Future<File> buildTicketsPdf({
    required List<Map<String, dynamic>> tickets,
    String generatedBy = 'System',
  }) async {
    final pdf = pw.Document();

    final now = DateTime.now();
    final tglCetak = DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(now);

    final headers = [
      'No',
      'Tanggal',
      'No. Tiket',
      'Nama',
      'Bagian',
      'Kategori',
      'Status',
      'No HP',
      'Uraian',
    ];

    final rows = <List<String>>[];
    for (var i = 0; i < tickets.length; i++) {
      final t = tickets[i];

      final nomor = (i + 1).toString();

      final ts = t['tanggal'] ?? t['createdAt'];
      String tglStr = '-';
      try {
        if (ts is DateTime) {
          tglStr = DateFormat('dd/MM/yyyy', 'id_ID').format(ts);
        } else if (ts is Timestamp) {
          tglStr = DateFormat('dd/MM/yyyy', 'id_ID').format(ts.toDate());
        }
      } catch (_) {}

      final ticketNo =
          (t['ticketId'] ?? t['ticketID'] ?? t['ticketNo'] ?? t['id'] ?? '-')
              .toString();
      final nama = (t['namaPengirim'] ?? t['nama pengirim'] ?? '-').toString();
      final bagian = (t['bagian'] ?? t['Bagian'] ?? '-').toString();
      final kategori =
          (t['kategoriPengaduan'] ?? t['kategori pengaduan'] ?? '-').toString();
      final status = (t['status'] ?? 'Pending').toString();
      final hp = (t['noHandphone'] ?? t['no handphone'] ?? '-').toString();
      final uraian =
          (t['uraianPengaduan'] ?? t['uraian pengaduan'] ?? '').toString();

      rows.add([
        nomor,
        tglStr,
        ticketNo,
        nama,
        bagian,
        kategori,
        status,
        hp,
        uraian,
      ]);
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(24),
        build: (context) => [
          pw.Text(
            'Laporan Tiket Pengaduan',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text('Dicetak: $tglCetak  Oleh: $generatedBy',
              style: const pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 12),
          pw.TableHelper.fromTextArray(
            headers: headers,
            data: rows,
            headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, color: PdfColors.white),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.blue),
            cellStyle: const pw.TextStyle(fontSize: 9),
            cellAlignment: pw.Alignment.centerLeft,
            columnWidths: {
              0: const pw.FixedColumnWidth(28), // No
              1: const pw.FixedColumnWidth(70), // Tanggal
              2: const pw.FixedColumnWidth(95), // No. Tiket
              3: const pw.FixedColumnWidth(100), // Nama
              4: const pw.FixedColumnWidth(120), // Bagian
              5: const pw.FixedColumnWidth(100), // Kategori
              6: const pw.FixedColumnWidth(70), // Status
              7: const pw.FixedColumnWidth(90), // No HP
              // Uraian auto-expand
            },
            cellPadding: const pw.EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 4,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('Total tiket: ${tickets.length}',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  )),
            ],
          ),
        ],
      ),
    );

    // Simpan ke folder dokumen
    final dir = await getApplicationDocumentsDirectory();
    final filename =
        'laporan_pengaduan_${DateFormat('yyyyMMdd_HHmmss').format(now)}.pdf';
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
