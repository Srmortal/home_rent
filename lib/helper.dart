import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
/*
class HoverEffect extends StatefulWidget {
  final Offset hoverTransition;
  final Widget child;
  final List<Color> hoverColors;
  final Duration animationDuration;
  final BoxShadow hoverShadow;
  final BorderRadius borderRadius;
  final Function(bool)? onHover;
  final Widget Function(bool)? childBuilder;
  const HoverEffect({
    super.key, 
    this.hoverTransition=const Offset(0, -2),
    required this.child, 
    this.hoverShadow=const BoxShadow(
      color: Colors.black54,
      offset: Offset(0, 6),
      blurRadius: 18,
      spreadRadius: 0,
    ), 
    this.onHover, 
    this.animationDuration = const Duration(milliseconds: 200),
    required this.hoverColors, 
    required this.borderRadius, this.childBuilder
  });
  @override
  State<StatefulWidget> createState() => _HoverEffectState();
}
class _HoverEffectState extends State<HoverEffect> {
  bool is_hovered=false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_)=>setState(() {
        is_hovered=true;
        widget.onHover?.call(true);
      }),
      onExit: (_)=>setState(() {
        is_hovered=false;
        widget.onHover?.call(false);
      }),
      child: AnimatedContainer(
        duration: widget.animationDuration,
        transform: is_hovered? (Matrix4.identity()..translate(widget.hoverTransition.dx,widget.hoverTransition.dy)):Matrix4.identity(),
        decoration: BoxDecoration(
          gradient: is_hovered
              ? LinearGradient(
                  colors: widget.hoverColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          boxShadow: is_hovered? [widget.hoverShadow]:[],
          borderRadius: widget.borderRadius
        ),
        child: widget.childBuilder != null 
            ? widget.childBuilder!(is_hovered) // Dynamic UI
            : widget.child,
      ),
    );
  }
}
*/
Future<Map<String,String?>> signup(String firstName,String lastName,String email,String password) async{
  final url = Uri.parse('https://home-rent.runasp.net/auth/sign-up');
  final response = await http.post(
    url,
    headers: {"content-type":"application/json"},
    body: jsonEncode({
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'password': password
    })
  );
  if (response.statusCode == 200) {
    print('creation success');
    return {};
  } else {
    final responseData=jsonDecode(response.body);
    Map<String, String?> extractedErrors = {};
    if (responseData is Map<String, dynamic> && responseData.containsKey('errors')) {
      final errors = responseData['errors'];

      if (errors is Map<String, dynamic>) {
        // Case: Validation errors (400 Bad Request)
        errors.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            extractedErrors[key] = value.join(", "); // Convert list to string
          }
        });
      } else if (errors is List) {
        // Case: General errors (401 Unauthorized)
        String combinedErrors = errors.join("\n");
        if (combinedErrors.contains("email")) {
          extractedErrors['email'] = "The email address provided is already in use.\nPlease use a different email address.";
        } else {
          extractedErrors['general'] = combinedErrors;
        }
      }
    }
    print("Extracted errors: $extractedErrors");
    return extractedErrors;
  }
}