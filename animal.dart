/*
* NAME OF CODE ARTIFACT - animal.dart
* BRIEF DESCRIPTION - Implimented animal page 
* PROGRAMMERS NAME - Jowaki Merani
* DATE CODE CREATED - Feb 23
* DATE REVISED - February 23
                 Jowaki Merani - merged animal for feelings animal 
                 March 9th
                 Parveen Kaur - added proper navigation between pages
* KNOWN FAULT - None
*/
import 'package:flutter/material.dart';
// import 'package:flare_flutter/flare_actor.dart';
import 'package:rive/rive.dart';

import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/journal_page.dart';
import 'package:flutter_application_1/personal%20details/profileMenu_page.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:rive/rive.dart';

import '../DemoApp.dart';
import '../games/games_meanu_pg.dart';
import '../music/music_page.dart';
import '../resources/ResourcePg.dart';


 void main()async {
  
}
class MyAnimal extends StatefulWidget {
  String email;
  String happinessScale;
  // double n =0; 
  MyAnimal({required this.email, required this.happinessScale});
  @override

//create a state for the animal to be displayed 
  _MyAnimalState createState() => _MyAnimalState(email: '$email', happinessScale: '$happinessScale');
}

class _MyAnimalState extends State<MyAnimal> {
  String email;
  String happinessScale;
  _MyAnimalState({required this.email, required this.happinessScale});
  @override
  Widget build(BuildContext context){

   String animationName;//success,idle,fail
   int n = int.parse(happinessScale);//detremine teh feeling based on the sum of the answers form teh chec in quiz 
  // int n =90;
    if (n > 80 && n < 100) {
      animationName = "success";//happy 
    } else if (n >= 50 && n <= 80) {
      animationName = "idle";//casual
    } else {
      animationName = "fail";//sad
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 172, 212, 245),
      // the bottom bar for navigation between pages
      bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Row(
            children: <Widget>[
              
              IconButton(//the main navigation bar displayed for game page 

                // button
                // mainAxisAlignment: MainAxisAlignment.center,
                icon: Image.asset('assets/game.png'), //image
                iconSize: 50, //size
                onPressed: () {
                  //functionality
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyGame_Meanu(
                            email: ('${email}'),
                            happinessScale: ('$happinessScale')
                          )));
                },
              ),
              IconButton(//the main navigation bar displayed for journal page 
            
                
                icon: Image.asset('assets/journal.png'), //image
                iconSize: 50, //size
                onPressed: () {
                  //functionality
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyJournal(
                            email: ('${email}'),
                            happinessScale: ('$happinessScale')
                          )));
                },
              ),
              IconButton(//the main navigation bar displayed for home page 
              
                
                icon: Image.asset('assets/home.png'), //image
                iconSize: 50, //size
                onPressed: () {
                  // if tapped, go to this page
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DemoApp(
                            email: ('$email'),
                            happinessScale: ('$happinessScale')
                          )));
                  
                },
              ),
              IconButton(//the main navigation bar displayed for music page 
           
                
                icon: Image.asset('assets/music.png'), //image
                iconSize: 50, //size
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      // if tapped, go to this page
                      builder: (context) => MyMusic(
                            email: ('$email'),
                            happinessScale: ('$happinessScale')
                          )));
                }, //functionality
              ),
              IconButton(//the main navigation bar displayed for info page 
                tooltip: 'Open navigation menu',
                icon: Image.asset('assets/info.png'), //image
                iconSize: 50, //size
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      // if tapped, go to this page
                      builder: (context) => Resources(
                            email: ('$email'),
                            happinessScale: ('$happinessScale')
                          )));

                  //functionality
                },
              ),
              IconButton(//pass the required values form page to page 
                
                icon: Image.asset('assets/animal.png'), //image
                iconSize: 50, //size
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      // if tapped, go to this page
                      builder: (context) => MyAnimal(
                            email: ('$email'),
                            happinessScale: ('$happinessScale')
                          )));
                }, //functionality
              ),
            ],
          )),
      body: Container(//display the animal that was animated in rive 
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 700,
                height: 300,
                child: RiveAnimation.asset(
                  "assets/bear.riv",
                  //test, success,idle,fail
                  // animation: "fail",
                  animations: [animationName],//select animation based on provided feeling/ check in page 
                  // controllers: [[]{}],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
