import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:enr_tickets/features/create_account/presentation/view/create_account.dart';
import 'package:enr_tickets/features/payment_way/presentation/manager/payment_provider.dart';
import 'package:enr_tickets/core/providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// 🔥 هنا استخدمنا Cairo بدل Quicksand
      theme: ThemeData(fontFamily: "Cairo"),

      home: const CreateAccount(),
    );
  }
}
