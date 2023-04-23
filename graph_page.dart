/*
* NAME OF CODE ARTIFACT - graph_page.dart
* BRIEF DESCRIPTION - This creates the frontend for the sample graph
* PROGRAMMERS NAME - Parveen Kaur
* DATE CODE CREATED - January 28th 2023
* DATE REVISED - 
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
