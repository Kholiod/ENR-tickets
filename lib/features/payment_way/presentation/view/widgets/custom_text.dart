import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final TextStyle  stylestitle;
  const CustomText({super.key, required this.title, required this.stylestitle});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: stylestitle));
  }
}
