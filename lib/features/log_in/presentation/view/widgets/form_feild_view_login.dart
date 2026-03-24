import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/utils/validators.dart';
import 'package:enr_tickets/core/widget/custom_form_feild.dart';
import 'package:flutter/material.dart';

class FormFeildViewLogin extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const FormFeildViewLogin({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //email 
        CustomFormFeild(
          hint: email,
          icon: Icons.email,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.emailValidator,
        ),
        //password
        CustomFormFeild(
          hint: password,
          icon: Icons.lock_outline,
          controller: passwordController,
          obscureText: true,
          validator: Validators.passwordValidator,
        ),
      ],
    );
  }
}
