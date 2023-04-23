// /*
// * NAME OF CODE ARTIFACT - reminder_page.dart
// * BRIEF DESCRIPTION - This creates the frontend of the reminders page
// * PROGRAMMERS NAME - Parveen Kaur
// * DATE CODE CREATED - January 28 2023
// * DATE REVISED -
// * KNOWN FAULT - Unable to click back button
// */
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

class MyNoteScreen extends StatefulWidget {
  const MyNoteScreen({Key? key}) : super(key: key); // constructor

  @override
  _MyNoteScreenState createState() =>
      _MyNoteScreenState(); // call another function
}

class _MyNoteScreenState extends State<MyNoteScreen> {
  @override
  Widget build(BuildContext context) {
    // build the app
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 172, 212, 245), // background color
      appBar: AppBar(
        // title of the page
        title: Text("Mindly Set Reminders"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(
        //         Icons.arrow_back), // functionality for the back button
        //     onPressed: () {
        //       // do something
        //       Navigator.pushNamed(context,
        //           'profileMenu_page'); // navigate to menu page once button clicked
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        // scrolling the page
        padding: const EdgeInsets.all(15), // padding
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                    child: NoteTitle(
                        // title of one not
                        id: 1,
                        color: Color.fromARGB(
                            255, 255, 201, 153), // background color of the note
                        title: "Note one", // note title
                        content: "Test Note")), // content
                SizedBox(
                  // size of box
                  width: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NoteTitle extends StatefulWidget {
  //new class
  final int id; //member variable
  final Color color; //member variable
  final String title; //member variable
  final String content; //member variable

  const NoteTitle(
      // constructor
      {Key? key,
      required this.id, //member variable
      required this.color, //member variable
      required this.title, //member variable
      required this.content}) //member variable
      : super(key: key);

  @override
  _NoteTitleState createState() => _NoteTitleState(); // call function
}

class _NoteTitleState extends State<NoteTitle> {
  DateTime pickDate = DateTime.now(); // chosen date default to current date
  DateTime fullDate = DateTime.now(); // full date default to current date

  Future<DateTime> _selectDate(BuildContext context) async {
    // select date
    final date = await showDatePicker(
        // date picker is the API for calendar
        context: context,
        firstDate: DateTime(1900), // first date
        initialDate: pickDate, // initial date is the today's date
        lastDate: DateTime(2100)); // last date
    if (date != null) {
      // as long as date is picked, show time picker
      final time = await showTimePicker(
        // show time Picker
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(pickDate), // initial time is current time
      );
      if (time != null) {
        // as long as time is not empty
        setState(() {
          // reset the page to display a combination of the date and time chosen
          fullDate = DateTimeField.combine(date, time);
        });
      }
      return DateTimeField.combine(date, time); // otherwise return it anyway
    } else {
      return pickDate; // otherwise return the date chosen
    }
  }

  @override
  Widget build(BuildContext context) {
    // build
    return Container(
      // container of page
      height: 300, // height
      decoration: BoxDecoration(
        // box decoration or aesthetic
        color: widget.color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(10), //padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // alignment
        children: [
          Text(
            widget.title, // title
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20), // text style
          ),
          const SizedBox(
            // size of box
            height: 5,
          ),
          Text(widget.content), // content
          const SizedBox(
            // size of box
            height: 80, // height
          ),
          Text(fullDate.toString()), // display full date
          const SizedBox(
            // size of box
            height: 15,
          ),
          ElevatedButton(
              // create a button
              onPressed: () =>
                  _selectDate(context), // when pressed, pop up a select date
              child: const Text("Add reminder")) // button title is Add reminder
        ],
      ),
    );
  }
}
