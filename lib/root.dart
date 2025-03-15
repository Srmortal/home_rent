// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Root{
  static const Color primary_color_dark=Color(0xff6a11cb),
  primary_hover_dark=Color(0xff5211a8),
  error_color=Color(0xffff4d4d),input_bg_dark=Color(0xff333344);
  static const double broder_radius=8;
  static const text_secondary=Color(0xffcccccc),
  input_border=Color(0xff444455),
  card_bg_dark=Color(0xff2a2a3a);
  static const BoxShadow card_shadow_dark=BoxShadow(
    offset: Offset(0, 8),
    blurRadius: 20,
    color: Color.fromRGBO(80, 27, 107, 0.858)
  );
  static const BoxShadow card_shadow_hover=BoxShadow(
    offset: Offset(0, 12),
    blurRadius: 24,
    color: Color.fromRGBO(0, 0, 0, 0.1)
  );

}