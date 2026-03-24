import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TravelDateCard extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback onTap;

  const TravelDateCard({
    super.key,
    required this.title,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Gap(10),
              Text(travelDate),

              Gap(10),
              const Icon(
                Icons.calendar_month_outlined,
                color: iconColor,
                size: 30,
              ),

              Spacer(),
              Container(width: 2, height: 50, color: Colors.grey[200]),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Styles.textStyle19.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 3),
                  Text(date, style: Styles.textStyle19),
                ],
              ),

              Gap(30),

              const Icon(Icons.arrow_forward_ios, size: 25, color: Colors.grey),

              Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
