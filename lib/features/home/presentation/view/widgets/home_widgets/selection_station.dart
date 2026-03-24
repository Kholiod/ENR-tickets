import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class SelectionStation extends StatelessWidget {
  final String title;

  const SelectionStation({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: ListTile(
          title: Text(
            title,
            style: Styles.textStyle19.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: Icon(Icons.train_outlined, size: 40, color: iconColor),
        ),
      ),
    );
  }
}
