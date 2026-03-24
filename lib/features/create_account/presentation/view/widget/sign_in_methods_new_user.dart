import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class SignMethodCreateAccount extends StatelessWidget {

  final void Function()? onTap;
  final String image;
  final String methodName;
  
  const SignMethodCreateAccount(
    this.onTap, {
    super.key,
    required this.image,
    required this.methodName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.43,
          height: MediaQuery.sizeOf(context).height * 0.06,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border(left: BorderSide.none),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Image.asset(image, width: 50, height: 50),
              ),

              Text(methodName, style: Styles.textStyle20),
            ],
          ),
        ),
      ),
    );
  }
}
