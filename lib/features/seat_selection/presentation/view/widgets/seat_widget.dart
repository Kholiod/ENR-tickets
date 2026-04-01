import 'package:enr_tickets/core/utils/colors.dart';
import 'package:flutter/material.dart';

enum SeatState { available, selected, booked }

class SeatWidget extends StatelessWidget {
  final int number;
  final SeatState state;
  final VoidCallback onTap;

  const SeatWidget({
    super.key,
    required this.number,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    Color textColor;

    switch (state) {
      case SeatState.available:
        iconColor = Colors.grey.shade400;
        textColor = Colors.black;
        break;
      case SeatState.selected:
        iconColor = buttonColor;
        textColor = Colors.white;
        break;
      case SeatState.booked:
        iconColor = Colors.black;
        textColor = Colors.white;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 50,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.event_seat, size: 40, color: iconColor),

            Text(
              number.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
