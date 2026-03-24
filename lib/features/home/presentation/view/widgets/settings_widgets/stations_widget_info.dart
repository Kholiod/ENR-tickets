import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StationsRow extends StatelessWidget {
  final String departTime;
  final DateTime departDate;
  final String fromStation;
  final String arriveTime;
  final String arriveDate;
  final String toStation;
  const StationsRow({
    super.key,
    required this.departTime,
    required this.departDate,
    required this.fromStation,
    required this.arriveTime,
    required this.arriveDate,
    required this.toStation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              /// Departure station
              Text(
                departurestation,
                style: Styles.hintStyle.copyWith(color: iconColor),
              ),
              Divider(),
              Text(
                departTime,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(DateFormat('yyyy-MM-dd').format(departDate)),
              // Text(departDate.toString()),
              const SizedBox(height: 6),
              Text(fromStation, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),

        Container(height: 50, width: 1, color: Colors.grey.shade300),
        // Arrival station
        Expanded(
          child: Column(
            children: [
              Text(
                arrivalstation,
                style: Styles.hintStyle.copyWith(color: iconColor),
              ),
              Divider(),
              Text(
                arriveTime,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(arriveDate),
              // Text(DateFormat('yyyy-MM-dd').format(arriveDate)),
              const SizedBox(height: 6),
              Text(toStation, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
