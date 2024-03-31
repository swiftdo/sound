import 'package:flutter/material.dart';

class VIconButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double size;
  final IconData icon;

  const VIconButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        width: size,
        height: size,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: size * 0.36,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              this.title,
              style: TextStyle(fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}
