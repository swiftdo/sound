import 'package:flutter/material.dart';

class StateButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final double width;
  final double height;
  final Color borderColor;
  final double fontSize;
  final VoidCallback? onTap;

  const StateButton({
    super.key,
    required this.title,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    required this.width,
    required this.height,
    this.textColor,
    this.fontSize = 12,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(height / 2),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
