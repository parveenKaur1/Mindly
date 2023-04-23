/*
* NAME OF CODE ARTIFACT - wordhunt_game.dart
* BRIEF DESCRIPTION - This is the word hunt game page that will open under the games page 
* PROGRAMMERS NAME - Jui Nagarkar
* DATE CODE CREATED - February 23rd, 2023
* DATE REVISED - February 24th 
                 Jui Nagarkar - Add in the remaining pieces
               - April 23rd
               Jui Nagarkar - added the comments according to the final sprint requirements   
* PRECONDITIONS - No input values or types needed, the boxes and letters are generated every time a new word is given, and then the user must match the right letter in the right box to get the new word screen
* POSTCONDITIONS - No return types, every time the word is successfully completed, a new word screen appears
* ERROR AND EXCEPTION CONDITION: None
* SIDE EFFECTS: None
* INVARIANTS: None
* KNOWN FAULTS - The new word functionality does not work ever since the word game was incorporated into the app   
*/

import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'allWords.dart';
import 'games/games_meanu_pg.dart';

//main method just like in all of the other files
void main() {
  //added a notifierprovider package which tells the user the total number of letters
  // runApp(ChangeNotifierProvider(
  //     create: (_) => Controller(), child: const wordGame()));
}

//basic widget that just names the game as well as has theme data elements such as the color and maybe might change the font in the future sprints if we think necessary
class wordGame extends StatelessWidget {
  const wordGame({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => Controller(),
        child: MaterialApp(
          title: 'Word Scramble',
          debugShowCheckedModeBanner:
              false, // this disables a banner shown on the top left corner of the emulator.
          //adding a set theme to the app page such as the font and the text colors are set
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: const TextTheme(
                  headline1: TextStyle(
                      //         fontFamily: 'Schyler',
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          home: const HomePage(),
        ));
  }
}

//creating the homepage widget like usual
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//creating the build of the homepage
class _HomePageState extends State<HomePage> {
  //creating a private list of words
  List<String> _words = allWords.toList();
  late String _word, _dropWord;

  _generateWord() {
    //we are randomly generating a word here to add some randomness to the game
    final r = Random().nextInt(_words.length);
    _word = _words[r];
    _words.removeAt(r);
    //same things being done for the drop word just creating another variable so that this is the not scrambled word
    _dropWord = _word;
    final s = _word.characters.toList()..shuffle();
    _word = s.join();

    //this is connecting the provider package and linking it with the words that we have here
    //connecting provider/controller with the words
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setUp(total: _word.length);
      //after the new word has been generated then it sets the word request to false
      Provider.of<Controller>(context, listen: false)
          .requestWord(request: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    //returning in the safe area to make sure that when we use this app and game on an andriod device it will not obstruct the above panel view.

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //this is the back button to exit from the word hunt game
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyGame_Meanu(
                        email: '',
                        happinessScale: '',
                      )));
              //Navigator.pop(context);
            },
          ),
        ),
        body: Selector<Controller, bool>(
            //building a selector and putting all of the lines written from SafeArea inside the builder function for this
            selector: (_, controller) => controller.generateWord,
            builder: (_, generate, __) {
              //safearea makes sure the app contents do not spill over into the user's phone app bar
              if (generate) {
                if (_words.isNotEmpty) {
                  _generateWord();
                }
              }
              return SafeArea(
                  child: Column(
                children: [
                  //this creates the different columns with different sizes
                  //flex determines the width of the column
                  //row 1
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                          child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 84, 225, 249),
                                      borderRadius: BorderRadius.circular(60)),
                                  child: Row(
                                    children: [
                                      //this is for the word hunt piece it is the decoration for it
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          18, 2, 2, 2),
                                                  child: FittedBox(
                                                      child: Text('Word Hunt',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline1))))),
                                      //this is for the image piece
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Image.asset(
                                                'assets/images/magnify.jpg'),
                                          )))
                                    ],
                                  ))))),
                  //row 2
                  Expanded(
                      flex: 3,
                      child: Container(
                          color: Colors.blue,
                          child: Row(
                            //this makes sure that the alignment of the word is spaced evenly throughout the screen
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //this maps the word that is randomly selected on to the second column on the screen
                            //this column is where the word is dropped to be checked if it is matching the actual word letter
                            children: _dropWord.characters
                                .map((e) => CreateAnimation(
                                    animate: true,
                                    child: Drop(
                                      letter: e,
                                    )))
                                .toList(),
                          ))),
                  //row 3
                  Expanded(
                      flex: 3,
                      //this is for the images
                      //we make sure that the image matches the drop word so we are putting $_dropWord
                      child: Container(
                          color: Color.fromARGB(255, 84, 225, 249),
                          child: CreateAnimation(
                            animate: true,
                            child: Image.asset(
                              'assets/images/$_dropWord.avif',
                            ),
                          ))),
                  //row 4
                  Expanded(
                      flex: 3,
                      child: Container(
                          color: Colors.blue,
                          child: Row(
                            //this makes sure that the alignment of the word is spaced evenly throughout the screen
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //this maps the word that is randomly selected on to the fourth column on the screen
                            //this column is where the word is is being dragged from to be checked if it is matching the actual word letter into the drop column
                            children: _word.characters
                                .map((e) => CreateAnimation(
                                    animate: true,
                                    child: Drag(
                                      letter: e,
                                    )))
                                .toList(),
                          ))),
                  //row 5
                  Expanded(
                      flex: 1,
                      //this is for the progress bar
                      child: Container(
                          color: Color.fromARGB(255, 84, 225, 249),
                          child: ProgressofGame()))
                ],
              ));
            }));
  }
}

//created a new widget Drag that checks the letter and keeps the code in the map above modulized
//changed the drag to a stateful widget so that when the letter is dragged to the top there is no letter left at the bottom
class Drag extends StatefulWidget {
  const Drag({
    required this.letter,
    Key? key,
  }) : super(key: key);
  //passing in the letter to be used
  final String letter;
  @override
  State<Drag> createState() => _DragState();
}

//in this new class we are making sure that the letter is not showing up in the bottom once dragged to the correct place
class _DragState extends State<Drag> {
  bool _accepted = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //setting the box to make sure that the letter does not move once put into the box
    return Selector<Controller, bool>(
        selector: (_, controller) => controller.generateWord,
        builder: (_, generate, __) {
          if (generate) {
            _accepted = false;
          }
          return SizedBox(
              width: size.width * 0.15,
              height: size.height * 0.15,
              child: Center(
                  child: _accepted
                      ? SizedBox()
                      : Draggable(
                          data: widget.letter,
                          onDragEnd: (details) {
                            if (details.wasAccepted) {
                              _accepted = true;
                              setState(() {});
                              //when letter is entered successfully it will increment by one
                              Provider.of<Controller>(context, listen: false)
                                  .incrementLetters(context: context);
                            }
                          },
                          childWhenDragging: SizedBox(),
                          feedback: Text(widget.letter,
                              //this ensures that the set style is used
                              style: Theme.of(context).textTheme.headline1?.
                                  //here we are adding shadow to the letter that is being dragged up above to make it look like an object is being dragged
                                  copyWith(shadows: [
                                Shadow(
                                    offset: Offset(3, 3),
                                    color: Colors.black.withOpacity(0.40),
                                    blurRadius: 5)
                              ])),
                          child: Text(
                            widget.letter,
                            //this ensures that the set style is used
                            style: Theme.of(context).textTheme.headline1,
                          ))));
        });
  }
}

//created a new widget Drop that checks the letter and keeps the code in the map above modulized
class Drop extends StatelessWidget {
  const Drop({
    required this.letter,
    Key? key,
  }) : super(key: key);
  //passing in the letter to be used
  final String letter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool accepted = false;
    return SizedBox(
        width: size.width * 0.15,
        height: size.height * 0.15,
        child: Center(
            child: DragTarget(onWillAccept: (data) {
          //this checks that if the letter matched the target letter (if drag matches drop) then it is accepted otherwise it is rejected
          if (data == letter) {
            print('accepted');
            return true;
          } else {
            print('rejected');
            return false;
          }
        }, onAccept: (data) {
          accepted = true;
        },

                //this is the builder context for the dragTarget
                builder: (context, candidateData, rejectedData) {
          //this if condition checks for whether the letter that was dropped was accepted or rejected.
          //if it is accepted then it sets the letter there
          if (accepted) {
            return Text(
              letter, //this ensures that the set style is used
              style: Theme.of(context).textTheme.headline1,
            );
            //this is if the letter is rejected or if the words are being seen in the beginning
            //the user will just see a filled box without a letter in it
          } else {
            return Container(
                color: Color.fromARGB(255, 147, 192, 214),
                width: 50,
                height: 50);
          }
        })));
  }
}

//this keeps track of the word letters
class Controller extends ChangeNotifier {
  int totalLetters = 0, lettersAnswered = 0, wordsAnswered = 0;

  bool generateWord = true, sessionCompleted = false;

  double percentCompleted = 0;
  //gives how many letters there are in total
  setUp({required int total}) {
    lettersAnswered = 0;
    totalLetters = total;
    //print('total leters $totalLetters');
    notifyListeners();
  }

  //increments the count by one when the answer is correct
  incrementLetters({required BuildContext context}) {
    lettersAnswered++;
    //print('letters answered $lettersAnswered');
    if (lettersAnswered == totalLetters) {
      //plays audio when the word is completed
      final player = AudioPlayer();
      // player.play(AssetSource('audio/correct_2.mp3'));
      wordsAnswered++;
      percentCompleted = wordsAnswered / allWords.length;
      //when the words answered goes through all the words it will set the sessionComplete flag to true
      if (wordsAnswered == allWords.length) {
        sessionCompleted = true;
      }
      //print('word completed');
      //when the word is completed the showDialog function runs and the message written in the message box is shown
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => MessageBox(
                sessionCompleted: sessionCompleted,
              ));
    } else {
      //plays audio when one letter is entered correctly
      final player = AudioPlayer();
      // player.play(AssetSource('audio/correct_1.mp3'));
    }
    notifyListeners();
  }

  //this asks for a word and a new word is generated
  requestWord({required bool request}) {
    generateWord = request;
    notifyListeners();
  }

  //for when the game is restarted
  reset() {
    sessionCompleted = false;
    wordsAnswered = 0;
    generateWord = true;
    percentCompleted = 0;
  }
}

//this builds the alert box which tells the user that they completed the word and gives them the option to move forward to the next word if they wish to do so
class MessageBox extends StatelessWidget {
  const MessageBox({required this.sessionCompleted, super.key});

  final bool sessionCompleted;
  @override
  Widget build(BuildContext context) {
    String title = "Well Done!";
    String buttonText = "New Word";

    //if all the words have been gone through then the replay button will show up
    if (sessionCompleted) {
      title = "All Words Completed!";
      buttonText = "Replay";
    }
    return AlertDialog(
      //this is to make the edges of the dialogue box rounded
      //this prints the well done message as well
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      backgroundColor: Colors.amber,
      title: Text(title, style: Theme.of(context).textTheme.headline1),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
            //this is to make the edges of the dialogue box rounded
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60))),
            onPressed: () {
              //when user taps the buttons the variables will be reset
              //navigator allows it to be back on the homepage so that everything can be reinitialized
              if (sessionCompleted) {
                Provider.of<Controller>(context, listen: false).reset();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              } else {
                //otherwise generates a new word
                //print('generate word ');
                Provider.of<Controller>(context, listen: false)
                    .requestWord(request: true);
                Navigator.of(context).pop();
              }
            },
            //this is for new word
            //changing the font size since it was so big
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(buttonText,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontSize: 30))))
      ],
    );
  }
}

//this is to add animation to the letters
class CreateAnimation extends StatefulWidget {
  const CreateAnimation(
      {required this.child, required this.animate, super.key});

  final Widget child;
  final bool animate;
  @override
  State<CreateAnimation> createState() => _CreateAnimationState();
}

//creates the different animations for the words
class _CreateAnimationState extends State<CreateAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  //creating the annimation for 800 milliseconds
  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);

    double begin = 0;
    double end = 1;
    final flip = Random().nextBool();
    if (flip) {
      begin = 1;
      end = 0;
    }
    _rotationAnimation = Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CreateAnimation oldWidget) {
    //the annimate condition should be true and the controller should not be animating for the if condition to hold
    if (widget.animate && !_controller.isAnimating) {
      _controller.reset();
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  //this disposes the annimation when we do not want or need it
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
//build function like usual defining the animation rotation requirements
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => RotationTransition(
            turns: _rotationAnimation,
            child: ScaleTransition(
              scale: _controller,
              child: widget.child,
            )));
  }
}

//this creates a progress bar of the game
class ProgressofGame extends StatefulWidget {
  const ProgressofGame({super.key});

  @override
  State<ProgressofGame> createState() => _ProgressofGameState();
}

//creating a progress bar for the game
class _ProgressofGameState extends State<ProgressofGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  double begin = 0, end = 0;

  @override
  //this is making sure that the progress bar is animated
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);

    _animation = Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
    super.initState();
  }

  //when animation is not wanted this function is called to dispose it
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //creating animation for the progress bar
  @override
  Widget build(BuildContext context) {
    //creating this in a selector
    return Selector<Controller, double>(
        //the selector for the percentCompleted
        selector: (_, controller) => controller.percentCompleted,
        builder: (_, percent, __) {
          end = percent;
          if (!_controller.isAnimating) {
            _animation = Tween<double>(begin: begin, end: end).animate(
                CurvedAnimation(
                    parent: _controller, curve: Curves.elasticInOut));
            //first reset then forward then making the begin and end equal each other
            _controller.reset();
            _controller.forward();
            begin = end;
            if (begin == 1) {
              begin = 0;
              end = 0;
            }
          }
          return AnimatedBuilder(
              animation: _controller,
              //this builds a linear progress indicator at the bottom of the screen
              builder: ((context, child) => Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Color.fromARGB(255, 84, 225, 249),
                        value: _animation.value,
                      )))));
        });
  }
}
