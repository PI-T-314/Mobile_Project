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

 enum BallDirection{
   BALLLEFT,
   BALLRIGHT,
  }

class _HomeState extends State<Home> {
  static double characterX = 0;
  double lazerX = characterX;
  double lazerHeight = 15;
  bool isShooting = false;
   
  double ballX=0.0;
  double ballY=0.0;
  
  var balldirection=BallDirection.BALLLEFT;
  
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
  void  gameloop(){
     Timer.periodic(const Duration(milliseconds: 35), (timer) {
      setState(() {
         if (ballX- 0.01 < -1) {
           balldirection= BallDirection.BALLRIGHT;
         }

         if (ballX + 0.01 > 1) {
          balldirection=BallDirection.BALLLEFT;
         }

        if(balldirection==BallDirection.BALLLEFT){
             ballX-=0.01;
        }else{
          ballX+=0.01;
        }
      });
     });
     
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: gameloop,
      child:Column(
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
                        
                        Ball(ballX: ballX,ballY: ballY,),
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


