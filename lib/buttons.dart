import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({required this.icon, required this.function, super.key});

  final IconData icon;

  final VoidCallback  function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: function,
        child: Icon(icon, size: 50,)
    );
  }
}
