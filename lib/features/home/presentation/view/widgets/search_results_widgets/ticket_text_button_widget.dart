import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class TicketTextButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const TicketTextButtonWidget({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(text, style: Styles.textStyle19),
    );
  }
}
