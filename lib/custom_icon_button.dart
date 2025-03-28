import 'package:flutter/material.dart';

class iconButton extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  const iconButton({super.key, required this.iconData, required this.onPressed});
  @override
  State<StatefulWidget> createState() => iconButtonState();
}
class iconButtonState extends State<iconButton>{
  bool is_hovered=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
        color: is_hovered? const Color.fromARGB(40, 54, 26, 216):Colors.transparent
      ),
      child: IconButton(
        onPressed: widget.onPressed,
        onHover: (value)=>setState(() {
          is_hovered=value;
        }),
        icon: Icon(
          widget.iconData,
          color: is_hovered? const Color.fromARGB(255, 54, 26, 216): Colors.white54,
        )
      ),
    );
  }
}