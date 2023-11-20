import 'package:flutter/material.dart';

class Charecter extends StatelessWidget {
  const Charecter({required this.characterX, super.key});

  final double characterX;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(characterX, 1),
        child: Container(
          color: Colors.yellow,
          height: 50.0,
          width: 50.0,
        ));
  }
}
