import 'package:flutter/material.dart';
class DividerLine extends StatelessWidget {
  final double height;
  final double padding;
  final Color color;
  DividerLine({ required this.height, required this.padding, required this.color });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        height: height,
        color: color,
      ),
    );
  }
}