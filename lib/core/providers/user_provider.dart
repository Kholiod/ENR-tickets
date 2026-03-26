import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String name = "";
  String phone = "";
  String email = "";

  void setUser({String? newName, String? newPhone, String? newEmail}) {
    if (newName != null) name = newName;
    if (newPhone != null) phone = newPhone;
    if (newEmail != null) email = newEmail;

    notifyListeners();
  }
}
