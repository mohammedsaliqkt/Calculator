import 'package:flutter/material.dart';

extension DynamicSize on BuildContext {
  double width(double width) => MediaQuery.sizeOf(this).width * width;
  double height(double height) => MediaQuery.sizeOf(this).height * height;
}
