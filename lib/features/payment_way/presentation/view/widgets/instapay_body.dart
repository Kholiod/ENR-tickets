import 'package:flutter/material.dart';

class InstapayBody extends StatelessWidget {
  final VoidCallback onPay;

  const InstapayBody({super.key, required this.onPay});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Icon(Icons.account_balance_wallet, size: 80),
          const SizedBox(height: 20),
          const Text("Pay with Instapay", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: onPay,
              child: const Text("Confirm Payment"),
            ),
          ),
        ],
      ),
    );
  }
}
