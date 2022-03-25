import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  AppLargeText(
      {Key? key, required this.text, this.color = Colors.white, this.size = 30})
      : super(key: key);
  double size;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
      TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}
