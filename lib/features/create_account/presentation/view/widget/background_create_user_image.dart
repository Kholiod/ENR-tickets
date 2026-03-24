import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/features/create_account/presentation/state_mangement/creat_user_cubit.dart';
import 'package:enr_tickets/features/create_account/presentation/view/widget/create_account_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundCreateUserImage extends StatelessWidget {
  const BackgroundCreateUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatUserCubit(),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AssetsData.backgroundimage, fit: BoxFit.cover),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.05,
            left: 10,
            right: 10,
            bottom: 10,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: CreateAccountBody(),
            ),
          ),
        ],
      ),
    );
  }
}
