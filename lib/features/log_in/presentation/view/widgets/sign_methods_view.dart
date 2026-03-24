import 'dart:developer';

import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/features/log_in/presentation/view/widgets/sign_in_methods.dart';
import 'package:flutter/material.dart';

class SignMethodsView extends StatelessWidget {
  const SignMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SignMethods(
          () {
            log("Rigister google");
          },
          image: AssetsData.google,
          methodName: google,
        ),
        SignMethods(
          () {
            log("Rigister facebook");
          },
          image: AssetsData.facebook,
          methodName: facebook,
        ),
      ],
    );
  }
}
