import 'dart:async';

import 'package:flutter/material.dart';
import 'buttons.dart';
import 'character.dart';
import 'ball.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum BallDirection {
  BALLLEFT,
  BALLRIGHT,
}

class _HomeState extends State<Home> {
  static double characterX = 0;
  double lazerX = characterX;
  double lazerHeight = 15;
  bool isShooting = false;

  double ballX = 0.9;
  double ballY = 1;

  var balldirection = BallDirection.BALLLEFT;

  void moveRight() {
    setState(() {
      if (characterX + 0.1 > 1) {
        //on the edge of the screen
      } else {
        characterX += 0.1;
      }

      if (isShooting) {
        //laser should stay in the same position
      } else {
        lazerX = characterX;
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
      if (isShooting) {
        //laser should stay in the same position
      } else {
        lazerX = characterX;
      }
    });
  }

  void shoot() {
    if (!isShooting) {
      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        setState(() {
          isShooting = true;
          if (lazerHeight < MediaQuery.of(context).size.height * (3 / 4)) {
            lazerHeight += 10;
          } else {
            laserTurnOff();
            timer.cancel();
          }
        });
      });
    }
  }

  void laserTurnOff() {
    lazerHeight = 15.0;
    isShooting = false;
    lazerX = characterX;
  }

  void gameloop() {
    double height = 0;
    double time = 0;
    double velocity = 60;
    Timer.periodic(const Duration(milliseconds: 35), (timer) {
      setState(() {
        height = -5 * time * time + velocity * time;
        ballY = heightToY(height);

        if (ballY > 1) {
          time = 0;
        }

        if (ballX - 0.02 < -1) {
          balldirection = BallDirection.BALLRIGHT;
        }

        if (ballX + 0.02 > 1) {
          balldirection = BallDirection.BALLLEFT;
        }

        if (balldirection == BallDirection.BALLLEFT) {
          ballX -= 0.02;
        } else {
          ballX += 0.02;
        }

        time += 0.1;
      });
    });
  }

  double heightToY(double height) {
    double totalHeight = MediaQuery.of(context).size.height * (3 / 4);
    double Y = 1 - 2 * (height / totalHeight);
    return Y;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameloop,
      child: Column(
        children: [
          Expanded(
              //blue area
              flex: 3,
              child: Container(
                  color: Colors.blueAccent,
                  child: Stack(
                    children: [
                      Container(
                          alignment: Alignment(lazerX, 1),
                          child: Container(
                            color: Colors.red,
                            height: lazerHeight,
                            width: 5.0,
                          )),
                      Ball(
                        ballX: ballX,
                        ballY: ballY,
                      ),
                      Charecter(characterX: characterX),
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
      ),
    );
  }
}
