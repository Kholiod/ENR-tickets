import 'package:flutter/material.dart';
import 'package:enr_tickets/core/widget/custom_form_feild.dart';

class FormFeildViewSignIn extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  /// 🔥 مهم
  final VoidCallback onSubmit;

  const FormFeildViewSignIn({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSubmit,
  });

  @override
  State<FormFeildViewSignIn> createState() => _FormFeildViewSignInState();
}

class _FormFeildViewSignInState extends State<FormFeildViewSignIn> {
  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  @override
  void dispose() {
    nameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    confirmFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormFeild(
          hint: "Name",
          icon: Icons.person,
          controller: widget.nameController,
          focusNode: nameFocus,
          nextFocus: emailFocus,
        ),

        CustomFormFeild(
          hint: "Email",
          icon: Icons.email,
          controller: widget.emailController,
          focusNode: emailFocus,
          nextFocus: phoneFocus,
        ),

        CustomFormFeild(
          hint: "Phone",
          icon: Icons.phone,
          controller: widget.phoneController,
          focusNode: phoneFocus,
          nextFocus: passwordFocus,
        ),

        CustomFormFeild(
          hint: "Password",
          icon: Icons.lock,
          controller: widget.passwordController,
          obscureText: true,
          focusNode: passwordFocus,
          nextFocus: confirmFocus,
        ),

        CustomFormFeild(
          hint: "Confirm Password",
          icon: Icons.lock,
          controller: widget.confirmPasswordController,
          obscureText: true,
          focusNode: confirmFocus,

          /// 🔥 Enter الأخير
          onSubmit: () {
            FocusScope.of(context).unfocus();
            widget.onSubmit();
          },
        ),
      ],
    );
  }
}
