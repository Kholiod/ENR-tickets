import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/features/create_account/presentation/state_mangement/creat_user_cubit.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/create_account_body.dart';

class BackgroundCreateUserImage extends StatelessWidget {
  const BackgroundCreateUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (_) => CreatUserCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            /// 🔥 Background
            Positioned.fill(
              child: Image.asset(AssetsData.backgroundimage, fit: BoxFit.cover),
            ),

            /// 🔥 Form
            Positioned(
              top: screenHeight * 0.05,
              left: 10,
              right: 10,
              bottom: 10,
              child: CreateAccountBody(), // ❗ بدون const
            ),
          ],
        ),
      ),
    );
  }
}
