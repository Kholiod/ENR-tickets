import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  String selectedMethod = "";

  void selectMethod(String method) {
    selectedMethod = method;
    notifyListeners();
  }
}
