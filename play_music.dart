/*
* NAME OF CODE ARTIFACT - play_music.dart
* BRIEF DESCRIPTION - This is the music page that will open under the specific music page tune number 
* PROGRAMMERS NAME - Jui Nagarkar
* DATE CODE CREATED - March 25th, 2023
* DATE REVISED -      March 26th, 2023 - made sure that the different tunes played under the correct number
                      April 23rd, 2023 - Jui Nagarkar - added the comments according to the final sprint requirements   
* PRECONDITIONS - No input values or types needed, the music automatically plays when the play button is pressed
* POSTCONDITIONS - No return types
* ERROR AND EXCEPTION CONDITION: None
* SIDE EFFECTS: None
* INVARIANTS: None
* KNOWN FAULTS - None
*/

//the imports
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
//import 'package:audioplayers/audio_cache.dart';

//creating a stateful widget like usual
class PlayMusic extends StatefulWidget {
  //const PlayMusic({super.key});
  //initializing songNumber and its required elements
  int songNumber = 0;
  PlayMusic({required this.songNumber});
  @override
  State<PlayMusic> createState() => _PlayMusicState(songNumber: songNumber);
}

//music class
class _PlayMusicState extends State<PlayMusic> {
  //creating an audioplayer instance
  //initializing songNumber and its required elements
  int songNumber = 0;
  _PlayMusicState({required this.songNumber});
  AudioPlayer audioPlayer = AudioPlayer();

  //declaring all the variables
  bool _isPlaying = false;
  String _songTitle = 'Music';
  Duration _duration = Duration();
  Duration _position = Duration();
  //StreamSubscription<Duration>? _positionSubscription;
  //pickSong function that calls the play method depending on the song number
  void pickSong() async {
    if (songNumber == 1) {
      _playMeditation();
    }
    if (songNumber == 2) {
      _playSoothing();
    }
    if (songNumber == 3) {
      _playUpbeat();
    }
  }

  //initState method
  @override
  void initState() {
    super.initState();
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });
  }

  //dispose function which stops all the functions that were started in init state and elsewhere
  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  final audioCache = AudioCache();
  //playMeditation method that plays the meditation song when called
  void _playMeditation() async {
    await audioPlayer.play(AssetSource('audio/meditation.mp3'));
    //await audioPlayer.play(AssetSource('audio/soothing.wav'));
    //await audioPlayer.play(AssetSource('audio/upbeat.mp3'));
    setState(() {
      _isPlaying = true;
      _songTitle = 'Meditation Music';
    });
  }

  //playSoothing method that plays the soothing song when called
  void _playSoothing() async {
    //await audioPlayer.play(AssetSource('audio/meditation.mp3'));
    await audioPlayer.play(AssetSource('audio/soothing.wav'));
    //await audioPlayer.play(AssetSource('audio/upbeat.mp3'));
    setState(() {
      _isPlaying = true;
      _songTitle = 'Soothing Music';
    });
  }

  //playUpbeat method that plays the upbeat song when called
  void _playUpbeat() async {
    //await audioPlayer.play(AssetSource('audio/meditation.mp3'));
    //await audioPlayer.play(AssetSource('audio/soothing.wav'));
    await audioPlayer.play(AssetSource('audio/upbeat.mp3'));
    setState(() {
      _isPlaying = true;
      _songTitle = 'Upbeat Music';
    });
  }

  //pause method
  void _pause() async {
    await audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  //build method like usual
  //adding the alignment and other pieces to make the page look nicer
  @override
  Widget build(BuildContext context) {
    //app bar titled mindly music
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindly Music'),
      ),
      body: Column(
        //making sure everything is centered
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _songTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 20.0),
          //this is for the slider when the music is playing to move forward or backward
          Slider(
            value: _position.inSeconds.toDouble(),
            max: _duration.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              });
            },
          ),
          SizedBox(height: 20.0),
          Row(
            //centering
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //play button
              IconButton(
                icon: Icon(Icons.play_arrow),
                //onPressed(): !_isPlaying ? pickSong() : null,
                onPressed: () {
                  //calls pickSong function when not isPlaying
                  if (!_isPlaying) {
                    pickSong();
                  } else {}
                },
              ),
              SizedBox(width: 20.0),
              //pause button
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: _isPlaying ? _pause : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
