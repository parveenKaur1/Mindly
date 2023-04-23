/*
* NAME OF CODE ARTIFACT - homePage.dart
* BRIEF DESCRIPTION - Helps with the Game Page 
* PROGRAMMERS NAME - Jowaki Merani
* DATE CODE CREATED - October 1st, 2022
* DATE REVISED - February 23
                 Jowaki Merani - created pingpong game
                 
* KNOWN FAULT - None
*/

/*PRECONDITIONS: 
* This file is the main game play aspect of the ping pong game - it makes sure that the user decided to start the game by taking an input value
* of  true or false to begin the game 
* it uses the ball and brick files to display and move the ball and brick on this page 
*/

/*POST CONDITIONS:
* the ball is either hit by the brick or it misses the brick causing the game to terminate 
* on tremination the controll asks if teh user wishes to play again. 
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ball.dart';
import 'brick.dart';
import 'games_meanu_pg.dart';
import 'welcomeScreen.dart';

//This helps transfer all required info through the application 
class HomePage extends StatefulWidget {
  @override
  String email = "";
  HomePage({required this.email});
  _HomePageState createState() => _HomePageState(email: '$email');
}

//declare variable to manage direction of teh ball and bar 
enum direction { UP, DOWN, LEFT, RIGHT }

//declare a class to deal with game play 
class _HomePageState extends State<HomePage> {
  String email = "";
  _HomePageState({required this.email});
  //LOGIC
  //player variations
  double playerX = -0.2;
  double brickWidth = 0.4;
  int playerScore = 0;
  // enemy variable
  double enemyX = -0.2;
  int enemyScore = 0;
  //ball
  double ballx = 0;
  double bally = 0;

  //ball direction
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.RIGHT;
  bool gameStarted = false;
  //star game? true or false based on user input 
  void startGame() {
    gameStarted = true;
    //speed of the game 
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      //call functions for diffrent functionality 
      updatedDirection();

      moveBall();

      moveEnemy();
      //making sure the ball hit plank and not dead - for player 
      if (isPlayerDead()) {
        enemyScore++;
        timer.cancel();
        _showDialog(false);
        // resetGame();
      }
      //making sure the ball hit plank and not dead - for enemy 
      if (isEnemyDead()) {
        playerScore++;
        timer.cancel();
        _showDialog(true);
        // resetGame();
      }
    });
  
  }

//check for dead 
  bool isEnemyDead() {
    if (bally <= -1) {
      return true;
    }
    return false;
  }

//make bar move for the enemy 
  void moveEnemy() {
    setState(() {
      enemyX = ballx;
    });
  }

//in the event of game end - display who won and ask if they wish to play again 
  void _showDialog(bool enemyDied) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog - the promt for the winner and if they wish to continue 
          return AlertDialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.purple,
            title: Center(
              child: Text(
                //chk for dead enemy and print who wins accordingly 
                enemyDied ? "Pink Wins" : "Purple Wins",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(//detect gestures from the screen to move bar of player 
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.purple[100],
                      child: Text(//chk if button for play again was hit 
                        "Play Again",
                        style: TextStyle(
                            color: enemyDied
                                ? Colors.pink[300]
                                : Colors.purple[000]),
                      )),
                ),
              ),

              ///deals with the exit button - exit teh pingpong game and return to games page 
              GestureDetector(
                onTap: () => {Navigator.pop(context), Navigator.pop(context)},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.purple[100],
                      child: Text(
                        "Exit",
                        style: TextStyle(
                            color: enemyDied
                                ? Colors.pink[300]
                                : Colors.purple[000]),
                      )),
                ),
              )
            ],
          );
        });
  }

//ability to restart game 
  void resetGame() {
    Navigator.pop(context);
    setState(() {
      gameStarted = false;
      ballx = 0;
      bally = 0;
      playerX = -0.2;
      enemyX = -0.2;
    });
  }
//chk for dead player 
  bool isPlayerDead() {
    if (bally >= 1) {
      return true;
    }
    return false;
  }
//continuously update direction of teh ball movement 
  void updatedDirection() {
    setState(() {
      //update vertical dirction
      if (bally >= 0.9 && playerX + brickWidth >= ballx && playerX <= ballx) {
        ballYDirection = direction.UP;
      } else if (bally <= -0.9) {
        ballYDirection = direction.DOWN;
      }
      // ipdate horizontal directions
      if (ballx >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballx <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

//deal with vertical movements of teh ball 
  void moveBall() {
    //vertical movement
    setState(() {
      if (ballYDirection == direction.DOWN) {
        bally += 0.01;
      } else if (ballYDirection == direction.UP) {
        bally -= 0.01;
      }
    });
    //horizontal movement
    setState(() {
      if (ballXDirection == direction.LEFT) {
        ballx -= 0.01;
      } else if (ballXDirection == direction.RIGHT) {
        ballx += 0.01;
      }
    });
  }
//deal with left move and chk for end of screen 
  void moveLeft() {
    setState(() {
      if (!(playerX - 0.1 <= -1)) {
        playerX -= 0.1;
      }
    });
  }
//deal with right move and chk for end of screen 
  void moveRight() {
    if (!(playerX + brickWidth >= 1)) {
      playerX += 0.1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // appBar:
//detect posible inputs from the keyboard 
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
              child: Stack(
            children: [
              Welcome(gameStarted),

              //top brick
              Brick(enemyX, -0.9, brickWidth, true),
              //scoreboard
              Score(gameStarted, enemyScore, playerScore),
              // ball
              Ball(ballx, bally),
              // //bottom brick
              Brick(playerX, 0.9, brickWidth, false)
            ],
          )),
          appBar: AppBar(
            title: const Text("Mindly Ping-Pong"),
            automaticallyImplyLeading: true,
          ),
        ),
      ),
    );
  }
}

//provide final score based on teh number of time winner hit ball 
class Score extends StatelessWidget {
  final gameStarted;
  final enemyScore;
  final playerScore;
  Score(
    this.gameStarted,
    this.enemyScore,
    this.playerScore,
  );

  @override
  Widget build(BuildContext context) {
    return gameStarted//formatting the movement of teh ball once game begins 
        ? Stack(children: [
            Container(
                alignment: Alignment(0, 0),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.grey[800],
                )),
            Container(
                alignment: Alignment(0, -0.3),
                child: Text(
                  enemyScore.toString(),
                  style: TextStyle(color: Colors.grey[800], fontSize: 100),
                )),
            Container(
                alignment: Alignment(0, 0.3),
                child: Text(
                  playerScore.toString(),
                  style: TextStyle(color: Colors.grey[800], fontSize: 100),
                )),
          ])
        : Container();
  }
}
