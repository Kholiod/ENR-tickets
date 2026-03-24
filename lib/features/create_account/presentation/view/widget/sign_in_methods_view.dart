import 'dart:developer';

import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/sign_in_methods_new_user.dart';
import 'package:flutter/material.dart';

class SignInMethodsView extends StatelessWidget {
  const SignInMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SignMethodCreateAccount(
          () {
            log("Rigister google");
          },
          image: AssetsData.google,
          methodName: google,
        ),
        SignMethodCreateAccount(
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
