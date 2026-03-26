import 'dart:async';
import 'package:flutter/material.dart';
import 'ticket_screen.dart';
import 'package:provider/provider.dart';
import 'package:enr_tickets/core/providers/user_provider.dart';

class WalletScreen extends StatefulWidget {
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

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phone = TextEditingController();
  final TextEditingController otp = TextEditingController();

  bool showOtp = false;
  bool isLoading = false;

  int seconds = 30;
  Timer? timer;

  void startTimer() {
    seconds = 30;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    phone.dispose();
    otp.dispose();
    super.dispose();
  }

  /// 💳 fake payment
  void fakePayment() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => isLoading = false);

    /// 🔥 seats
    String seatNumbers = widget.seats.map((e) => e.number).join(",");

    /// 🔥 ticketId
    String ticketId =
        "${widget.train}_${seatNumbers}_${DateTime.now().millisecondsSinceEpoch}";

    /// 🔥 user provider
    final user = Provider.of<UserProvider>(context, listen: false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TicketScreen(
          from: "Cairo",
          to: "Sohag",
          train: widget.train,
          trainType: widget.trainType,
          coach: widget.coach,
          seat: seatNumbers,
          time: "06:00 AM",

          /// ✅ الاسم بس
          name: user.name.isNotEmpty ? user.name : "Passenger",

          price: widget.price,
          bookingType: "ذهاب فقط",
          ticketId: ticketId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// 📱 Phone (UI بس)
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter phone number";
                  }

                  if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
                    return "Invalid Egyptian number";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              if (!showOtp)
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() => showOtp = true);
                      startTimer();
                    }
                  },
                  child: const Text("Send Code"),
                ),

              if (showOtp) ...[
                const SizedBox(height: 20),

                TextFormField(
                  controller: otp,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Enter OTP",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter OTP";
                    }
                    if (value != "1234") {
                      return "Wrong code";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                Text(
                  seconds == 0 ? "Resend Code" : "Resend in $seconds s",
                  style: TextStyle(
                    color: seconds == 0 ? Colors.red : Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                if (seconds == 0)
                  TextButton(
                    onPressed: startTimer,
                    child: const Text("Resend Code"),
                  ),

                const SizedBox(height: 20),

                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            fakePayment();
                          }
                        },
                        child: const Text("Confirm Payment"),
                      ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
