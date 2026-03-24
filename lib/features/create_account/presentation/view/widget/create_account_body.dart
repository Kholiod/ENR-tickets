import 'package:enr_tickets/core/utils/strings.dart';
import 'package:enr_tickets/core/widget/custom_button_register.dart';
import 'package:enr_tickets/core/widget/custom_logo.dart';
import 'package:enr_tickets/core/widget/sign_in_via.dart';
import 'package:enr_tickets/features/create_account/presentation/state_mangement/creat_user_cubit.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/custom_have_account_text_button.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/form_feild_view_sign_in.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/sign_in_methods_view.dart';
import 'package:enr_tickets/features/log_in/presentation/view/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CreateAccountBody extends StatefulWidget {
  const CreateAccountBody({super.key});

  @override
  State<CreateAccountBody> createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatUserCubit, CreatUserState>(
      listener: (context, state) {
        if (state is CreatUserSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => LogIn()),
            (route) => false,
          );
        } else if (state is CreatUserFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<CreatUserCubit>();

        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(13),

                /// Logo
                CustomLogo(),

                /// 🔥 العنوان
                Text(
                  sign_up_title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                /// الفورم
                FormFeildViewSignIn(
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),

                const Gap(10),

                /// زرار
                state is CreatUserLoading
                    ? const CircularProgressIndicator()
                    : VerifyButton(
                        title: sign_up_button,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.createUser();
                          }
                        },
                      ),

                const Gap(15),

                /// social
                SignInVia(),
                const Gap(15),
                SignInMethodsView(),

                const Gap(15),

                /// login text
                CustomHaveAccountTextButton(
                  title: arlreadyaccount,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => LogIn()),
                      (route) => false,
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
