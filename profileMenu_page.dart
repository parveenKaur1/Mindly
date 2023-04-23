// /*
// * NAME OF CODE ARTIFACT - ProfileMenu_page.dart
// * BRIEF DESCRIPTION - This creates the frontend settings page
// * PROGRAMMERS NAME - Parveen Kaur
// * DATE CODE CREATED - January 28 2023
// * DATE REVISED -
// * PRECONDITIONS: NONE - simply just has clickable buttons
// * POSTCONDITIONS: If user clicks on a specific button, it has specific functionality.
//       Simply just takes the use to the page they want to navigate to
// * ERRORS AND EXCEPTIONS: NONE
// * Side EFFECTS: NONE
// * INVARIANTS: NONE
// * KNOWN FAULT - None
// */

import 'package:flutter/material.dart';
import 'package:flutter_application_1/personal%20details/profile.dart';

import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart' as mongo;
// import 'package:mongo_dart/mongo_dart.dart';
import '../constant.dart';

class SettingsPageUI extends StatefulWidget {
  // stateful widget
  String email; // member var
  String happinessScale;
  SettingsPageUI(
      {required this.email, required this.happinessScale}); // constructor
  @override
  _SettingsPageUIState createState() => _SettingsPageUIState(
      email: '${email}',
      happinessScale:
          '${happinessScale}'); // call another function with this constructor
}

//displays all possible options for user to navigate to. Once clicked, the pages navigate accordingly
class _SettingsPageUIState extends State<SettingsPageUI> {
  String email; // member var
  String happinessScale;
  _SettingsPageUIState(
      {required this.email, required this.happinessScale}); // constructor
  @override
  Widget build(BuildContext context) {
    // build page
    return Scaffold(
        backgroundColor:
            Color.fromARGB(255, 172, 212, 245), //page background color
        appBar: AppBar(
          // title of app
          title: Text("Profile", style: TextStyle(fontSize: 22)),
          automaticallyImplyLeading: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.popUntil(
                    context,
                    ModalRoute.withName(
                        'login_page')); //if logout is clicked, pop until back to login page
                // do something
              },
            ),
          ],
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
                    Text("Account", // title
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
                Divider(
                    height: 20,
                    thickness: 1), // a divider between title and contents
                SizedBox(height: 10),
                PersonalDetails(context, "Personal Details"), // contents
                DailyTrend(context, "Check Daily Trend"), //contents
                Reminders(context, "Set Daily Reminders"), //contents
              ],
            )));
  }

  GestureDetector PersonalDetails(BuildContext context, String title) {
    var temp;
    late final validMap;
    late final List transfer = []; //create a list
    // ignore: prefer_typing_uninitialized_variables
    // var temp;

    // get red => null;
    var finalemail;
    var password;
    var name;
    // String happinessScale;

    // for personal details
    return GestureDetector(
        // check movement
        onTap: () async {
          var db = await mongo.Db.create(MONGO_URL_Signup); //wait to locate url
          await db.open(); //opens the connection to url - reuquired db
          inspect(db); //ensures url exists
          var status = db.serverStatus(); //provides the status of url
          // print(status);//debug print to ensure sucessful status
          var collection = db.collection(
              COLLECTION_NAME_signup); //determine the collection of the entry
          temp = await collection
              .find(mongo.where.eq('email', '${email}'))
              .toList(); //look for specific entry
          print(temp[0]); //debug
          // print(temp["email"]); //debug

          print('check'); //debug

          final validMap = json.decode(json.encode(temp[0])) as Map<String,
              dynamic>; //map the input data to a hashmap using json
          print(validMap); //debug

          temp = validMap;

          temp.forEach((k, v) {
            finalemail = (temp['email']);
            password = (temp['password']);
            name = (temp['name']);
            // print("TestTEst");
          });

          // Text("Your details are\n");

          // String name = temp.forEach((k, v) => print("$k := $v"));

          temp.forEach((k, v) => transfer.add(
              "$k := $v\n")); //convert each map to a string and add to list
          await db.close(); //close db
          setState(() {}); //reset the page

          Navigator.of(context).push(MaterialPageRoute(
              // if tapped, go to this page
              builder: (context) => Profile_pg(
                  email: ('${finalemail}'),
                  password: ('${password}'),
                  name: ('${name}'),
                  happinessScale: ('$happinessScale'))));
        },
        child: Padding(
          // padding
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // alignment
            Text(title, // title and text aesthetics
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Icon(Icons.arrow_forward, color: Colors.black) // type of arrow
          ]),
        ));
  }

  GestureDetector DailyTrend(BuildContext context, String title) {
    // for graph
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              context, 'graph_page'); // if tapped, go to next page
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

  GestureDetector Reminders(BuildContext context, String title) {
    // for reminders
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              context, 'reminder_page'); // if tapped go to reminders page
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
