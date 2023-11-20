import 'package:flutter/material.dart';

class StartGame extends StatelessWidget {
  const StartGame({required this.gameStarted, super.key});

  final bool gameStarted;

  @override
  Widget build(BuildContext context) {
    return gameStarted
        ? Container()
        : Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.grey,
                child: const Text(
                  "Tap To Start",
                  style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none,),
                ),
              ),
            ));
  }
}
