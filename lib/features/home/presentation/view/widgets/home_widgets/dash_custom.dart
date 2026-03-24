import 'package:enr_tickets/core/utils/colors.dart';
import 'package:flutter/material.dart';

class DashesCustom extends StatelessWidget {
  const DashesCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: MediaQuery.sizeOf(context).width * 0.4,
      color: buttonColor,
    );
  }
}
