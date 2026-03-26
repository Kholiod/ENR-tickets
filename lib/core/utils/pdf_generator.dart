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

  /// 🔥 Helvetica World
  final font = pw.Font.ttf(
    await rootBundle.load("assets/fonts/HelveticaWorld-Regular.ttf"),
  );

  final boldFont = pw.Font.ttf(
    await rootBundle.load("assets/fonts/HelveticaWorld-Bold.ttf"),
  );

  final style = pw.TextStyle(font: font);
  final boldStyle = pw.TextStyle(font: boldFont);

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Center(
          child: pw.Container(
            width: 270,
            decoration: pw.BoxDecoration(
              color: PdfColors.white,
              borderRadius: pw.BorderRadius.circular(20),
              border: pw.Border.all(color: PdfColors.red),
            ),
            child: pw.Column(
              children: [
                /// 🔴 HEADER
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(14),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#E53935"),
                    borderRadius: const pw.BorderRadius.vertical(
                      top: pw.Radius.circular(20),
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        "ENR Ticket | تذكرة القطار",
                        style: boldStyle.copyWith(
                          color: PdfColors.white,
                          fontSize: 16,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            from,
                            style: style.copyWith(color: PdfColors.white),
                          ),
                          pw.Text(
                            "→",
                            style: style.copyWith(color: PdfColors.white),
                          ),
                          pw.Text(
                            to,
                            style: style.copyWith(color: PdfColors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 12),

                /// QR
                pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),
                  data: ticketId,
                  width: 120,
                  height: 120,
                ),

                pw.SizedBox(height: 6),

                pw.Text(
                  "ID: $ticketId",
                  style: style.copyWith(color: PdfColors.grey700, fontSize: 11),
                ),

                pw.SizedBox(height: 10),

                /// dashed
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      25,
                      (index) => pw.Container(
                        width: 4,
                        height: 1,
                        color: PdfColors.grey,
                      ),
                    ),
                  ),
                ),

                pw.SizedBox(height: 10),

                /// INFO
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 12),
                  child: pw.Column(
                    children: [
                      _row("Train", "القطار", train, style, boldStyle),
                      _row("Type", "نوع القطار", trainType, style, boldStyle),
                      _row("Coach", "العربة", coach, style, boldStyle),
                      _row("Seat", "المقعد", seat, style, boldStyle),
                      _row(
                        "Booking",
                        "نوع الحجز",
                        bookingType,
                        style,
                        boldStyle,
                      ),
                      _row("Price", "السعر", "$price EGP", style, boldStyle),
                      pw.SizedBox(height: 8),
                      _row("Passenger", "الراكب", name, style, boldStyle),
                    ],
                  ),
                ),

                pw.SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    ),
  );

  return pdf.save(); // 🔥 المهم
}

pw.Widget _row(
  String en,
  String ar,
  String value,
  pw.TextStyle style,
  pw.TextStyle boldStyle,
) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 7),
    child: pw.Row(
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(
            en,
            style: style.copyWith(fontSize: 11, color: PdfColors.grey700),
          ),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Center(
            child: pw.Text(value, style: boldStyle.copyWith(fontSize: 13)),
          ),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Text(
              ar,
              textAlign: pw.TextAlign.right,
              style: boldStyle.copyWith(fontSize: 11, color: PdfColors.red),
            ),
          ),
        ),
      ],
    ),
  );
}
