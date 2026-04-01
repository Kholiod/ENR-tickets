import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumber;
  final TextEditingController expiryDate;
  final TextEditingController cvv;
  final bool isCvvHidden;
  final VoidCallback onToggleCvv;
  final Function(String) onCardChanged;
  final Function(String) onExpiryChanged;
  final Widget? cardIcon;
  final VoidCallback onPay;

  const PaymentForm({
    super.key,
    required this.formKey,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.isCvvHidden,
    required this.onToggleCvv,
    required this.onCardChanged,
    required this.onExpiryChanged,
    required this.cardIcon,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
              suffixIcon: cardIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: onCardChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter card number";
              }
              String cleaned = value.replaceAll(" ", "");
              if (cleaned.length < 16) return "Must be 16 digits";
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
                  onChanged: onExpiryChanged,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Required";
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
                        isCvvHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: onToggleCvv,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Required";
                    if (value.length != 3) return "3 digits";
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: onPay,
              child: const Text("Pay Now"),
            ),
          ),
        ],
      ),
    );
  }
}
