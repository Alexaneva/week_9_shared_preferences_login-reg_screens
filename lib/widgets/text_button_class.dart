import 'package:flutter/material.dart';

class TextButtonClass extends StatelessWidget {
  final String title;
  final Function function;

  const TextButtonClass({Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => function(),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 23,
          fontWeight: FontWeight.w500,
          fontFamily: 'din-pro-bold',
        ),
      ),
    );
  }
}
