import 'package:flutter/material.dart';

InputDecoration inputDecorationForm(Widget label,
    {Widget? prefixIcon, Widget? suffixIcon, required OutlineInputBorder border}) {
  return InputDecoration(
    filled: true,
      fillColor: Colors.black45,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 0.9),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      label: label);
}