import 'dart:math';
import 'package:flutter/material.dart';
import 'package:home_rent/custom_card.dart';
import 'package:home_rent/root.dart';
double rem(BuildContext context, double remValue, {double baseSize = 16}) {
  double scale = MediaQuery.of(context).size.width / 360; // 360 is a common Android width
  return remValue * baseSize * scale;
}
Alignment getAlignmentFromDegrees(double degrees) {
  double radians = degrees * (pi / 180);
  double x = cos(radians);
  double y = sin(radians);
  return Alignment(-x, y);
}