/*
* NAME OF CODE ARTIFACT - question_model.dart
* BRIEF DESCRIPTION - Questions for the checkin page 
* PROGRAMMERS NAME - Parveen Kaur
* DATE CODE CREATED - February 20th 2022
* DATE REVISED - 
 PRECONDITIONS: NONE. Requires no input
  POSTCONDITIONS: provides questions associated with number
  ERRORS AND EXCEPTIONS: NONE
  Side EFFECTS: NONE
  INVARIANTS: NONE
* KNOWN FAULT - None
*/

class Question {
  // question class
  final String questionText; // question string

  final List<Answer> answersList; // answer list

  Question(this.questionText, this.answersList); //constructor
}

class Answer {
  // answer class
  final String answerText; // answer
  final int happyScale; // scale

  Answer(this.answerText, this.happyScale); // constructor
}

List<Question> getQuestion() {
  // question list
  List<Question> list = []; // list

  list.add(Question("How are you feeling today?", [
    // question 1
    Answer("Happy", 18), //answer 1
    Answer("Ecstatic", 20), //answer 2
    Answer("Okay", 10), //answer 3
    Answer("Anxious", 8), //answer 4
    Answer("Stressed", 5), //answer 5
    Answer("Hurt", 2), //answer 6
    Answer("Depressed", 1), //answer 7
  ]));
  list.add(Question("How are your stress levels lately?", [
    // Question 2
    Answer("0-25%", 5), //answer 1
    Answer("25-50%", 10), //answer2
    Answer("50-75%", 15), //answer3
    Answer("75-100%", 20), //answer4
  ]));
  list.add(Question("Have I been socializing less?", [
    // Question 3
    Answer("Yes, less than before", 5), //answer 1
    Answer("About as much as before", 15), //answer 2
    Answer("No, I have been socializing more", 20), //answer3
  ]));
  list.add(Question(
      "How often did I look at the bright side of things yesterday? ", [
    //Question 4
    Answer("Barely, Its been hard focusing on the good lately", 5), //answer1
    Answer("I made an effort but still felt down", 10), //answer2
    Answer(
        "A lot. It's been easier to do so than focusing on what I can't change", //answer3
        20),
  ]));
  list.add(Question("Are you feeling alone?", [
    // Question 5
    Answer("Yes, it sometimes feels like no one gets me", 5), //answer1
    Answer(
        "No, I have people around me but I just didnt feel like talking to them", //answer2
        10),
    Answer("No, I am surrounded by people who love and care about me",
        20), //answer3
  ]));

  return list; // return the list
}
