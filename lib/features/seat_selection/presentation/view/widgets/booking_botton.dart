import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class BookingBotton extends StatelessWidget {
  final void Function()? onPressed;

  const BookingBotton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.08,
      width: MediaQuery.sizeOf(context).width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        /// 🔥 Gradient ناعم ومحترف
        gradient: LinearGradient(
          colors: [redTow, redTow, redTow, white],
          stops: const [0.0, 0.35, 0.65, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        border: Border.all(color: Colors.black54, width: 0.2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Center(
            child: Text(
              "Booking confirmation",
              style: Styles.textStyle19.copyWith(
                color: Colors.white, // أهم تغيير
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
