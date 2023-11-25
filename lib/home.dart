import 'dart:async';
import 'dart:math';

import 'lazer.dart';
import 'startgame.dart';
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
  bool isDead = false;
  bool gameStarted = false;
  int score = 0;

  double ballX = 0.9;
  double ballY = 1;

  var balldirection = BallDirection.BALLLEFT;

  void moveRight() {
      if (characterX + 0.1 > 1) {
        //on the edge of the screen
      } else {
        characterX += 0.1;
      }

      if (isShooting) {
        //lazer should stay in the same position
      } else {
        lazerX = characterX;
      }
  }

  void moveLeft() {
      if (characterX - 0.1 < -1) {
        //on the edge of the screen
      } else {
        characterX -= 0.1;
      }
      if (isShooting) {
        //lazer should stay in the same position
      } else {
        lazerX = characterX;
      }
  }

  //funtions that tracks shootig
  void shoot() {
    if (!isShooting) {
      Timer.periodic(const Duration(milliseconds: 20), (timer) {
          isShooting = true;
          //if lazer height less than the height of the screen (multiplied by 3/4 since we used expanded and the blue area is 3/4 parts of the screen), else it resets the lazer
          if (lazerHeight < MediaQuery.of(context).size.height * (3 / 4)) {
            lazerHeight += 10;
          } else {
            lazerTurnOff();
            timer.cancel();
          }
          //tracks if the lazer hits the ball, if it does it teleports the ball out of the screen in a random direction and sets its direction to the opposite part
          if (ballY > heightToY(lazerHeight) && (ballX - lazerX).abs() < 0.03) {
            timer.cancel();
            respawnBall();
          }
      });
    }
  }

  void respawnBall() {
    lazerTurnOff();
    score++;
    Random random = Random();
    double choice = (random.nextDouble() * 2) - 1;
    if (choice > 0) {
      ballX = 2;
      balldirection = BallDirection.BALLLEFT;
    } else {
      ballX = -2;
      balldirection = BallDirection.BALLRIGHT;
    }
  }

//resets lazer
  void lazerTurnOff() {
    lazerHeight = 15.0;
    isShooting = false;
    lazerX = characterX;
  }

//tracks the ball movement
  Future<void> gameLoop() async {
    if (!gameStarted) {
      gameStarted = true;
      double height = 0;
      double time = 0;
      double velocity = 65;
      Timer.periodic(const Duration(milliseconds: 30), (timer) {
        //inverse quadratic formula that allows the ball to jump in the shown trajectory (as earth's gravity)
        height = -5 * time * time + velocity * time;
        setState(() {
          ballY = heightToY(height);
        });

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
        //checks if the character has died (if ball hits character)
        isDeadCheck();
        if (isDead) {
          timer.cancel();
          _showDeathScreen();
        }

        time += 0.15;
      });
    }
  }

  void _showDeathScreen() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[600],
            title: Center(
              child: Text(
                'You FAILED!!!!\n Your Score: $score',
                style: const TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
            actions: [
              Center(child: Button(icon: Icons.replay, function: restartGame))
            ],
          );
        });
  }

//takes the height and returns the position on the y axis
  double heightToY(double height) {
    double totalHeight = MediaQuery.of(context).size.height * (3 / 4);
    double Y = 1 - 2 * (height / totalHeight); // gets the proportion of the screen that the height is at vertically and multiplies it by 2 since the screen range is from -1 to 1
    return Y;
  }

  void isDeadCheck() {
    if ((ballX - characterX).abs() < 0.12 && (ballY - 1).abs() < 0.145) {
      isDead = true;
    } else {
      isDead = false;
    }
  }

//resets everything back to its original value
  void restartGame() {
    characterX = 0;
    lazerX = characterX;
    lazerHeight = 15;
    isShooting = false;
    score = 0;

    ballX = 0.9;
    ballY = 1;
    isDead = false;
    Navigator.pop(context);//removes the retry screen
    gameStarted = false;
    gameLoop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameLoop,
      child: Column(
        children: [
          Expanded(
              //blue area
              flex: 3,
              child: Container(
                  color: Colors.blueAccent,
                  child: Stack(
                    children: [
                      StartGame(gameStarted: gameStarted),
                      Lazer(
                        lazerX: lazerX,
                        lazerHeight: lazerHeight,
                      ),
                      Ball(
                        ballX: ballX,
                        ballY: ballY,
                      ),
                      Charecter(characterX: characterX),
                      Container(
                        alignment: const Alignment(0, -1),
                        child: Text(
                          '$score',
                          style: const TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none),
                        ),
                      ),
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
