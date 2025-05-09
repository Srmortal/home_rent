import 'package:flutter/material.dart';
import 'package:home_rent/helper.dart';

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
    int level = 0;
    final hasUpper=RegExp(r'[A-Z]').hasMatch(password)? 1:0;
    final hasLower=RegExp(r'[a-z]').hasMatch(password)? 1:0;
    final hasNumber=RegExp(r'[0-9]').hasMatch(password)? 1:0;
    final hasSymbol=RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)? 1:0;
    level=hasSymbol+hasNumber+hasLower+hasUpper;
    setState(() {
      if(level==0){
        strength=0;
      }
      else if (level<=1) {
        strength=0.3;
      }
      else if(level<=3){
        strength=0.6;
      }else{
        strength=1.0;
      }
    });
  }
  Color getStrengthColor() {
    if(strength == 0) return Colors.white;
    if (strength == 0.3) return Color(0xffff4d4d);
    if (strength == 0.6) return Color(0xffffa500);
    return Colors.green;
  }
  String getStrengthText() {
    if (strength == 0) return "Password Strength";
    if (strength == 0.3) return widget.controller.text.length<8? "Weak - too short":"Weak - add more variety";
    if (strength == 0.6) return "Medium - Getting better";
    return "Strong - Good job!";
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
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Root.broder_radius),
            color: const Color.fromARGB(255, 68, 68, 68),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Root.broder_radius),
                      color: const Color.fromARGB(255, 68, 68, 68),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: constraints.maxWidth * strength,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Root.broder_radius),
                      color: getStrengthColor(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        Text(
          getStrengthText(),
          style: TextStyle(
            fontSize: rem(context, 1),
            fontWeight: FontWeight.bold, 
            color: getStrengthColor()
          ),
        ),
      ],
    );
  }
}