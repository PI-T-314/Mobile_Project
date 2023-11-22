import 'package:flutter/material.dart';

class Charecter extends StatelessWidget {
  const Charecter({required this.characterX, super.key});

  final double characterX;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(characterX, 1),
        child: SizedBox(
          
          height: 54.0,
          width: 75.0,
           child: Image.asset('assets/images/failingsituation.jpeg', fit: BoxFit.fill,),
        ));
  }
}
