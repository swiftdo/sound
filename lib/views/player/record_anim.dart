import 'package:flutter/material.dart';

class RotateRecord extends AnimatedWidget {
  final Widget child;
  RotateRecord({
    super.key,
    required Animation<double> animation,
    required this.child,
  }) : super(listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      height: 250.0,
      width: 250.0,
      child: new RotationTransition(
        turns: animation,
        child: child,
      ),
    );
  }
}
