import 'package:flutter/material.dart';
import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';

class CustomFormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final VoidCallback? onSubmit;

  const CustomFormField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.nextFocus,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final obscure = ValueNotifier(obscureText);

    OutlineInputBorder border(double r) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(r),
      borderSide: BorderSide(color: buttonColor, width: 1.6),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: ValueListenableBuilder<bool>(
        valueListenable: obscure,
        builder: (_, value, __) {
          return TextFormField(
            controller: controller,
            validator: validator,
            obscureText: value,
            keyboardType: keyboardType,
            focusNode: focusNode,
            textInputAction: nextFocus != null
                ? TextInputAction.next
                : TextInputAction.done,
            onFieldSubmitted: (_) {
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              } else {
                FocusScope.of(context).unfocus();
                onSubmit?.call();
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: formColor,
              hintText: hint,
              hintStyle: Styles.hintStyle,
              prefixIcon: Icon(icon, color: iconColor),
              enabledBorder: border(12),
              focusedBorder: border(15),
              suffixIcon: obscureText
                  ? IconButton(
                      icon: Icon(
                        value ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => obscure.value = !value,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
