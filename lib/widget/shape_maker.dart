import 'package:flutter/widgets.dart';

class ShapeMaker extends StatelessWidget {
  const ShapeMaker(
      {super.key,
      this.top,
      this.bottom,
      this.left,
      this.right,
      required this.height,
      required this.width,
      required this.color,
       this.shape =BoxShape.rectangle
      });

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double height;
  final double width;
  final Color color;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        right: right,
        left: left,
        bottom: bottom,
        height: height,
        width: width,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: shape
          ),
        ),);
  }
}
