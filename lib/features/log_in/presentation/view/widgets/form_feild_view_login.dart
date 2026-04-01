import 'package:flutter/material.dart';
import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/utils/validators.dart';
import 'package:enr_tickets/core/widget/custom_form_feild.dart';

class FormFieldViewLogin extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const FormFieldViewLogin({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final fields = [
      (email, Icons.email, emailController, false, Validators.emailValidator),
      (
        password,
        Icons.lock_outline,
        passwordController,
        true,
        Validators.passwordValidator,
      ),
    ];

    return Column(
      children: fields.map((f) {
        return CustomFormField(
          hint: f.$1,
          icon: f.$2,
          controller: f.$3,
          obscureText: f.$4,
          validator: f.$5,
          keyboardType: f.$4 ? TextInputType.text : TextInputType.emailAddress,
        );
      }).toList(),
    );
  }
}
