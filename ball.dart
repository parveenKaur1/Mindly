/*
* NAME OF CODE ARTIFACT - brick.dart
* BRIEF DESCRIPTION - Helps with the Game Page 
* PROGRAMMERS NAME - Jowaki Merani
* DATE CODE CREATED - Feb 23
* DATE REVISED - February 23
                 Jowaki Merani - created ball fro pingpong game game
* KNOWN FAULT - None
*/

/*PRECONDITIONS: 
* This file dose not take any input it is a constant value - 
* its a physical description and edditing of the ball 
*/

/*POST CONDITIONS:
* a ball is displayed across the screen that travells in a predesigned path
* return values - None
*/

import 'package:flutter/material.dart';


class Ball extends StatelessWidget {
  final x;
  final y;
  Ball(this.x, this.y);

  @override
  Widget build(BuildContext context) {//physical aspects of ball described 
    return Container(
      alignment: Alignment(x, y),

      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        width: 20,
        height: 20,
      ),
    );
  }
}