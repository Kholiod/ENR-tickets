import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 30,

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.shade800,
                Colors.red.shade400,
                Colors.red.shade400,
                const Color.fromARGB(255, 255, 0, 0),
              ],
              stops: const [0.0, 0.35, 0.65, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "1 Timetable",
                style: Styles.textStyle19.copyWith(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(5),
              Text(
                "2 Select seat",
                style: Styles.textStyle19.copyWith(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(5),
              Text(
                "3 Personal",
                style: Styles.textStyle19.copyWith(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 35,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legend("Available", cardColor),
              _legend("Selected", buttonColor),
              _legend("Booked", Colors.black),
            ],
          ),
        ),
      ],
    );
  }

  Widget _legend(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(width: 0.5),
          ),
        ),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
