class Validators {

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    if (value.length < 3) {
      return "Enter valid name";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!emailRegex.hasMatch(value)) {
      return "Enter valid email";
    }

    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number required";
    }

    if (value.length != 11) {
      return "Enter valid phone number";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

}