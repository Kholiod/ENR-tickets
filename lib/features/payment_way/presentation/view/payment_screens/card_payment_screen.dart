import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/payment_screens/ticket_screen.dart';
import 'package:provider/provider.dart';
import 'package:enr_tickets/core/providers/user_provider.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/payment_screens/success_screen.dart';

class CardPaymentScreen extends StatefulWidget {
  final String train;
  final String trainType;
  final String coach;
  final List seats;
  final String price;

  const CardPaymentScreen({
    super.key,
    required this.train,
    required this.trainType,
    required this.coach,
    required this.seats,
    required this.price,
  });

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cvv = TextEditingController();

  bool isCvvHidden = true;

  void _formatCardNumber(String value) {
    value = value.replaceAll(" ", "");

    String formatted = "";
    for (int i = 0; i < value.length; i++) {
      if (i % 4 == 0 && i != 0) formatted += " ";
      formatted += value[i];
    }

    cardNumber.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  Widget? _getCardIcon() {
    String input = cardNumber.text.replaceAll(" ", "");

    if (input.startsWith("4")) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.credit_card, color: Colors.blue),
      );
    } else if (input.startsWith("5")) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.credit_card, color: Colors.orange),
      );
    }
    return null;
  }

  bool _isValidCard(String input) {
    input = input.replaceAll(" ", "");

    int sum = 0;
    bool alternate = false;

    for (int i = input.length - 1; i >= 0; i--) {
      int n = int.parse(input[i]);

      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }

      sum += n;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  void _formatExpiry(String value) {
    value = value.replaceAll("/", "");

    if (value.length > 4) return;

    String formatted = "";
    for (int i = 0; i < value.length; i++) {
      if (i == 2) formatted += "/";
      formatted += value[i];
    }

    expiryDate.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    String seatNumbers = widget.seats.map((e) => e.number).join(",");

    return Scaffold(
      appBar: AppBar(title: const Text("Card Payment"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// 💳 CARD UI
              Container(
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Colors.red, Colors.orange],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "CARD NUMBER",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cardNumber.text.isEmpty
                          ? "**** **** **** ****"
                          : cardNumber.text,
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
                          expiryDate.text.isEmpty ? "MM/YY" : expiryDate.text,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Text(
                          "ENR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// 📝 FORM
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: cardNumber,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                      ],
                      decoration: InputDecoration(
                        labelText: "Card Number",
                        prefixIcon: const Icon(Icons.credit_card),
                        suffixIcon: _getCardIcon(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: _formatCardNumber,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter card number";
                        }
                        String cleaned = value.replaceAll(" ", "");
                        if (cleaned.length < 16) return "Must be 16 digits";
                        if (!_isValidCard(cleaned)) return "Invalid card";
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: expiryDate,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: InputDecoration(
                              labelText: "MM/YY",
                              prefixIcon: const Icon(Icons.date_range),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onChanged: _formatExpiry,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required";
                              }
                              if (!value.contains("/")) return "Invalid";
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: cvv,
                            keyboardType: TextInputType.number,
                            obscureText: isCvvHidden,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              labelText: "CVV",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isCvvHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isCvvHidden = !isCvvHidden;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required";
                              }
                              if (value.length != 3) return "3 digits";
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// 🔥 PAY NOW (أحمر)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String ticketId =
                                "${widget.train}_${seatNumbers}_${DateTime.now().millisecondsSinceEpoch}";

                            final user = Provider.of<UserProvider>(
                              context,
                              listen: false,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SuccessScreen(
                                  nextScreen: TicketScreen(
                                    from: "Cairo",
                                    to: "Sohag",
                                    train: widget.train,
                                    trainType: widget.trainType,
                                    coach: widget.coach,
                                    seat: seatNumbers,
                                    time: "06:00 AM",
                                    name: user.name.isNotEmpty
                                        ? user.name
                                        : "Passenger",
                                    price: widget.price,
                                    bookingType: "ذهاب فقط",
                                    ticketId: ticketId,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
