import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class CustomFormFeild extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomFormFeild({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomFormFeild> createState() => _CustomFormFeildState();
}

class _CustomFormFeildState extends State<CustomFormFeild> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: isObscure,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          fillColor: formColor,
          filled: true,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: buttonColor, width: 1.6),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: buttonColor, width: 1.6),
          ),

          hintText: widget.hint,
          hintStyle: Styles.hintStyle,

          prefixIcon: Icon(widget.icon, color: iconColor),

          /// 👁 Eye Icon
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
