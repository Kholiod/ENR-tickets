import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketQR extends StatelessWidget {
  final String qrData;
  final String ticketId;

  const TicketQR({super.key, required this.qrData, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QrImageView(data: qrData, size: 160),
        const SizedBox(height: 8),
        Text("ID: $ticketId"),
      ],
    );
  }
}
