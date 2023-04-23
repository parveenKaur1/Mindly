/*
* NAME OF CODE ARTIFACT - games_page.dart
* BRIEF DESCRIPTION - Helps with the bear jump  
* PROGRAMMERS NAME - Parveen Kaur
* DATE CODE CREATED - Feb 23
* DATE REVISED - February 23
                 Parveen - created bear Jump game
* KNOWN FAULT - None
*/
/*PRECONDITIONS: 
* input - true tap to begin game 
*/

/*POST CONDITIONS:
* return - the number of tapps that occured in the game 
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'bird.dart';
// import 'package:testgraph/bird.dart';

class MyGamePage extends StatefulWidget {
  const MyGamePage({Key? key}) : super(key: key); // constructor

  _GamePageState createState() => _GamePageState(); //extending stte constructor
}

class _GamePageState extends State<MyGamePage> {
  // extending state
  int count = 0; //count
  static double birdY = 0; // y coordinate
  double initialPos = birdY; // initial y position
  double height = 0; //height
  double time = 0; // time
  double gravity = -4.9; // how strong the gravity is
  double velocity = 3.5; // how strong the startGame is

  bool gameHasStarted = false; //game has started state

  static List<double> barrierX = [2, 2 + 1.5]; // barrier for x coordinate
  static double barrierWidth = 0.5; // out of 2
  List<List<double>> barrierHeight = [
    [0.6, 0.4], // barrier height
    [0.4, 0.6],
  ];

  void startGame() {
    gameHasStarted = true; // when game has started, set it to true
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // equation for the startGame using gravity
      height = gravity * time * time +
          velocity * time; // height  when game has started
      setState(() {
        birdY = initialPos - height; // subtracting makes the bird go higher
      });

      // check if bird is dead
      if (birdIsDead()) {
        timer.cancel(); // stop timer
        gameHasStarted = false; // game has ended
        _showDialog(); // call showDialog function
      }
      time += 0.01; // time has a 0.01 interval
    });
  }

  void resetGame() {
    // reset game
    Navigator.pop(context); // pop off by one state
    setState(() {
      // reset everything
      birdY = 0; // set coordinate to 0
      gameHasStarted = false; // game has ended
      time = 0; // reset time
      initialPos = birdY; // reset y coordinate
      count = 0; // set count to 0
    });
  }

  void _showDialog() {
    // dialog
    showDialog(
        // show this dialog when game is over
        context: context,
        barrierDismissible: false, // barrier
        builder: (BuildContext context) {
          return AlertDialog(
            // alerts
            backgroundColor: Colors.brown, //background of pop up brown
            title: Center(
              // center it
              child: Text(
                "G A M E  O V E R\nyour score was $count", // text to display
                style: TextStyle(color: Colors.white), // text color
              ),
            ),
            actions: [
              // actions to take
              GestureDetector(
                  // once gesture is detected
                  onTap: resetGame, // reset the game
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5), // border
                      child: Container(
                          //container
                          padding: EdgeInsets.all(7),
                          color: Colors.white, // text color
                          child: Text(
                            //text
                            'PLAY AGAIN',
                            style: TextStyle(
                                color: Colors.brown), // background color
                          ))))
            ],
          );
        });
  }

  void jump() {
    // jump
    time = 0; // time is 0
    count++; // jump counter
  }

  bool birdIsDead() {
    // is bird dead
    if (birdY < -1 || birdY > 1) {
      //if bird coordinate is such
      return true; // set to true
    }
    return false; // otherwise false
  }

  @override
  Widget build(BuildContext context) {
    // build
    return GestureDetector(
        // if gesture is detected
        onTap: gameHasStarted ? jump : startGame, // check if game has started
        child: Scaffold(
            appBar: AppBar(
              //creates the app bar at the top
              title: Text('MINDLY Tapping Game'), // page header
            ),
            body: Column(
              // column
              children: [
                Expanded(
                  flex:
                      3, // makes top container 3 times as big as the bottom container
                  child: Container(
                    color: Colors.blue, // top half of background
                    child: Center(
                        //center
                        child: Stack(
                      children: [
                        MyBird(birdY: birdY), // create a bird
                        Container(
                            alignment: Alignment(0, -0.5), // alignment
                            child: Text(
                              // text
                              gameHasStarted ? '' : 'T A P  T O  P L A Y',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20), // textstyle
                            ))
                      ],
                    )),
                  ),
                ),
                Expanded(
                  child: Container(
                    // other half set to brown
                    color: Colors.brown,
                  ),
                )
              ],
            )));
  }
}
