import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool obligatory;
  final String keyboardType;
  final IconData? prefixIcon;

  const InputBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.obligatory,
    this.keyboardType = 'text',
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType == 'text'
          ? TextInputType.text
          : const TextInputType.numberWithOptions(decimal: true),
      textAlign: TextAlign.left,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 50, left: 20),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 143, 134, 134)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 143, 134, 134)),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        labelText: obligatory ? '$hintText*' : hintText,
      ),
    );
  }
}
