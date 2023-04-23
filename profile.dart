/*
* NAME OF CODE ARTIFACT - profile.dart
* BRIEF DESCRIPTION - This is the page that retreves data from the db 
* PROGRAMMERS NAME - Jowaki Merani
* DATE CODE CREATED - Nov 19th, 2022
* DATE REVISED - Nov 19th  
                 Jowaki Merani - abe to retreve data and print to terminal 
*               Jan 28th 
                Jowaki Merani - reformatted the data to provide a better UI
                March 9th
                Parveen Kaur - fix navigation between pages
* PRECONDITIONS: NONE - requires no user input because it only displays information. 
 Takes in email as a parameter internally and uses that o produce information
* POSTCONDITIONS: Displays information based on the email received internally by accessing database
* ERRORS AND EXCEPTIONS: NONE
* Side EFFECTS: NONE
* INVARIANTS: NONE
* KNOWN FAULT - None
*/
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/games/games_meanu_pg.dart';
import 'package:flutter_application_1/music/music_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
// import 'package:mongo_dart/mongo_dart.dart';
import '../animal/animal.dart';
import '../constant.dart';
import '../resources/ResourcePg.dart';
import 'editProfile_page.dart';
import '../DemoApp.dart';
import '../journal_page.dart';

//profile page initiator
class Profile_pg extends StatefulWidget {
  String email;
  String password;
  String name;
  String happinessScale;
  //takes in 4 parameters about users information
  Profile_pg(
      {required this.email,
      required this.password,
      required this.name,
      required this.happinessScale});

  @override
  //constructor
  _Profile_pgState createState() => _Profile_pgState(
      email: '$email',
      password: '${password}',
      name: '${name}',
      happinessScale: '${happinessScale}');
}

// gets called to display the information based on the parameters
class _Profile_pgState extends State<Profile_pg> {
  // MaterialColor backgroundColor;
  String email;
  String password;
  String name;
  String happinessScale;
  //constructor
  _Profile_pgState(
      {required this.email,
      required this.password,
      required this.name,
      required this.happinessScale});

  get static => null;
  var temp;
  late final validMap;
  late final List transfer = []; //create a list
  // ignore: prefer_typing_uninitialized_variables
  // var temp;

  // get red => null;
  // var finalemail;
  // var password;
  // var name;
  @override
  Widget build(BuildContext context) {
    print('object ${email}');
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        // what the page will contain. returns the content below.
        home: Scaffold(

            // home page is set.
            //bottom bar to navigate through pages
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
              title: Text('MINDLY'),

              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        // if tapped, go to this page
                        builder: (context) => EditProfileUI(
                            email: ('$email'),
                            password: ('${password}'),
                            name: ('${name}'),
                            happinessScale: ('$happinessScale'))));
                    // do something
                  },
                ),
              ],
            ),
            backgroundColor: Color.fromARGB(
                255, 172, 212, 245), // background color of the main page
            body: Stack(children: [
              Container(
                child: Center(
                  //center it and stack them
                  child: Column(
                    children: [
                      Container(
                          //container properties
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border:
                                  // this is to create the image
                                  Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              //shape of box which is circle
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                //image from network
                                image: NetworkImage(
                                    'https://as2.ftcdn.net/v2/jpg/05/48/94/67/1000_F_548946790_ipaWsWpiJO5XLnkNLIAd4w18ES4pPIke.jpg'),
                              ))),
                      NameCard(),
                      EmailCard(),
                      PasswordCard(),

                      //position of the box for small edit icon image
                    ],
                  ),
                ),
              ),
            ])));
  }

  Widget NameCard() {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(children: [
        Text(
          "Name: ${name}",
          style: TextStyle(fontSize: 30),
        ),
      ]),
      color: Colors.blue[300],
    );
  }

  Widget EmailCard() {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(children: [
        Text(
          "Email: ${email}",
          style: TextStyle(fontSize: 30),
        ),
      ]),
      color: Colors.blue[300],
    );
  }

  Widget PasswordCard() {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(children: [
        Text(
          "Password: ******** ",
          style: TextStyle(fontSize: 30),
        ),
      ]),
      color: Colors.blue[300],
    );
  }
}
