import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;

Future<void> generateTicketPDF({
  required String from,
  required String to,
  required String train,
  required String coach,
  required String seat,
  required String name,
  required String price,
  required String ticketId,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          children: [
            pw.Text("ENR Ticket"),
            pw.Text("From: $from → $to"),
            pw.Text("Train: $train"),
            pw.Text("Seat: $seat"),
            pw.Text("Passenger: $name"),
            pw.Text("Price: $price EGP"),
            pw.Text("ID: $ticketId"),
          ],
        );
      },
    ),
  );

  final bytes = await pdf.save();

  /// 🔥 ده المهم
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "ticket.pdf")
    ..click();

  html.Url.revokeObjectUrl(url);
}
