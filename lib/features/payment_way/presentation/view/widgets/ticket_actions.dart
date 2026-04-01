import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:enr_tickets/core/utils/pdf_generator.dart';

class TicketActions {
  static Future<void> download({
    required String from,
    required String to,
    required String train,
    required String coach,
    required String seat,
    required String name,
    required String price,
    required String ticketId,
    required String trainType,
    required String bookingType,
  }) async {
    final pdfData = await generateTicketPDF(
      from: from,
      to: to,
      train: train,
      coach: coach,
      seat: seat,
      name: name,
      price: price,
      ticketId: ticketId,
      trainType: trainType,
      bookingType: bookingType,
    );

    await Printing.layoutPdf(onLayout: (format) async => pdfData);
  }

  static void share({
    required String from,
    required String to,
    required String train,
    required String coach,
    required String seat,
    required String name,
    required String price,
    required String ticketId,
  }) {
    Share.share(
      "🚆 ENR Ticket\n\n"
      "ID: $ticketId\n"
      "Train: $train\n"
      "Coach: $coach\n"
      "From: $from → $to\n"
      "Seat: $seat\n"
      "Price: $price EGP\n"
      "Passenger: $name",
    );
  }
}
