import 'package:flutter/material.dart';

class BookingBotton extends StatelessWidget {
  final void Function()? onPressed;

  const BookingBotton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 48,
        width: MediaQuery.sizeOf(context).width * 0.65,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),

          /// 🎨 Gradient احترافي
          gradient: const LinearGradient(
            colors: [Color(0xffd32f2f), Color(0xfff44336)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          /// 🔥 Shadow يخلي الزرار يبان 3D
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: onPressed,

            splashColor: Colors.white24,

            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// ✔ icon
                  Icon(Icons.check_circle, color: Colors.white, size: 18),

                  SizedBox(width: 8),

                  /// النص
                  Text(
                    "Booking confirmation",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
