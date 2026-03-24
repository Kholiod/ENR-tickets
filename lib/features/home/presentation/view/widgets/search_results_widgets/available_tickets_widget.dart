import 'package:flutter/material.dart';

class AvailableTicketsWidget extends StatelessWidget {
  final int availableTickets;
  const AvailableTicketsWidget({super.key, required this.availableTickets});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerRight,
      child: Text(
        "Available Tickets: $availableTickets",
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
