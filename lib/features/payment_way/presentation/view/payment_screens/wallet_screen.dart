import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:enr_tickets/core/services/paymob_service.dart';
import 'package:enr_tickets/features/payment_way/presentation/manager/payment_cubit.dart';

class WalletScreen extends StatelessWidget {
  final String train;
  final String trainType;
  final String coach;
  final List seats;
  final String price;

  const WalletScreen({
    super.key,
    required this.train,
    required this.trainType,
    required this.coach,
    required this.seats,
    required this.price,
  });

  Future<void> openPayment(String url, BuildContext context) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Can't open payment page")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final seatsString = seats.map((e) => e.number).join(",");

    return BlocProvider(
      create: (_) => PaymentCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Wallet Payment"),
          backgroundColor: Colors.green,
        ),
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) async {
            if (state is PaymentSuccess && state.paymentUrl != null) {
              await openPayment(state.paymentUrl!, context);
            }

            if (state is PaymentError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Payment failed")));
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is PaymentLoading)
                    const CircularProgressIndicator(),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: state is PaymentLoading
                        ? null
                        : () {
                            context.read<PaymentCubit>().payWithPaymob(
                              train: train,
                              trainType: trainType,
                              coach: coach,
                              seats: seatsString,
                              price: price,
                              name: "Passenger",
                              integrationId: PaymobService.walletIntegrationId,
                            );
                          },
                    child: const Text("Pay with Wallet"),
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
