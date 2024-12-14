import 'package:flutter/material.dart';

class PlayerBox extends StatelessWidget {
  const PlayerBox({super.key, required this.boxColor, required this.borderColor, required this.playerNumber, required this.elevation});

  final Color boxColor;
  final Color borderColor;
  final int playerNumber;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shadowColor: boxColor,
      child: Container(
        decoration: BoxDecoration(
          color: boxColor,
          border: Border.all(
            color: borderColor,
            width: 3,
          )
        ),
        width: 150,
        height: 160,
        child: Center(
          child: Text('Player $playerNumber', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
        ),
      ),
    );
  }
}

