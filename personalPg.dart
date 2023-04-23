/*
* NAME OF CODE ARTIFACT - personalPg.dart
* BRIEF DESCRIPTION - Deals with the personal resource page
* PROGRAMMERS NAME - Parveen Kaur
* DATE CODE CREATED - March 12th 2023
* DATE REVISED -
* PRECONDITIONS: NONE- requires no input however, functions within this class require parameters but this is an internal process
  and requires no user input
* POSTCONDITIONS: Displays information necessary for page
* ERRORS AND EXCEPTIONS: NONE
* Side EFFECTS: NONE
* INVARIANTS: NONE
* KNOWN FAULT - None
*/
import 'package:flutter/material.dart';

// PErsonal page constructor.
class PersonalPage extends StatelessWidget {
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
                // calls build card function ans passes necesary information to ensure that it dislays
                children: <Widget>[
                  _buildCard(
                      'Breathing Exercises',
                      'assets/breathe.png',
                      '- Let your breath flow deeply\n- Try breathing in through your nose and out through your mouth.\n- Breathe in and try to count from 1 to 5.\n- Keep doing this for at least 5 minutes.',
                      context),
                  _buildCard(
                      'Play a Game',
                      'assets/game.png',
                      'Head over to the game page and play the games catered to help with your anxiety temporarily',
                      context),
                  _buildCard(
                      'Get Active',
                      'assets/KUREC.png',
                      '- Head on over to the Recreation Centre located on campus\n- Get active by playing some of your favourite sports\n- Enroll in dance classes',
                      context),
                  _buildCard(
                      '3-3-3 Rule',
                      'assets/333.png',
                      '- Look around you and name three things you see\n- Then, name three sounds you hear\n- Finally, move three parts of your body(e.g, ankle, fingers or arms)',
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
