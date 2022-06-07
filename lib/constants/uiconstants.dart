import 'package:flutter/material.dart';

Text normalText(String text, [Color? color, double? size, bool? isBold]) {
  isBold ??= false;

  size ??= 12.0;
  color ??= Colors.amberAccent;

  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      letterSpacing: 1.15,
    ),
  );
}

Icon appIcon(
  IconData icon,
  Color? color,
  double? iconsize,
) {
  iconsize ??= 12.0;
  color ??= Colors.amberAccent;
  return Icon(
    icon,
    color: color,
    size: iconsize,
  );
}
