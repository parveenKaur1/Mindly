// /*
// * NAME OF CODE ARTIFACT - games_meanu_pg.dart
// * BRIEF DESCRIPTION - This creates the frontend settings page
// * PROGRAMMERS NAME - Jowaki Merani
// * DATE CODE CREATED - February 23 2023
// * DATE REVISED - March 9th
//  Parveen Kaur - added proper navigation between pages
// Jui Nagarkar - added the comments according to the final sprint requirements
//* PRECONDITIONS - No input values or types needed
//* POSTCONDITIONS - No return types
//* ERROR AND EXCEPTION CONDITION: None
//* SIDE EFFECTS: None
//* INVARIANTS: None
//* KNOWN FAULTS - None
// */

import 'package:flutter/material.dart';
import 'package:flutter_application_1/personal%20details/profile.dart';

import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart' as mongo;
// import 'package:mongo_dart/mongo_dart.dart';
import '../DemoApp.dart';
import '../animal/animal.dart';
import '../constant.dart';
import '../journal_page.dart';
import '../music/music_page.dart';
import '../resources/ResourcePg.dart';
import '../word_game.dart';

class MyGame_Meanu extends StatelessWidget {
  @override
  String email;
  String happinessScale;
  MyGame_Meanu({required this.email, required this.happinessScale});
  Widget build(BuildContext context) {
    // build page
    return Scaffold(
        backgroundColor:
            Color.fromARGB(255, 172, 212, 245), //page background color
        //bottom bar for navigation between pages
        bottomNavigationBar: BottomAppBar(
            color: Colors.blue,
            child: Row(
              children: <Widget>[
                IconButton(
                  // button
                  // mainAxisAlignment: MainAxisAlignment.center,
                  icon: Image.asset('assets/game.png'), //image
                  iconSize: 50, //size
                  onPressed: () {
                    //functionality
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyGame_Meanu(
                            email: ('${email}'),
                            happinessScale: ('$happinessScale'))));
                  },
                ),
                IconButton(
                  // button
                  // mainAxisAlignment: MainAxisAlignment.center,
                  icon: Image.asset('assets/journal.png'), //image
                  iconSize: 50, //size
                  onPressed: () {
                    //functionality
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyJournal(
                            email: ('${email}'),
                            happinessScale: ('$happinessScale'))));
                  },
                ),
                IconButton(
                  //button
                  // mainAxisAlignment: MainAxisAlignment.center,
                  icon: Image.asset('assets/home.png'), //image
                  iconSize: 50, //size
                  onPressed: () {
                    // if tapped, go to this page
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DemoApp(
                            email: ('$email'),
                            happinessScale: ('$happinessScale'))));
                    //functionality
                    // Navigator.pushNamed(context, 'home_page');
                  },
                ),
                IconButton(
                  // Icon buttom
                  // mainAxisAlignment: MainAxisAlignment.center,
                  icon: Image.asset('assets/music.png'), //image
                  iconSize: 50, //size
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        // if tapped, go to this page
                        builder: (context) => MyMusic(
                            email: ('$email'),
                            happinessScale: ('$happinessScale'))));
                  }, //functionality
                ),
                IconButton(
                  tooltip: 'Open navigation menu',
                  icon: Image.asset('assets/info.png'), //image
                  iconSize: 50, //size
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        // if tapped, go to this page
                        builder: (context) => Resources(
                            email: ('$email'),
                            happinessScale: ('$happinessScale'))));
                    //functionality
                  },
                ),
                IconButton(
                  // Icon buttom
                  // mainAxisAlignment: MainAxisAlignment.center,
                  icon: Image.asset('assets/animal.png'), //image
                  iconSize: 50, //size
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        // if tapped, go to this page
                        builder: (context) => MyAnimal(
                            email: ('$email'),
                            happinessScale: ('$happinessScale'))));
                  }, //functionality
                ),
              ],
            )),
        appBar: AppBar(
          // title of app
          title: Text("Games", style: TextStyle(fontSize: 22)),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            // body of the page
            padding: const EdgeInsets.all(10), // padding
            child: ListView(
              // page view
              children: [
                SizedBox(height: 40), // size of box
                Row(
                  children: [
                    Icon(
                      //title of a part of the page with image
                      Icons.person,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Text("Games", // title
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
                Divider(
                    height: 20,
                    thickness: 1), // a divider between title and contents
                SizedBox(height: 10),
                BearJump(context, "Bear Jump"), // contents
                PingPong(context, "Ping Pong"), //contents
                GameForWord(context, "Word Game")
                // Reminders(context, "Set Daily Reminders"), //contents
              ],
            )));
  }

  GestureDetector BearJump(BuildContext context, String title) {
    // for graph
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              context, 'tap_game'); // if tapped, go to next page
        },
        child: Padding(
          //padding
          padding: const EdgeInsets.symmetric(
              vertical: 8, horizontal: 20), // padding details
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //alignment
            Text(title, // title
                style: TextStyle(
                    // text style/ aesthetic
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Icon(Icons.arrow_forward, color: Colors.black) // type of arrow
          ]),
        ));
  }

  GestureDetector PingPong(BuildContext context, String title) {
    // for reminders
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              context, 'ping_pong'); // if tapped go to reminders page
        },
        child: Padding(
          //padding
          padding: const EdgeInsets.symmetric(
              vertical: 8, horizontal: 20), //padding details
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //alignment
            Text(title, // text and its type
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Icon(Icons.arrow_forward, color: Colors.black) // type of arrow
          ]),
        ));
  }

  GestureDetector GameForWord(BuildContext context, String title) {
    // for reminders
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => wordGame()));
          // if tapped go to reminders page
        },
        child: Padding(
          //padding
          padding: const EdgeInsets.symmetric(
              vertical: 8, horizontal: 20), //padding details
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //alignment
            Text(title, // text and its type
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Icon(Icons.arrow_forward, color: Colors.black) // type of arrow
          ]),
        ));
  }
}
