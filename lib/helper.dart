import 'package:flutter/material.dart';

double rem(BuildContext context, double remValue, {double baseSize = 16}) {
  double scale = MediaQuery.of(context).size.width / 360; // 360 is a common Android width
  return remValue * baseSize * scale;
}