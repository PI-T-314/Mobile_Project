import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({required this.ballX, required this.ballY, super.key});

  final double ballX;
  final double ballY;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(ballX, ballY),
        child: Container(
          width: 22.0,
          height: 22.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.pink,
          ),
        ));
  }
}
