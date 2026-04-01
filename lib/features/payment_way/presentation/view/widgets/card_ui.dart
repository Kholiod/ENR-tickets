import 'package:flutter/material.dart';

class CardUI extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;

  const CardUI({super.key, required this.cardNumber, required this.expiryDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("CARD NUMBER", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 10),
          Text(
            cardNumber.isEmpty ? "**** **** **** ****" : cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                expiryDate.isEmpty ? "MM/YY" : expiryDate,
                style: const TextStyle(color: Colors.white),
              ),
              const Text("ENR", style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
