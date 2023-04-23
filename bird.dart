/*This page helps create the bear as animal that is jumping in the tapping game 
# NAME OF CODE ARTIFACT - bird.dart
# BRIEF DESCRIPTION - this is the animal for the taping game
# PROGRAMMERS NAME - Parveen Kaur
# DATE CODE CREATED - October 19, 2022
# KNOWN FALUTS - None 
# DATE REVISED - October 20 2022
#                    Parveen Kaur - edditing for the animal      
# 
*/

/*PRECONDITIONS: 
* input - none
*/

/*POST CONDITIONS:
* return - the animal that will bounce in the game 
*/

import 'package:flutter/material.dart';

class MyBird extends StatelessWidget { // creating the bird
  final birdY;// y coordinate 
  MyBird({this.birdY}); // constructor

  Widget build(BuildContext context) { // building the bird
    return Container( // container
      alignment: Alignment(0, birdY), // align the bird
      child: Image.asset( // image for bird
        'assets/bear.png',// image
        width: 90,// size
      ),
    );
  }
}
