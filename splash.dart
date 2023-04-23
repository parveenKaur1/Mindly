/*
* NAME OF CODE ARTIFACT - splash.dart
* BRIEF DESCRIPTION - This is the splash screen between the login and the quiz 
* PROGRAMMERS NAME - Parveen Kaur
* DATE CODE CREATED - April 18th 2023
* DATE REVISED - 
* PRECONDITIONS: NONE- requires no input 
* POSTCONDITIONS: Just displays a page for a period of time
* ERRORS AND EXCEPTIONS: NONE
* Side EFFECTS: NONE
* INVARIANTS: NONE
* KNOWN FAULT - None
* KNOWN FAULT - None
*/
import 'package:flutter/material.dart';
import 'package:flutter_application_1/check-in/quiz_screen.dart';
import 'package:flutter_application_1/main.dart';

import 'package:flutter_application_1/constant.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'DemoApp.dart';

// consturctor that takes in arguments
class Splash extends StatefulWidget {
  String email;
  Splash({required this.email});
  _SplashState createState() => _SplashState(email: email);
}

class _SplashState extends State<Splash> {
  String email;
  _SplashState({required this.email});
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    // how long to delay the splash screen
    await Future.delayed(Duration(milliseconds: 1500), () {});

    //access database to get necessary information
    var temp;
    var db = await mongo.Db.create(
        MONGO_URL_LOGIN); //wait for check in table to open
    await db.open(); //wait for it to open
    var userCollection = // connect to the specific table
        db.collection(COLLECTION_NAME_users);
    temp = await userCollection.find(mongo.where.eq('email', email)).toList();
    print(temp);
    final validMap = json.decode(json.encode(temp[0])) as Map<String, dynamic>;
    // Text("Your details are\n");
    temp = validMap;
    late String date;
    temp.forEach((k, v) {
      date = (temp['dateofLastCheckIn']);
    });
    DateTime now = new DateTime.now();
    DateTime LatestDate = new DateTime(now.year, now.month, now.day);
    var happinessScale;

    //get happiness scale score from database
    if (LatestDate.toString() == date) {
      var datab = await mongo.Db.create(
          MONGO_URL_CHECKIN); //wait for check in table to open
      await datab.open(); //wait for it to open
      var collec = // connect to the specific table
          datab.collection(COLLECTION_NAME_checkin);
      temp = await collec.find(mongo.where.eq('ID', email)).toList();

      print(temp[0]);
      final mp = json.decode(json.encode(temp[0])) as Map<String, dynamic>;
      temp = mp;
      // late String date;
      temp.forEach((k, v) {
        happinessScale = (temp['Happiness Scale: ']);
      });
      // send the score across pages
      print("HAPPINESS SCALE: $happinessScale");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DemoApp(
              email: ('${email}'), happinessScale: ('${happinessScale}'))));
    } else {
      //update the check in date
      setState(() {
        userCollection.update(mongo.where.eq('email', '${email}'),
            mongo.modify.set('dateofLastCheckIn', '${LatestDate.toString()}'));
      });
      var temp;

      // if not yet checked in then go to quiz screen
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuizScreen(email: ('${email}'))));
    }
  }
  // what the display needs to look like

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
            child: Container(
          child: Text(
            'Mindly',
            style: TextStyle(
                fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )));
  }
}
