import 'package:enr_tickets/features/home/presentation/view/widgets/settings_widgets/settings_page_body.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white, body: SettingsPageBody()),
    );
  }
}
