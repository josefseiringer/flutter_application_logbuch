import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Widget suffixIcon;
  final TextStyle hintStyle;
  final TextEditingController myController;
  final TextInputType myTextInputType;

  const MyTextField({
    super.key,
    required this.myController,
    required this.hintText,
    required this.suffixIcon,
    required this.hintStyle,
    required this.myTextInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(      
      controller: myController,
      keyboardType: myTextInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
