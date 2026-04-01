import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InstapayScreen extends StatelessWidget {
  final String train;
  final String trainType;
  final String coach;
  final List seats;
  final String price;

  const InstapayScreen({
    super.key,
    required this.train,
    required this.trainType,
    required this.coach,
    required this.seats,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final data = "Train: $train\nSeats: ${seats.join(",")}\nPrice: $price EGP";

    return Scaffold(
      appBar: AppBar(
        title: const Text("InstaPay"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(data: data, size: 220),
            const SizedBox(height: 20),
            const Text("Scan to Pay", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
