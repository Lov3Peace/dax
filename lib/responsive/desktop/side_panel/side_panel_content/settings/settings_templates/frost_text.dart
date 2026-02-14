import 'package:flutter/material.dart';

class FrostedTextF extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final Color borderColor;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets padding;

  const FrostedTextF({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.borderColor = Colors.white24,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 32, 32, 40),
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: borderColor),
      ),
      padding: padding,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white60),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
