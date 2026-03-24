// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/settings_widgets/settings_card_widget.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/settings_widgets/switch_card_settings.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/settings_widgets/text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsPageBody extends StatelessWidget {
  const SettingsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,

            child: Image.asset(AssetsData.iconlogo),
          ),
        ),
        Text(settings, style: Styles.textStyle27),
        SettingsCardWidget(task: followsystem, title: darkmode),
        SettingsCardWidget(task: languge, title: "English"),
        Gap(30),
        SwitchCardSettings(
          title: use_biometaic,
          onChanged: (p0) => print("object"),
        ),
        SwitchCardSettings(
          title: use_biometaic,
          onChanged: (p0) => print("object"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButtonWidget(
            onPressed: () => log("Change password"),
            task:changepassword,
            icon: Icons.lock_outline_rounded,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButtonWidget(
            
            onPressed: () => log("Delete Account"),
            task: deleteaccount,

            icon: Icons.delete_outline_rounded,
          ),
        ),
      ],
    );
  }
}
