import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class TrainNumberRow extends StatelessWidget {
  final int trainNumber;
  const TrainNumberRow({super.key, required this.trainNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Train Number Badge
        TrainNumberBadge(trainNumber: trainNumber),

        Text(
          "$train_number: $trainNumber",
          style: Styles.textStyle19.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}

class TrainNumberBadge extends StatelessWidget {
  final int trainNumber;

  const TrainNumberBadge({super.key, required this.trainNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xffE9DFC7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Text(
        "$trainNumber",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class TrainNumberClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.4,
      size.width * 0.45,
      size.height * 0.2,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
