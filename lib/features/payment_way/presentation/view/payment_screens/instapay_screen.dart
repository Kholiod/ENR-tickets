import 'dart:async';
import 'package:flutter/material.dart';
import 'ticket_screen.dart';

class InstaPayScreen extends StatefulWidget {
  const InstaPayScreen({super.key});

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

  /// ⏱ start countdown
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
    super.dispose();
  }

  /// 💳 fake payment loading
  void fakePayment() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const TicketScreen(
          from: "Cairo",
          to: "Tanta",
          train: "903",
          seat: "A1",
          time: "06:00 AM",
          name: "Khaled",
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

                  /// لو رقم
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

                /// ⏱ Countdown
                Text(
                  seconds == 0 ? "Resend Code" : "Resend in $seconds s",
                  style: TextStyle(
                    color: seconds == 0 ? Colors.red : Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                /// 🔁 Resend
                if (seconds == 0)
                  TextButton(
                    onPressed: () {
                      startTimer();
                    },
                    child: const Text("Resend Code"),
                  ),

                const SizedBox(height: 20),

                /// 💳 Confirm
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
