// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/settings_widgets/text_button_widget.dart';
import 'package:flutter/material.dart';

class SettingsCardWidget extends StatelessWidget {
  final String title;
  final String task;
  const SettingsCardWidget({
    super.key,
    required this.title,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.sizeOf(context).width * 0.88,
            height: MediaQuery.sizeOf(context).height * 0.056,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(title, style: Styles.textStyle17),
                Spacer(),
                TextButtonWidget(
                  icon: Icons.arrow_forward_ios_rounded,
                  task: task,
                  onPressed: () {
                    log("Text button");
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
