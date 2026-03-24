import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/utils/validators.dart';
import 'package:enr_tickets/core/widget/custom_form_feild.dart';
import 'package:flutter/material.dart';

class FormFeildViewSignIn extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const FormFeildViewSignIn({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormFeild(
          hint: fullnameuser,
          icon: Icons.person,
          controller: nameController,
          validator: Validators.nameValidator,
        ),
        CustomFormFeild(
          hint: email,
          icon: Icons.email_rounded,
          controller: emailController,
          validator: Validators.emailValidator,
        ),
        CustomFormFeild(
          hint: phoneNumber,
          icon: Icons.phone,
          controller: phoneController,
          keyboardType: TextInputType.phone,
          validator: Validators.phoneValidator,
        ),
        CustomFormFeild(
          hint: password,
          icon: Icons.lock_outline,
          controller: passwordController,
          obscureText: true,
          validator: Validators.passwordValidator,
        ),
        CustomFormFeild(
          hint: confirmpassword,
          icon: Icons.lock_outline,
          controller: confirmPasswordController,
          obscureText: true,
          validator: (value) {
            if (value != passwordController.text) {
              return "Passwords do not match";
            }
            return null;
          },
        ),
      ],
    );
  }
}
