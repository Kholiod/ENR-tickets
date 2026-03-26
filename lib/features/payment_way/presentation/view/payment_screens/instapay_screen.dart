import 'dart:async';
import 'package:flutter/material.dart';
import 'ticket_screen.dart';
import 'package:provider/provider.dart';
import 'package:enr_tickets/core/providers/user_provider.dart';

class InstaPayScreen extends StatefulWidget {
  final String train;
  final String trainType;
  final String coach;
  final List seats;
  final String price;

  const InstaPayScreen({
    super.key,
    required this.train,
    required this.trainType,
    required this.coach,
    required this.seats,
    required this.price,
  });

  @override
  State<InstaPayScreen> createState() => _InstaPayScreenState();
}

class _InstaPayScreenState extends State<InstaPayScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController input = TextEditingController();
  TextEditingController otp = TextEditingController();

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
    input.dispose();
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
      appBar: AppBar(title: const Text("InstaPay")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// 📱 Input
              TextFormField(
                controller: input,
                decoration: const InputDecoration(
                  labelText: "Phone / InstaPay ID",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter data";
                  }

                  if (RegExp(r'^[0-9]+$').hasMatch(value)) {
                    if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
                      return "Invalid phone";
                    }
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// 🔥 Send Code
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

              /// 🔥 OTP
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
