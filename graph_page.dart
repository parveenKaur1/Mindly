/*
* NAME OF CODE ARTIFACT - graph_page.dart
* BRIEF DESCRIPTION - This creates the frontend for the sample graph
* PROGRAMMERS NAME - Parveen Kaur
* DATE CODE CREATED - January 28th 2023
* DATE REVISED - 
* PRECONDITIONS - the survey must be completed for the values to be tranfered over to this page.
* POSTCONDITIONS - No return types
* ERROR AND EXCEPTION CONDITION: None
* SIDE EFFECTS: None
* INVARIANTS: None
* KNOWN FAULTS - hardcoded for now
*/

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'check-in/quiz_screen.dart';

class MyGraph extends StatefulWidget {
  //class for the login landing page.
  const MyGraph({Key? key}) : super(key: key); // constructor for log in page.

  @override
  _MyGraphState createState() => _MyGraphState(); //creates login page.
}

//double some = QuizScreenState(email:"").happinessScale;

class _MyGraphState extends State<MyGraph> {
  List<MoodMeter> data = [
    MoodMeter('Day 1', 9), // Day1 value
    MoodMeter('Day 2', 16),
    MoodMeter('Day 3', 45),
    MoodMeter('Day 4', 56),
    MoodMeter('Day 5', 10),
    MoodMeter('Day 6', 30),
    MoodMeter('Day 7', 45),
    MoodMeter('Day 8', 61),
    MoodMeter('Day 9', 70),
    MoodMeter('Day 10', 22),
    MoodMeter('Day 11', 33),
    MoodMeter('Day 12', 41),
    MoodMeter('Day 13', 45),
    MoodMeter('Day 14', 20),
    MoodMeter('Day 15', 28),
    MoodMeter('Day 16', 40),
    MoodMeter('Day 17', 31),
    MoodMeter('Day 18', 48),
    MoodMeter('Day 19', 20),
    MoodMeter('Day 20', 30),
    MoodMeter('Day 21', 19),
    MoodMeter('Day 22', 23),
    MoodMeter('Day 22', 70),
    MoodMeter('Day 23', 73),
    MoodMeter('Day 24', 55),
    MoodMeter('Day 25', 44),
    MoodMeter('Day 26', 21),
    MoodMeter('Day 27', 23),
    MoodMeter('Day 28', 86),
    MoodMeter('Day 29', 50),
    MoodMeter('Day 30', 79),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monthly Summary"), // header of page
        centerTitle: true, // page aesthetic
        backgroundColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      body: Container(
          // body of page
          child: SfCartesianChart(
              // type of graph
              primaryXAxis: CategoryAxis(), // xaxis
              title: ChartTitle(text: 'Your Mood Meter'), // chart title
              legend: Legend(
                isVisible: true,
              ), // visibility of line
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<MoodMeter, String>>[
            LineSeries<MoodMeter, String>(
              // line graph
              dataSource: data,
              xValueMapper: (MoodMeter mood, _) =>
                  mood.week, // x represents week
              yValueMapper: (MoodMeter mood, _) =>
                  mood.mood, // y represents mood
              name: 'happiness percentage', // name of line
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ])),
    );
  }
}

class MoodMeter {
  final String week; // member vars

  final double mood; //member vars

  MoodMeter(this.week, this.mood); // constructor
}
