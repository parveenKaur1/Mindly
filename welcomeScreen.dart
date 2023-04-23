/*
* NAME OF CODE ARTIFACT - welcomeScreen.dart
* BRIEF DESCRIPTION - Helps with the Game Page welcome page
* PROGRAMMERS NAME - Jowaki Merani
* DATE CODE CREATED - February 23
* DATE REVISED - February 23
                 Jowaki Merani - created pingpong game
* KNOWN FAULT - None
*/

/*PRECONDITIONS: 
* This file is the initial file that displays the game
* It takes in a tap to detremine the start of the game and call the other respective functions to initiate game play
*/

/*POST CONDITIONS:
* It returns True / False based on whether the game is started or not
* 
*/
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
 
  final bool gameStarted;
  Welcome(this.gameStarted);//chk if game started - pass appropriate variable 

  @override
  Widget build(BuildContext context) {
    return Container(//container to chk for game begining 
        alignment: Alignment(0, -0.2),
        child: Text(
         gameStarted ? "": "T A P   T O   P L A Y",
          style: TextStyle(color: Colors.white),
        ));
  }
}