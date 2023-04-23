import 'package:flutter/material.dart';
import 'package:flutter_application_1/DemoApp.dart';

/*This is the journaling page the user fills to record their entries.
# NAME OF CODE ARTIFACT - Journal_page.dart 
# BRIEF DESCRIPTION - This is the journal page entry for the Mindly app.
# PROGRAMMERS NAME - Eduardo Sanchez
# DATE CODE CREATED - October 19, 2022
# KNOWN FALUTS - None 
# DATE REVISED - October 20 2022
#                   Eduardo Sanchez - added save button, no functionality at this point.
#       
#                   Jowaki Merani   - changed color of the text box to white instead of the same as the background.
#                                   - increased the size of the text box.
#                 November 4th 
#                   Jowaki Merani - conected the save button to send teh text to the db 
#                 March 9th
                   Parveen Kaur - added proper navigation between pages
                   April 5th 
                   Jowaki Merani - added code to provide trigger analyser 
# 
*/

/*PRECONDITIONS: 
* input - any text is an acceptable input value value in the text box 
*/

/*POST CONDITIONS:
* return - the text is stored in the database table followed by - 
* either redirect to the home page (no trigger words identified) or 
* to profile page  (trigger word found)
*/
import 'dart:developer';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/resources/ResourcePg.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'dart:io';
import 'package:excel/excel.dart';

import 'animal/animal.dart';
import 'games/games_meanu_pg.dart';
import 'music/music_page.dart';
// import 'package:mongo_dart/mongo_dart.dart';

class MyJournal extends StatefulWidget {//traverse info through the pages 
  // class for the journal page.
  String email;
  String happinessScale;
  MyJournal({required this.email, required this.happinessScale}); //constructor for the journal page.

//create a state for the journal page to work in 
  @override
  _MyJournalState createState() =>
      _MyJournalState(email: '$email', happinessScale: '$happinessScale'); //creates journal page.
}

class _MyJournalState extends State<MyJournal> {
  //defines the journal page. with required variables 
  String g_journal = "";
  String email = "";
  String happinessScale;

  _MyJournalState({required this.email, required this.happinessScale});//func call

  @override
  Widget build(BuildContext context) {
    // builds the widget.
    const appTitle =
        'Mindly'; // this sets the title of the page. set to 'Mindly' for all pages as of 10/03.
    return MaterialApp(
      // what the page will contain. returns the content below.
      debugShowCheckedModeBanner:
          false, // disables debug banner when troubleshooting.
      title: appTitle, // title is set to 'Mindly'.
      home: Scaffold(
        // home page is set
        // .
        // bottom bar icons for navigation through pages
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
                              happinessScale: ('$happinessScale')
                            )));
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
                              happinessScale: ('$happinessScale')
                            )));
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
                              happinessScale: ('$happinessScale')
                            )));
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
                              happinessScale: ('$happinessScale')
                            )));
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
                              email: '$email',
                              happinessScale: ('$happinessScale')
                            )));
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
                              happinessScale: ('$happinessScale')
                            )));
                  }, //functionality
                ),
              ],
            )),
        appBar: AppBar(
          //app bar widget.
          title: const Text(appTitle), // title of the app bar.
        ),
        backgroundColor: Colors.blue, // background color of the main page
        body: Center(
            // the body of the page, this contains the text field.
            child: Column(
          mainAxisAlignment: MainAxisAlignment
              .start, // centers the box and places it on top section. might change to center.
          children: [
            // contains the children for text box.
            TextFormField(
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType
                  .multiline, // allows how many lines of text are shown before scroll function is set
              textAlign: TextAlign
                  .start, // where to begin the text once the user inputs their entry.
              decoration: InputDecoration(
                  hintText:
                      'Journal Entry here', // ghost text to show where to input entry, disapears once input is recieved.
                  fillColor:
                      Colors.grey.shade100, // color of the text box background.
                  filled:
                      true, // fills the text box background to the above color.
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 100,
                      horizontal:
                          50), // sets the size of the journal entry text box.
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)) // outlines the text box.
                      )),
              onChanged: (jor) {
                g_journal = jor;
              },
            ),
            Container(
              // container widget for the save button.
              height: 50, //height of the save button.
              width: 150, //width of the save button.
              child: ElevatedButton(
                onPressed: () async {
                  var db = await mongo.Db.create(
                      MONGO_URL2_journal); //wait to locate url
                  await db.open(); //opens the connection to url - reuquired db
                  inspect(db); //ensures url exists
                  var status = db.serverStatus(); //provides the status of url

                  // ignore: avoid_print
                  print(status); //debug print to ensure sucessful status
                  var collection = db.collection(
                      COLLECTION_NAME_journal); //accesses collection name
                  await collection.insert({
                    "journal": g_journal,
                    "Day": DateTime.now().day,
                    "Month": DateTime.now().month,
                    "yr": DateTime.now().year
                  }); //wait for data

                  final Map<DateTime, List<CleanCalendarEvent>> events = {
                    //create events
                    DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day): //events
                        [
                      //create a journal entry for the day
                      CleanCalendarEvent(
                        'ENTRY',
                        startTime: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        endTime: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        description: g_journal,
                        // color: Colors.blue[700]),
                      ),
                    ],
                  };

                  // following code deals with the trigger analyser 
                  final file = File('assets/lotw.xlsx');//acess excel sheet 
                  final bytes = file.readAsBytesSync();//convert to byte readbility 

                  final excel = Excel.decodeBytes(bytes);//decode teh bytes 

                  final sheetName = excel.tables.keys.first;//acess the sheetname 
                  final sheet = excel.tables[sheetName]!;//acess column in sheet 

                  // final gJournal = 'today was a - suicide';
                  final g_Journal = g_journal.toLowerCase();//convert journal entry to lower case to avoid case conversion errors 

                  bool foundMatch = false;//variable to identify match 
                  // print('here');

                  for (final row in sheet.rows) {//traverse the row of teh first column 
                    for (final cell in row) {//traverse journal entries 
                      if (cell != null && cell.cellType == CellType.values[0] && cell.value != null) {//identify the value 
                        final cellValue = cell.value.toString().toLowerCase();//identify cell value and convert to lower case 
                        print("$g_Journal");//debug print 
                        if (g_Journal.contains(cellValue)) {//look for match 
                          foundMatch = true;//yes then exit loop 
                          break;
                        }
                      }
                    }
                    if (foundMatch) {
                      break;
                    }
                  }

                  print('Match found: $foundMatch');//debug print 
                  if(!foundMatch)//no match redirect to home pg 
                  {
                    // Navigator.pop(context, events);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DemoApp(
                              email: ('$email'),
                              happinessScale: ('$happinessScale')
                            )));
                  }
                  else//redirect to resources pg 
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Resources(
                              email: ('$email'),
                              happinessScale: ('$happinessScale')
                            )));
                    // Navigator.push(context, 'allResources');
                  }

                  // Navigator.pop(context, events); //send event back to screen
                  
                },
                child: Text('Save'),//save button ends 
              ),
            ),
          ], // The style of the button and the text in the button.
        )),
      ),
    );
  }
}
