import 'package:flutter/material.dart';
import 'package:home_rent/root.dart';

class PasswordBar extends StatefulWidget{
  final TextEditingController controller;
  const PasswordBar({super.key,required this.controller});
  @override
  State<StatefulWidget> createState() => _PasswordBarState();
}
class _PasswordBarState extends State<PasswordBar>{
  double strength = 0;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkPasswordStrength);
  }

  void _checkPasswordStrength() {
    if (!mounted) return;

    String password = widget.controller.text;
    double level = 0;

    if (password.length >= 6) level += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) level += 0.25;
    if (RegExp(r'[a-z]').hasMatch(password)) level += 0.25;
    if (RegExp(r'[0-9]').hasMatch(password)) level += 0.25;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) level += 0.25;

    setState(() {
      strength = level.clamp(0, 1);
    });
  }
  Color getStrengthColor() {
    if(strength==0) return Colors.white;
    if (strength <= 0.25) return Colors.red;
    if (strength <= 0.5) return Colors.orange;
    if (strength <= 0.75) return Colors.blue;
    return Colors.green;
  }
  String getStrengthText() {
    if (strength == 1) return "Very Strong";
    if (strength >= 0.75) return "Strong";
    if (strength >= 0.5) return "Medium";
    if (strength >= 0.25) return "Weak";
    return strength==0? "Password Strength":"Too Weak";
  }
  @override
  void dispose() {
    widget.controller.removeListener(_checkPasswordStrength);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: strength,
          backgroundColor: Color.fromARGB(255, 68, 68, 68),
          color: getStrengthColor(),
          minHeight: 8,
          borderRadius: BorderRadius.circular(Root.broder_radius),
        ),
        SizedBox(height: 5),
        Text(
          getStrengthText(),
          style: TextStyle(fontWeight: FontWeight.bold, color: getStrengthColor()),
        ),
      ],
    );
  }
}