import 'package:flutter/material.dart';

class PaymentHelpers {
  static void formatCard(TextEditingController controller, String value) {
    value = value.replaceAll(" ", "");

    String formatted = "";
    for (int i = 0; i < value.length; i++) {
      if (i % 4 == 0 && i != 0) formatted += " ";
      formatted += value[i];
    }

    controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  static void formatExpiry(TextEditingController controller, String value) {
    value = value.replaceAll("/", "");

    if (value.length > 4) return;

    String formatted = "";
    for (int i = 0; i < value.length; i++) {
      if (i == 2) formatted += "/";
      formatted += value[i];
    }

    controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  static Widget? getCardIcon(String input) {
    input = input.replaceAll(" ", "");

    if (input.startsWith("4")) {
      return const Icon(Icons.credit_card, color: Colors.blue);
    } else if (input.startsWith("5")) {
      return const Icon(Icons.credit_card, color: Colors.orange);
    }
    return null;
  }
}
