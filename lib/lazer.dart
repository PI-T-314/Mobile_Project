import 'package:flutter/material.dart';

class Lazer extends StatelessWidget {
  const Lazer({required this.lazerHeight, required this.lazerX, super.key});

  final double lazerX;
  final double lazerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(lazerX, 1),
        child: Container(
          color: Colors.red,
          height: lazerHeight,
          width: 5.0,
        ));
  }
}
