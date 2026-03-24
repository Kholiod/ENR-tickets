// ignore_for_file: deprecated_member_use

import 'package:enr_tickets/core/widget/assets.dart';
import 'package:flutter/material.dart';

class CustomHomeLogo extends StatelessWidget {
  const CustomHomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.2),
      child: Center(
        child: Image.asset(
          AssetsData.iconlogo,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
