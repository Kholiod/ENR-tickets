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
import 'package:provider/provider.dart';
import 'package:enr_tickets/core/providers/user_provider.dart';

class CreateAccountBody extends StatefulWidget {
  const CreateAccountBody({super.key});

  @override
  State<CreateAccountBody> createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  /// 🔥 submit function (واحدة بس بدل التكرار)
  void submit() {
    if (formKey.currentState!.validate()) {
      final user = Provider.of<UserProvider>(context, listen: false);

      user.setUser(
        newName: nameController.text.trim(),
        newPhone: phoneController.text.trim(),
        newEmail: emailController.text.trim(),
      );

      context.read<CreatUserCubit>().createUser();
    }
  }

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
            MaterialPageRoute(builder: (_) => const LogIn()),
            (route) => false,
          );
        } else if (state is CreatUserFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(13),

                const CustomLogo(),

                Text(
                  sign_up_title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                /// 🔥 الفورم (هنا حلينا المشكلة)
                FormFeildViewSignIn(
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  onSubmit: submit, // ✅ مهم جدًا
                ),

                const Gap(10),

                state is CreatUserLoading
                    ? const CircularProgressIndicator()
                    : VerifyButton(
                        title: sign_up_button,
                        onTap: submit, // ✅ نفس الفنكشن
                      ),

                const Gap(15),

                const SignInVia(),
                const Gap(15),
                const SignInMethodsView(),

                const Gap(15),

                CustomHaveAccountTextButton(
                  title: arlreadyaccount,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LogIn()),
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
