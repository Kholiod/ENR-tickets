import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

Future<Uint8List> generateTicketPDF({
  required String from,
  required String to,
  required String train,
  required String trainType,
  required String coach,
  required String seat,
  required String name,
  required String price,
  required String bookingType,
  required String ticketId,
}) async {
  final pdf = pw.Document();

  final font = pw.Font.ttf(
    await rootBundle.load("assets/fonts/HelveticaWorld-Regular.ttf"),
  );
  final bold = pw.Font.ttf(
    await rootBundle.load("assets/fonts/HelveticaWorld-Bold.ttf"),
  );

  final s = pw.TextStyle(font: font);
  final b = pw.TextStyle(font: bold);

  final data = [
    ("Train", "القطار", train),
    ("Type", "نوع القطار", trainType),
    ("Coach", "العربة", coach),
    ("Seat", "المقعد", seat),
    ("Booking", "نوع الحجز", bookingType),
    ("Price", "السعر", "$price EGP"),
    ("Passenger", "الراكب", name),
  ];

  pdf.addPage(
    pw.Page(
      build: (_) => pw.Center(
        child: pw.Container(
          width: 270,
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(20),
            border: pw.Border.all(color: PdfColors.red),
          ),
          child: pw.Column(
            children: [
              _header(from, to, s, b),
              pw.SizedBox(height: 12),
              pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data: ticketId,
                width: 120,
                height: 120,
              ),
              pw.Text("ID: $ticketId", style: s.copyWith(fontSize: 11)),
              pw.SizedBox(height: 10),
              _dashLine(),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 12),
                child: pw.Column(
                  children: data.map((e) => _row(e, s, b)).toList(),
                ),
              ),
              pw.SizedBox(height: 12),
            ],
          ),
        ),
      ),
    ),
  );

  return pdf.save();
}

pw.Widget _header(String from, String to, pw.TextStyle s, pw.TextStyle b) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(14),
    decoration: pw.BoxDecoration(
      color: PdfColor.fromHex("#E53935"),
      borderRadius: const pw.BorderRadius.vertical(top: pw.Radius.circular(20)),
    ),
    child: pw.Column(
      children: [
        pw.Text(
          "ENR Ticket | تذكرة القطار",
          style: b.copyWith(color: PdfColors.white, fontSize: 16),
        ),
        pw.SizedBox(height: 6),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(from, style: s.copyWith(color: PdfColors.white)),
            pw.Text("→", style: s.copyWith(color: PdfColors.white)),
            pw.Text(to, style: s.copyWith(color: PdfColors.white)),
          ],
        ),
      ],
    ),
  );
}

pw.Widget _dashLine() {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: List.generate(
      25,
      (_) => pw.Container(width: 4, height: 1, color: PdfColors.grey),
    ),
  );
}

pw.Widget _row((String, String, String) e, pw.TextStyle s, pw.TextStyle b) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 6),
    child: pw.Row(
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(e.$1, style: s.copyWith(fontSize: 11)),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Center(
            child: pw.Text(e.$3, style: b.copyWith(fontSize: 13)),
          ),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Text(
              e.$2,
              textAlign: pw.TextAlign.right,
              style: b.copyWith(fontSize: 11, color: PdfColors.red),
            ),
          ),
        ),
      ],
    ),
  );
}
