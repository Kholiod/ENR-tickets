import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class CustomHaveAccountTextButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomHaveAccountTextButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: Styles.textStyle19.copyWith(color: hintColorForm),
      ),
    );
  }
}
