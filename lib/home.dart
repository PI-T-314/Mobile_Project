import 'package:flutter/material.dart';
import 'buttons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void moveForward(){

  }
  void moveBackward(){

  }
  void shoot(){

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
            child: Container(
          color: Colors.blueAccent,
        )
        ),
        Expanded(child: Container(
          color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(icon: Icons.navigate_before, function: moveForward),
                Button(icon: Icons.barcode_reader, function: shoot),
                Button(icon: Icons.navigate_next, function: moveBackward),
              ],
            ),
        ))
      ],
    );
  }
}
