import 'package:flutter/material.dart';

class TitleTheme extends StatelessWidget {
  final String title;
  final double fontSize;
  TitleTheme({ required this.title, required this.fontSize });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
