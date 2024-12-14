import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  Box({super.key, required this.boxColor, required this.onPressed , required this.playerSymbol});

  final Color boxColor;
  final VoidCallback onPressed;
  final String playerSymbol;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: boxColor,
        child: Center(child:
        Text(playerSymbol,
          style: TextStyle(fontSize: 65),)),
      ),
    );
  }
}
