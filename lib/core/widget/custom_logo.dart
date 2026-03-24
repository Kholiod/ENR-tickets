import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "E",
              style: Styles.textStyle70.copyWith(
                color: const Color.fromARGB(255, 194, 28, 28),
              ),
            ),
            Text(
              "N",
              style: Styles.textStyle70.copyWith(color: Colors.grey[200]),
            ),
            Text("R", style: Styles.textStyle70),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 40, height: 2, color: iconColor),
            Gap(10),
            Text(
              eNR,
              style: Styles.textStyle19.copyWith(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            Gap(10),
            Container(width: 40, height: 2, color: iconColor),
          ],
        ),
      ],
    );
  }
}
