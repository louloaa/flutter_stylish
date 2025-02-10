import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    required TextEditingController controller,
  });

  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      obscureText: true,
    );
  }
}
