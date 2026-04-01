import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/custom_logo.dart';
import 'package:enr_tickets/core/widget/custom_button_register.dart';
import 'package:enr_tickets/core/widget/sign_in_via.dart';

import 'package:enr_tickets/features/home/presentation/view/home_view.dart';
import 'package:enr_tickets/features/create_account/presentation/view/create_account.dart';

import 'package:enr_tickets/features/log_in/presentation/state_mangement/log_in_cubit.dart';
import 'package:enr_tickets/features/log_in/presentation/view/widgets/form_feild_view_login.dart';
import 'package:enr_tickets/features/log_in/presentation/view/widgets/sign_methods_view.dart';
import 'package:enr_tickets/features/log_in/presentation/view/widgets/custom_forget_text.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/custom_have_account_text_button.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({super.key});

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleState(BuildContext context, LogInState state) {
    if (state is LogInSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomeView()),
        (_) => false,
      );
    } else if (state is LogInFailure) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.error)));
    }
  }

  void _login(LogInCubit cubit) {
    if (formKey.currentState!.validate()) {
      cubit.logIn(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(
      listener: _handleState,
      builder: (context, state) {
        final cubit = context.read<LogInCubit>();

        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const CustomLogo(),
                Text(headlogIn),

                /// ✅ الاسم الصح هنا
                FormFieldViewLogin(
                  emailController: emailController,
                  passwordController: passwordController,
                ),

                Custom_Text_button(() {}, title: forgetpassword),

                state is LogInLoding
                    ? const CircularProgressIndicator()
                    : VerifyButton(title: "LogIn", onTap: () => _login(cubit)),

                const Gap(60),
                const SignInVia(),
                const Gap(20),
                const Center(child: SignMethodsView()),
                const Gap(20),

                CustomHaveAccountTextButton(
                  title: "I dont have account",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => CreateAccount()),
                      (_) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
