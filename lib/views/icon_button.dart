import 'package:flutter/material.dart';

class VIconButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double iconSize;
  final IconData icon;

  const VIconButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    this.iconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 4),
      onPressed: this.onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // 设置圆角的半径
      ),
      child: Column(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(iconSize / 2),
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: Icon(
              icon,
              size: iconSize / 2,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            this.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
