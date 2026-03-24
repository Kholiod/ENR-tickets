import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignInVia extends StatelessWidget {
  const SignInVia({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DashesLine(),
        Gap(10),
        Center(
          child: Text(
            sign_in_with,
            style: Styles.hintStyle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.grey[350],
            ),
          ),
        ),
        Gap(10),
        DashesLine(),
      ],
    );
  }
}

class DashesLine extends StatelessWidget {
  const DashesLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 60, height: 2.3, color: hintColorForm);
  }
}
