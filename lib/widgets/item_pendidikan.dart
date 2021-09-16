import 'package:flutter/material.dart';

class ItemPendidikan extends StatelessWidget {
  final double padding;
  final String dataKey;
  final String value;

  ItemPendidikan({ required this.padding, required this.dataKey, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dataKey, style: TextStyle(color: Colors.grey, fontSize: 15)),
        Padding(padding: EdgeInsets.symmetric(horizontal: padding)),
        Text(value, style: TextStyle(fontSize: 15),)
      ],
    );
  }
}
