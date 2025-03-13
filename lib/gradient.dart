import 'package:flutter/material.dart';
import 'package:home_rent/helper.dart';
class GradientButton extends StatefulWidget {
  final double degrees;
  final List<Color> colors;
  final Widget? child;
  final VoidCallback? onPressed;
  final Size? minimumSize,maximumSize;
  final BorderRadius borderRadius;
  final Color shadowColor;
  final Offset shadowOffset;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final EdgeInsets padding;
  const GradientButton({
    super.key,
    required this.child,
    required this.colors,
    required this.degrees, 
    this.onPressed, 
    this.minimumSize, 
    this.maximumSize, 
    required this.borderRadius, 
    this.shadowColor = Colors.black54, 
    this.shadowOffset = const Offset(2, 2), 
    this.shadowBlurRadius = 4,
    this.shadowSpreadRadius = 0.0, 
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 16)
  });
  
  @override
  State<StatefulWidget> createState() => _GradientButtonState();
  
}
class _GradientButtonState extends State<GradientButton> {
  bool is_hovered=false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.colors,
          begin: getAlignmentFromDegrees(widget.degrees),
          end: getAlignmentFromDegrees(widget.degrees+180)
        ),
        borderRadius: widget.borderRadius,
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor,
            offset: widget.shadowOffset,
            spreadRadius: widget.shadowSpreadRadius,
            blurRadius: widget.shadowBlurRadius
          )
        ]
      ),
      duration: Duration(milliseconds: 150),
      transform: Matrix4.translationValues(0, is_hovered ? -2 : 0, 0),
      child: ElevatedButton(
        onPressed: widget.onPressed, 
        onHover: (value) {
          setState(() {
            is_hovered=value;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: is_hovered? const Color.fromARGB(80, 15, 15, 15): Colors.transparent, // Make button background transparent
          shadowColor: is_hovered? const Color.fromARGB(67, 0, 0, 0): Colors.transparent, // Remove shadow
          padding: widget.padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Match container's border radius
          ),
          maximumSize: widget.maximumSize,
          minimumSize: widget.minimumSize
        ),
        child: widget.child,
      ),
    );
  }
}