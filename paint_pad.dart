/*
* NAME OF CODE ARTIFACT - paint_pad.dart
* BRIEF DESCRIPTION - Helps with the Game Page 
* PROGRAMMERS NAME - Jowaki Merani
* DATE CODE CREATED - October 1st, 2022
* DATE REVISED - February 23
                 Jowaki Merani - created pingpong game
* PRECONDITIONS - None
* POSTCONDITIONS - No return types
* ERROR AND EXCEPTION CONDITION: None
* SIDE EFFECTS: None
* INVARIANTS: None
* KNOWN FAULT - None
*/
import 'package:flutter/material.dart';
import 'homePage.dart';

void main() {
  runApp(MyPaint());
}

class MyPaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(
        email: '',
      ),
    );
  }
}
