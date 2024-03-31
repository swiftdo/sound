import 'package:flutter/material.dart';

enum FillingSliderDirection { vertical, horizontal }

typedef ChangeCallback = void Function(double newValue, double oldValue);
typedef FinishCallback = void Function(double value);
typedef ChildBuilder = Widget Function(BuildContext context, double value);

class FillingSlider extends StatefulWidget {
  /// Creates a IOS-like slider
  FillingSlider(
      {Key? key,
      this.initialValue = 1.0,
      this.onChange,
      this.onFinish,
      this.direction = FillingSliderDirection.vertical,
      this.color = const Color.fromRGBO(46, 45, 36, 0.5),
      this.fillColor = const Color.fromRGBO(215, 216, 218, 0.3),
      this.child,
      this.childBuilder,
      this.width = 80,
      this.height = 200})
      : super(key: key);

  /// Initial value of slider  1.0 <= value >= 0.0
  final double initialValue;

  /// Change callback
  final ChangeCallback? onChange;

  /// End of changes callback
  final FinishCallback? onFinish;
  final FillingSliderDirection direction;
  final double height;
  final double width;
  final Color color;
  final Color fillColor;
  final ChildBuilder? childBuilder;
  final Widget? child;

  @override
  _FillingSliderState createState() => _FillingSliderState();
}

class _FillingSliderState extends State<FillingSlider> {
  double? stateValue;

  @override
  void initState() {
    stateValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return widget.direction == FillingSliderDirection.vertical
        ? getVertical()
        : getHorizontal();
  }

  void updateData(double position) {
    double currentValue =
        double.parse((1 - (position / getMainAxisSize())).toStringAsFixed(2));
    if (currentValue > 1) {
      currentValue = 1;
    } else if (currentValue < 0) {
      currentValue = 0;
    }
    if (widget.onChange != null) {
      widget.onChange!(currentValue, stateValue!);
    }
    setState(() {
      stateValue = currentValue;
    });
  }

  double getMainAxisSize() {
    return widget.direction == FillingSliderDirection.horizontal
        ? widget.width
        : widget.height;
  }

  Widget getHorizontal() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        updateData(details.localPosition.dx);
      },
      onHorizontalDragEnd: (details) {
        if (widget.onFinish != null) {
          widget.onFinish!(stateValue!);
        }
      },
      onTapUp: (details) {
        updateData(details.localPosition.dx);
        if (widget.onFinish != null) {
          widget.onFinish!(stateValue!);
        }
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  widget.color,
                  widget.fillColor
                ],
                stops: [
                  1 - stateValue!,
                  0,
                ]),
            borderRadius: BorderRadiusDirectional.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.child == null ? Container() : widget.child!,
            widget.childBuilder == null
                ? Container()
                : widget.childBuilder!(context, stateValue!),
            Padding(padding: EdgeInsets.only(right: 12))
          ],
        ),
      ),
    );
  }

  Widget getVertical() {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        updateData(details.localPosition.dy);
      },
      onVerticalDragEnd: (details) {
        if (widget.onFinish != null) {
          widget.onFinish!(stateValue!);
        }
      },
      onTapUp: (details) {
        updateData(details.localPosition.dy);
        if (widget.onFinish != null) {
          widget.onFinish!(stateValue!);
        }
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  widget.color,
                  widget.fillColor
                ],
                stops: [
                  1 - stateValue!,
                  0,
                ]),
            borderRadius: BorderRadiusDirectional.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.child == null ? Container() : widget.child!,
            widget.childBuilder == null
                ? Container()
                : widget.childBuilder!(context, stateValue!),
            Padding(padding: EdgeInsets.only(bottom: 12))
          ],
        ),
      ),
    );
  }
}
