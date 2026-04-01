import 'package:flutter/material.dart';
import '../widgets/ticket_header.dart';
import '../widgets/ticket_qr.dart';
import '../widgets/ticket_info.dart';
import '../widgets/ticket_buttons.dart';
import '../widgets/dashed_line.dart';

class TicketScreen extends StatelessWidget {
  final String from;
  final String to;
  final String train;
  final String trainType;
  final String seat;
  final String coach;
  final String time;
  final String name;
  final String price;
  final String bookingType;
  final String ticketId;

  const TicketScreen({
    super.key,
    required this.from,
    required this.to,
    required this.train,
    required this.trainType,
    required this.seat,
    required this.coach,
    required this.time,
    required this.name,
    required this.price,
    required this.bookingType,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context) {
    final qrData = "ID:$ticketId Train:$train Seat:$seat";

    final data = {
      "from": from,
      "to": to,
      "train": train,
      "trainType": trainType,
      "coach": coach,
      "seat": seat,
      "name": name,
      "price": price,
      "bookingType": bookingType,
      "ticketId": ticketId,
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Your Ticket")),
      body: Center(
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TicketHeader(from: from, to: to, time: time),
              const DashedLine(),
              TicketQR(qrData: qrData, ticketId: ticketId),
              const DashedLine(),
              TicketInfo(data: data),
              TicketButtons(data: data),
            ],
          ),
        ),
      ),
    );
  }
}
