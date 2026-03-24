import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/features/log_in/presentation/view/widgets/log_in_body.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AssetsData.backgroundimage, fit: BoxFit.cover),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.22,
          left: 10,
          right: 10,
          bottom: 10,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: LogInBody(),
          ),
        ),
      ],
    );
  }
}
