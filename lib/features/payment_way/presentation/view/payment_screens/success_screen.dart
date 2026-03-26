import 'dart:async';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  final Widget nextScreen;

  const SuccessScreen({super.key, required this.nextScreen});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();

    /// 🔥 Auto redirect بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.nextScreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// ✅ ICON
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.green, size: 70),
              ),

              const SizedBox(height: 25),

              /// 🔥 TEXT
              const Text(
                "Payment Successful",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Redirecting to your ticket...",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 40),

              /// 🔴 BUTTON (لو عايز يروح بسرعة)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => widget.nextScreen),
                    );
                  },
                  child: const Text("View Ticket"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
