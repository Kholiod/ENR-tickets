import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class CustomWidgetCard extends StatelessWidget {
  final String title;
  const CustomWidgetCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.sizeOf(context).width * 0.88,
      height: MediaQuery.sizeOf(context).height * 0.13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 0.4),
        color: Colors.grey[100],
      ),
      child: Column(children: [Text(title, style: Styles.textStyle17)]),
    );
  }
}
