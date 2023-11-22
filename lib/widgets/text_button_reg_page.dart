import 'package:flutter/material.dart';

class TextButtonClass1 extends StatelessWidget {
  final String title;
  final Function function;

  const TextButtonClass1(
      {Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.black45),
          fixedSize: MaterialStateProperty.all(
            const Size(350, 55),
          ),
        ),
        onPressed: () => function(),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 23,
            fontWeight: FontWeight.w500,
            fontFamily: 'din-pro-bold',
          ),
        ),
      ),
    );
  }
}
