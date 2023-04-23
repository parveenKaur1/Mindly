/*
* NAME OF CODE ARTIFACT - quiz_screen.dart
* BRIEF DESCRIPTION - Deals with the check-in page. Displaying questions and receiving answers
* PROGRAMMERS NAME - Parveen Kaur
* DATE CODE CREATED - February 20th 2022
* DATE REVISED - 25th March 2023 
                -Parveen Kaur - Only displays check  in page hasnt already been completed
  PRECONDITIONS: This just requires users to click the answer. Therefore input values do not apply
                 However, users can leave it empty
  POSTCONDITIONS: return values are ints for each answer can also be null if left empty
  ERRORS AND EXCEPTIONS: NONE
  Side EFFECTS: NONE
  INVARIANTS: NONE
* KNOWN FAULT - None
*/

import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DemoApp.dart';
import 'question_model.dart';

import 'package:flutter_application_1/constant.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class QuizScreen extends StatefulWidget {
  // quiz function
  String email; // member variable

  QuizScreen({required this.email}); // constructor
  State<QuizScreen> createState() =>
      _QuizScreenState(email: '${email}'); // extended state constructor
}

class _QuizScreenState extends State<QuizScreen> {
  bool _isCheckedIn = false;
  String email; // member variable

  _QuizScreenState({required this.email}); // constructor

//   void initState() {
//     super.initState();
//     _retrieveCheckInStatus();
//   }

// // checks if user has signed in
//   Future<void> _retrieveCheckInStatus() async {
//     var temp;

//     //should check database to see if user has logged in
//     var db = await mongo.Db.create(
//         MONGO_URL_LOGIN); //wait for check in table to open
//     await db.open(); //wait for it to open
//     var userCollection = // connect to the specific table
//         db.collection(COLLECTION_NAME_users);
//     temp = await userCollection.find(mongo.where.eq('email', email)).toList();
//     print(temp);
//     final validMap = json.decode(json.encode(temp[0])) as Map<String, dynamic>;
//     // Text("Your details are\n");
//     temp = validMap;
//     late String date;
//     temp.forEach((k, v) {
//       date = (temp['dateofLastCheckIn']);
//     });
//     DateTime now = new DateTime.now();
//     DateTime LatestDate = new DateTime(now.year, now.month, now.day);
//     if (LatestDate.toString() == date) {
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => DemoApp(
//               email: ('${email}'), happinessScale: ('${happinessScale}'))));
//     } else {
//       setState(() {
//         userCollection.update(mongo.where.eq('email', '${email}'),
//             mongo.modify.set('dateofLastCheckIn', '${LatestDate.toString()}'));
//       });
//     }
  // }

  int happinessScale = 0; // variable
  List<Question> questionList = getQuestion(); // call queston constructor
  int currentQuestionIndex = 0; // count
  int count = 0; //count
  int score = 0; //score
  Answer? selectedAnswer; // answers

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 131, 229), // background
      body: Container(
        margin:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 32), // margin
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          //alignment
          const Text(
            // text
            "Check-In",
            style: TextStyle(
              color: Colors.white, // text color
              fontSize: 24, //size
            ),
          ),
          _questionWidget(), //question
          _answerList(), //answer list
          _nextButton(), // next button
        ]),
      ),
    );
  }

  _questionWidget() {
    // question
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // alignmenr
      mainAxisAlignment: MainAxisAlignment.center, //alignment
      children: [
        Text(
          //text
          "Question ${currentQuestionIndex + 1}/${questionList.length.toString()}", //text number
          style: const TextStyle(
            color: Colors.white, // text color
            fontSize: 20, // size
            fontWeight: FontWeight.w600, //weight
          ),
        ),
        const SizedBox(
          //size
          height: 20, //height
        ),
        Container(
          //container
          width: double.infinity, //width
          padding: const EdgeInsets.all(32), //padding
          decoration: BoxDecoration(
            //decoration
            color: Color.fromARGB(255, 63, 80, 110), //color
            borderRadius: BorderRadius.circular(16), //radius
          ),
          child: Text(
            //text
            questionList[currentQuestionIndex].questionText, //question
            style: TextStyle(
              color: Colors.white, //color
              fontSize: 18, //size
              fontWeight: FontWeight.w600, //weight
            ),
          ),
        ),
      ],
    );
  }

  _answerList() {
    // answers
    return Column(
      children: questionList[currentQuestionIndex] // question at index
          .answersList
          .map(
            (e) => _answerButton(e),
          )
          .toList(), // list the answers
    );
  }

  Widget _answerButton(Answer answer) {
    // answer button
    bool isSelected = answer == selectedAnswer; // check isselected
    return Container(
        //container
        width: double.infinity, //width
        height: 48, //height
        margin: const EdgeInsets.symmetric(vertical: 8), //margin
        child: ElevatedButton(
          //button
          child: Text(answer.answerText), //display answer
          style: ElevatedButton.styleFrom(
            //style
            shape: const StadiumBorder(), //shape
            primary: isSelected
                ? Color.fromARGB(255, 107, 109, 113) //if selected
                : Color.fromARGB(255, 231, 232, 235), //otherwise
            onPrimary: isSelected
                ? Color.fromARGB(255, 0, 0, 0) //if selected
                : Color.fromARGB(255, 14, 14, 14), //otherwise
          ),
          onPressed: () async {
            // if pressed
            if (selectedAnswer == null) {
              // if null
              // count = count + 1;
              happinessScale = happinessScale +
                  answer.happyScale; // increment happinessscale
              // String choice = answer.answerText;

              // var db = await mongo.Db.create(MONGO_URL_CHECKIN);
              // await db.open(); //wait for it to open
              // var userCollection = // connect to the specific table
              //     db.collection(COLLECTION_NAME_checkin);

              // await userCollection.insert({"${count}": choice});
              // if (answer.isCorrect) {
              //   score++;
              // }
              // addToDatabase(choice, collection, db);
            }
            setState(() {
              // reset state
              selectedAnswer = answer; // answer
            });
          },
        ));
  }

  _nextButton() {
    // next button
    bool isLastQuestion = false; // set last question to false
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true; // if last then set to true
    }
    return Container(
        //container
        width: MediaQuery.of(context).size.width * 0.5, // width
        height: 48, //height
        child: ElevatedButton(
          //button
          child: Text(isLastQuestion
              ? "Submit"
              : "Next"), // if last question change text to submit
          style: ElevatedButton.styleFrom(
            //style
            shape: const StadiumBorder(),
            primary: Colors.blueAccent, //color
            onPrimary: Colors.white, //color
          ),
          onPressed: () async {
            // if pressed
            if (isLastQuestion) {
              // if last question
              var db = await mongo.Db.create(
                  MONGO_URL_CHECKIN); //wait for check in table to open
              await db.open(); //wait for it to open
              var userCollection = // connect to the specific table
                  db.collection(COLLECTION_NAME_checkin);

              await userCollection.insert(// insert value
                  {"ID": "${email}", "Happiness Scale": "${happinessScale}"});
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DemoApp(
                      email: ('${email}'),
                      happinessScale:
                          ('${happinessScale}') // once pressed, go to next page
                      )));
            } else {
              setState(() {
                // reset
                selectedAnswer = null;
                currentQuestionIndex++; // increment index
              });
            }
          },
        ));
  }
}
