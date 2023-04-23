/*
* NAME OF CODE ARTIFACT - music_page.dart
* BRIEF DESCRIPTION - - This creates the frontend of the music page
* PROGRAMMERS NAME - Parveen Kaur 
* DATE CODE CREATED - November 30th 2022
* DATE REVISED - March 9th
                 Parveen Kaur - added proper navigation between pages
               - April 23rd
                 Jui Nagarkar - added the comments according to the final sprint requirements   
* PRECONDITIONS - No input values or types needed, the music automatically plays when the play button is pressed
* POSTCONDITIONS - No return types
* ERROR AND EXCEPTION CONDITION: None
* SIDE EFFECTS: None
* INVARIANTS: None
* KNOWN FAULTS - None  
*/

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../DemoApp.dart';
import '../animal/animal.dart';
import '../games/games_meanu_pg.dart';
import '../journal_page.dart';
import '../resources/ResourcePg.dart';

class MyMusic extends StatefulWidget {
  //class for the login landing page.
  String email = "";
  String happinessScale;

  MyMusic(
      {required this.email,
      required this.happinessScale}); // constructor for log in page.

  @override
  _MyMusicState createState() => _MyMusicState(
      email: "$email", happinessScale: "$happinessScale"); //creates login page.
}

class _MyMusicState extends State<MyMusic> {
  String email;
  String happinessScale;
  _MyMusicState({required this.email, required this.happinessScale});
  Widget build(BuildContext context) {
    String appTitle = "Mindly Music Page";
    return Container(
      // container widget. What the page is going to contain.

      child: Scaffold(
        //bottombar for navigation of pages
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
          //app bar widget.
          title: Text(appTitle), // title of the app bar.
        ),
        // defining the background.
        backgroundColor:
            Colors.blue, // background color of the page. Currently set to
        body: Stack(children: [
          const Text(
            // creates a textfield
            "\n", //text
            style: TextStyle(
              // the style for the text
              color: Colors.white, // color it white
              fontSize: 33, // font size
            ),
          ),
          SingleChildScrollView(
            // allows the user to scroll down if the information can't fit in the background.

            child: Container(
              // child widget for the scroll views.
              padding: const EdgeInsets.only(
                right: 35, // distance from the right
                top: 20,
                left: 35, // distance from the left
                bottom: 180, // distance from the bottom
              ), //MediaQuery.of(context).size.height *
              //0.5), //allows the upcoming text to be centered.

              child: Column(children: [
                ElevatedButton.icon(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  icon: Image.asset('assets/play.png'), //image
                  onPressed: () async {
                    Navigator.pushNamed(context, 'play_page');

                    // final player = AudioCache();
                    // player.play('testAudio.mp3');
                  },
                  label: const Text("Tune 1: Song Name"), //button label
                ),
                const Text("\n"),
                ElevatedButton.icon(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  icon: Image.asset('assets/play.png'), //image
                  onPressed: () {
                    //functionality
                  },
                  label: const Text("Tune 2: Song Name"), //button label
                ),
                const Text("\n"),
                ElevatedButton.icon(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  icon: Image.asset('assets/play.png'), //image
                  onPressed: () {
                    //functionality
                  },
                  label: const Text("Tune 3: Song Name"), //button label
                ),
                const Text("\n"),
                Row(
                    //row widget.

                    ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
