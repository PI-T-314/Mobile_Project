import 'package:flutter/material.dart';
import 'buttons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double characterX = 0;

  void moveRight() {
    setState(() {
      if (characterX + 0.1 > 1) {
        //on the edge of the screen
      } else {
        characterX += 0.1;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (characterX - 0.1 < -1) {
        //on the edge of the screen
      } else {
        characterX -= 0.1;
      }
    });
  }

  void shoot() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            //blue area
            flex: 3,
            child: Container(
                color: Colors.blueAccent,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment(characterX, 1),
                      child: Container(
                        color: Colors.yellow,
                        height: 50.0,
                        width: 50.0,
                      ),
                    )
                  ],
                ))),
        Expanded(
            //grey area
            child: Container(
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(icon: Icons.navigate_before, function: moveLeft),
              Button(icon: Icons.barcode_reader, function: shoot),
              Button(icon: Icons.navigate_next, function: moveRight),
            ],
          ),
        ))
      ],
    );
  }
}
