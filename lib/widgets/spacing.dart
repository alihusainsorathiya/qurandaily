import 'package:flutter/material.dart';

Widget addVerticalSpace([double? height]) {
  height ??= 10.0;
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace([double? width]) {
  width ??= 10.0;
  return SizedBox(
    width: width,
  );
}
