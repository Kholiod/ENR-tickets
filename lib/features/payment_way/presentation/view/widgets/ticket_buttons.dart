import 'package:enr_tickets/features/payment_way/presentation/view/widgets/ticket_actions.dart';
import 'package:flutter/material.dart';

class TicketButtons extends StatelessWidget {
  final Map<String, String> data;

  const TicketButtons({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              TicketActions.download(
                from: data['from'] ?? '',
                to: data['to'] ?? '',
                train: data['train'] ?? '',
                coach: data['coach'] ?? '',
                seat: data['seat'] ?? '',
                name: data['name'] ?? '',
                price: data['price'] ?? '',
                ticketId: data['ticketId'] ?? '',
                trainType: data['trainType'] ?? '',
                bookingType: data['bookingType'] ?? '',
              );
            },
            child: const Text("Download"),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              TicketActions.share(
                from: data['from'] ?? '',
                to: data['to'] ?? '',
                train: data['train'] ?? '',
                coach: data['coach'] ?? '',
                seat: data['seat'] ?? '',
                name: data['name'] ?? '',
                price: data['price'] ?? '',
                ticketId: data['ticketId'] ?? '',
              );
            },
            child: const Text("Share"),
          ),
        ),
      ],
    );
  }
}
