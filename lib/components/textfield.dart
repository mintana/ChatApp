import 'package:flutter/material.dart';

class Text_Field extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool obscureText;
  final suffixIcon;

  const Text_Field(
      {super.key,
      required this.controller,
      required this.text,
      required this.obscureText, 
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
  controller: controller,
  obscureText: obscureText,
  decoration: InputDecoration(
    fillColor: const Color.fromARGB(0, 0, 0, 0),
    hintText: text,
    suffixIcon: suffixIcon,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        color: Colors.black, 
        width: 2.0, 
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        color: Colors.black, 
        width: 2.0, 
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        color: Colors.black, 
        width: 2.0, 
      ),
    ),
  ),
);
  }
}
