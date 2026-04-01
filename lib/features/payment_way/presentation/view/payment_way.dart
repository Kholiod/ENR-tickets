import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

import 'package:enr_tickets/features/payment_way/presentation/manager/payment_cubit.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/payment_screens/payment_webview.dart';

class PaymentWay extends StatelessWidget {
  final String train, trainType, coach, from, to, price, name;
  final List seats;

  const PaymentWay({
    super.key,
    required this.train,
    required this.trainType,
    required this.coach,
    required this.seats,
    required this.from,
    required this.to,
    required this.price,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final seatsString = seats.map((e) => e.number).join(",");

    final methods = [
      ("Card", Icons.credit_card, Colors.red, 5598973),
      ("Wallet", Icons.account_balance_wallet, Colors.green, 5599322),
    ];

    return BlocProvider(
      create: (_) => PaymentCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payment"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) async {
            if (state is PaymentSuccess) {
              if (kIsWeb && state.paymentUrl != null) {
                html.window.location.href = state.paymentUrl!;
              } else if (state.paymentKey != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentWebView(
                      paymentKey: state.paymentKey!,
                      data: {
                        "from": from,
                        "to": to,
                        "train": train,
                        "trainType": trainType,
                        "coach": coach,
                        "seat": seatsString,
                        "name": name,
                        "price": price,
                        "bookingType": "ذهاب فقط",
                        "ticketId": state.ticketId,
                      },
                    ),
                  ),
                );
              }
            }

            if (state is PaymentError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Payment Failed")));
            }
          },
          builder: (context, state) {
            final cubit = context.read<PaymentCubit>();

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: methods.map((m) {
                        return GestureDetector(
                          onTap: () {
                            cubit.payWithPaymob(
                              train: train,
                              trainType: trainType,
                              coach: coach,
                              seats: seatsString,
                              price: price,
                              name: name,
                              integrationId: m.$4,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: m.$3.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: m.$3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(m.$2, size: 30, color: m.$3),
                                const SizedBox(height: 8),
                                Text(
                                  m.$1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: m.$3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if (state is PaymentLoading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
