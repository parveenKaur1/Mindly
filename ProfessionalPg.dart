/*
* NAME OF CODE ARTIFACT - ProfessionalPg.dart
* BRIEF DESCRIPTION - Deals with the professional resource page
* PROGRAMMERS NAME - Parveen Kaur
* DATE CODE CREATED - March 12th 2023
* DATE REVISED 
* PRECONDITIONS: NONE- requires no input however, functions within this class require parameters but this is an internal process
  and requires no user input
* POSTCONDITIONS: Displays information necessary for page
* ERRORS AND EXCEPTIONS: NONE
* Side EFFECTS: NONE
* INVARIANTS: NONE
* KNOWN FAULT - None
*/
import 'package:flutter/material.dart';

//constructor for professional page
class ProfessionalPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  // calls build card function ans passes necesary information to ensure that it dislays

                  _buildCard(
                      'KU CAPS',
                      'assets/CAPS.png',
                      'Assist students in improving decision-making; identifying and using resources; and achieving academic, social and personal success.\n\nWebsite: https://caps.ku.edu/\nContact Number: 785-864-2277\n',
                      context),
                  _buildCard(
                      'Suicide Prevention',
                      'assets/suicidePrevent.png',
                      'Suicide & Crisis Lifeline (formerly known as the National Suicide Prevention Lifeline) provides free and confidential emotional support to people in suicidal crisis or emotional distress 24 hours a day, 7 days a week, across the United States.\n\n Dial 9-8-8 to receive help',
                      context),
                  _buildCard(
                      'Emergency Services',
                      'assets/emergency.png',
                      '“Call if You Can, Text if You Cant.”\n- Dial 911 for immediate help and wait for authorities to arrive to get you the help you need',
                      context),
                ],
              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

// buildCard essenttialy just takes in 3 paramaters, builds a card every time it is called and displays the necessary information passed

  Widget _buildCard(
      String name, String imgPath, String resourceDetails, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0)
                ],
                color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),
                Hero(
                    tag: imgPath,
                    child: Container(
                      height: 75.0,
                      width: 75.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(imgPath), fit: BoxFit.contain)),
                    )),
                SizedBox(
                  height: 7.0,
                ),
                Text(name,
                    style: TextStyle(color: Color(0xFFCC8053), fontSize: 14.0)),
                Text(resourceDetails,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 83, 139, 204),
                    )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(color: Color(0xFFEBEBEB), height: 1.0),
                ),
              ],
            )));
  }
}
