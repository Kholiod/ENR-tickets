import 'package:flutter/material.dart';

class TicketHeader extends StatelessWidget {
  final String from;
  final String to;
  final String time;

  const TicketHeader({
    super.key,
    required this.from,
    required this.to,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          const Text(
            "ENR Ticket | تذكرة القطار",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _text(from),
              const Icon(Icons.arrow_forward, color: Colors.white),
              _text(to),
            ],
          ),
          const SizedBox(height: 5),
          Text(time, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _text(String t) {
    return Text(t, style: const TextStyle(color: Colors.white));
  }
}
