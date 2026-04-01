import 'package:flutter/material.dart';

class TicketInfo extends StatelessWidget {
  final Map<String, String> data;

  const TicketInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.entries.map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(child: Text(e.key)),
              Expanded(child: Center(child: Text(e.value))),
            ],
          ),
        );
      }).toList(),
    );
  }
}
