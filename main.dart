/*
* NAME OF CODE ARTIFACT - main.dart
* BRIEF DESCRIPTION - This is the main page that opens at the begining 
* PROGRAMMERS NAME - Eduardo Sanchez
* DATE CODE CREATED - October 1st, 2022
* DATE REVISED - October 1st
*                Eduardo Sanchez - Generated a main page with the opening options of either loging in or signing up 
                 October 7th
                 Eduardo Sanchez - linked the main page buttons to corresponding pages
                 October 23rd 
                 Jowaki Merani - reformat the code to work for database connections
* KNOWN FAULT - None
*/
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/forgotPass_page.dart';
import 'package:flutter_application_1/games/tapping_game.dart';
import 'package:flutter_application_1/graph_page.dart';
// import 'package:flutter_application_1/paint_pad.dart';
import 'package:flutter_application_1/check-in/quiz_screen.dart';
import 'package:flutter_application_1/reminder_page.dart';
import 'package:flutter_application_1/resources/ResourcePg.dart';
import 'package:flutter_application_1/music/play.dart';
import 'package:flutter_application_1/personal%20details/profile.dart';
import 'package:flutter_application_1/personal%20details/profileMenu_page.dart';
// import 'package:flutter_application_1/games/word_game.dart';
import 'personal details/editProfile_page.dart';
import 'login/login_page.dart';
import 'login/sign_up_page.dart';
import 'journal_page.dart';
import 'DemoApp.dart';
import 'music/music_page.dart';
import 'music/play.dart';
import 'reminder_page.dart';
import 'graph_page.dart';
import 'personal details/profileMenu_page.dart';
import 'games/tapping_game.dart';
import 'check-in/quiz_screen.dart';
import 'check-in/question_model.dart';
import 'animal/animal.dart';
import 'games/paint_pad.dart';
import 'games/games_meanu_pg.dart';
import 'word_game.dart';
// import 'profileMenu_page.dart';
// import 'mongodb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: await_only_futures
  // await MongoDbDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //creates an app class
  const MyApp({super.key}); //app class has a const return key

  @override
  Widget build(BuildContext context) {
    //calls the build function - inbuilt
    return MaterialApp(
        debugShowCheckedModeBanner:
            false, // this disables a banner shown on the top left corner of the emulator.
        initialRoute:
            'login_page', // sets the first page when starting up the project. set to login page.
        routes: {
          // route shows the available pages the app is able tot traverse to.
          'login_page': (context) =>
              QuizScreen(email: ''), // login page available to traverse to
          'sign_up_page': (context) =>
              const MyRegister(), // sign up page available to traverse
          'journal_page': (context) => MyJournal(
                email: '',
              ), // Journal page available to traverse.
          'home_page': (context) => DemoApp(
                email: '',
              ),
          "profile_page": (context) => Profile_pg(
                email: '',
                name: '',
                password: '',
              ),
          "music_page": (context) => MyMusic(
                email: '',
              ),
          "game_menu": (context) => MyGame_Meanu(
                email: '',
              ),
          "ping_pong": (context) => MyPaint(),
          "animal_page": (context) => MyAnimal(
                email: '',
              ),
          "play_page": (context) => const MyPlay(),
          "forgotPass_page": (context) => const MyForgotPass(),
          "reminder_page": (context) => const MyNoteScreen(),
          "graph_page": (context) => const MyGraph(),
          "tap_game": (context) => const MyGamePage(),
          //"quiz_page": (context) => QuizScreen(
            //    email: '',
            //  ),

          "profileMenu_page": (context) => SettingsPageUI(
                email: '',
              ),
          "editProfile_page": (context) => EditProfileUI(
                email: '',
                name: '',
                password: '',
              ),
          "word_game": (context) => wordGame(),
          "allResources": (context) => Resources(
                email: '',
              ),
        });
  }
}
