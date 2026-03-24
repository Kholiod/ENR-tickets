import 'package:enr_tickets/features/create_account/presentation/view/create_account.dart';
import 'package:enr_tickets/features/payment_way/presentation/manager/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PaymentProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Quicksand"),
      home: CreateAccount(),
      debugShowCheckedModeBanner: false,
    );
  }
}
