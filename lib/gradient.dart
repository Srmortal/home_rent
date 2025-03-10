import 'package:flutter/material.dart';
import 'package:home_rent/helper.dart';
class GradientButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: getAlignmentFromDegrees(degrees),
          end: getAlignmentFromDegrees(degrees+180)
        ),
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: shadowOffset,
            spreadRadius: shadowSpreadRadius,
            blurRadius: shadowBlurRadius
          )
        ]
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make button background transparent
          shadowColor: Colors.transparent, // Remove shadow
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Match container's border radius
          ),
          maximumSize: maximumSize,
          minimumSize: minimumSize
        ), 
        child: child,
      ),
    );
  }
}