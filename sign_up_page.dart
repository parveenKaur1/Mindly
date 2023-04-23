/*
* NAME OF CODE ARTIFACT - sign_up_page.dart
* BRIEF DESCRIPTION - This is the page that collects the information like email , name , password for a new user
* PROGRAMMERS NAME - Eduardo Sanchez
* DATE CODE CREATED - October 4th, 2022
* DATE REVISED - October 4th
*                Eduardo Sanchez - developed a field for name and email - typable boxes
                 - October 6th 
                 Eduardo Sanchez - developed a field for password - typable boxes
                 - October 23rd 
                 Jowaki Merani & Parveen Kaur - add locations to extract data from the text box to the db
                 - April 23rd 
                 Jui Nagarkar - added the comments according to the final sprint requirements   
* PRECONDITIONS - The user must enter the correct name, email, and password to create account
* POSTCONDITIONS - The user is redirected to the login page where they can enter the correct email and password and if the login credentials are correct, user is allowed in the app
* ERROR AND EXCEPTION CONDITION: None
* SIDE EFFECTS: None
* INVARIANTS: None
* KNOWN FAULTS - None
* KNOWN FAULT - None
*/

import 'dart:developer';
import 'package:flutter_application_1/constant.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MyRegister extends StatefulWidget {
  // class for the sign up page.
  const MyRegister({Key? key}) : super(key: key); // constructor.

  @override
  // ignore: library_private_types_in_public_api
  _MyRegisterState createState() => _MyRegisterState(); // creates sign up page.
}

class _MyRegisterState extends State<MyRegister> {
  // ignore: non_constant_identifier_names

  String g_name = "";
  String g_password = "";
  String g_email = "";

  //class is defined here.
  @override
  // final myController = TextEditingController();////creates a text extrating var

  Widget build(BuildContext context) {
    //initializes the page build.

    return Container(
      // container widget. What the program is going to contain.
      child: Scaffold(
        //child scaffold, this is the top bar of the page.
        appBar: AppBar(
          //app bar widget. This only affects the top bar.
          backgroundColor: Colors
              .blue, // background color set to blue, this only affects the top bar of the app.
          elevation: 0, // elevation set to zero, top of the page.
        ),
        backgroundColor:
            Colors.blue, // this is the main background color set to blue.
        body: Stack(children: [
          //initializes the body of the page. defines whats inside the children.
          Container(
            //container widget.
            padding: const EdgeInsets.only(
                left: 35,
                top: 80), // allows the 'Create New Account' to be pressed.
            child: const Text(
              "Create New Account", // string to be displayed.
              style: TextStyle(
                  color: Colors.white,
                  fontSize:
                      33), //the characteristics of the string "Create New Account".
            ),
          ),
          SingleChildScrollView(
            // allows the user to scroll down if the information can't fit in the background.
            child: Container(
              // child widget for the scroll views.
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height *
                      0.27), // centers the upcoming text boxes to be centered.
              child: Column(children: [
                // child widget
                TextField(
                  // creates textfield widget. This affects the text box only when the user chooses this box.
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      // creates an outline around the text boxes.
                      borderRadius: BorderRadius.circular(
                          10), // the size of the border around the input box.
                      borderSide: const BorderSide(
                          color: Colors
                              .black), // sets the color of the border when user chooses this box. Currently set to black.
                    ),
                    enabledBorder: OutlineInputBorder(
                      // this next section affects the border of the text box when the box is not chosen.
                      borderRadius: BorderRadius.circular(
                          10), //creates outline around the text box and the size of the border.
                      borderSide: const BorderSide(
                          color: Colors.white), // color when the box is idle.
                    ),
                    hintText:
                        'Name', //hint text disappears when user inputs information.
                    hintStyle: const TextStyle(
                        color: Colors.white), //color of the hint text 'Name'.
                  ),
                  // controller: myController,////gets the value from the text box
                  onChanged: (name) {
                    g_name = name;
                  },
                ),

                //this section imitates the behavior above.
                const SizedBox(
                  // creates the size of the input box.
                  height: 30, // the height of the input box.
                ),
                TextField(
                  // text field widget. allows UI customization of the box.
                  //when the box is chosen
                  decoration: InputDecoration(
                    // input decoration means when the user chooses this box.
                    focusedBorder: OutlineInputBorder(
                      // when the border is chosen.
                      borderRadius: BorderRadius.circular(
                          10), // border size around the text box.
                      borderSide: const BorderSide(
                          color: Colors
                              .black), //border color is black when the user picks the box.
                    ),

                    enabledBorder: OutlineInputBorder(
                      //when the border is idle.
                      borderRadius: BorderRadius.circular(
                          10), // border size around the text box
                      borderSide: const BorderSide(
                          color: Colors
                              .white), //border color is white when the box is idle.
                    ),

                    hintText:
                        'Email', // 'Email' is displayed when the user has not filled in the box.
                    hintStyle: const TextStyle(
                        color: Colors
                            .white), // 'Email' hint is displayed in white.
                  ),
                  onChanged: (email) {
                    g_email = email;
                  },
                ),

                // Same as above but for 'Password'
                const SizedBox(
                    height: 30), // creates the size of the input box.

                TextField(
                  // TextField widget.
                  obscureText:
                      true, // this is unique for password section as it allows the system to obsurce the users input.

                  //when the user is filling out the box.
                  decoration: InputDecoration(
                    // input decoration means when the user chooses this box.
                    focusedBorder: OutlineInputBorder(
                      // when the border is chosen.
                      borderRadius: BorderRadius.circular(
                          10), // border size around the text box.
                      borderSide: const BorderSide(
                          color: Colors
                              .black), //border color is black when the user picks the box.
                    ),

                    //when the box is idle.
                    enabledBorder: OutlineInputBorder(
                      // when the text box is idle.
                      borderRadius: BorderRadius.circular(
                          10), // border size around the text box.
                      borderSide: const BorderSide(
                          color: Colors
                              .white), // border color when the box is idle.
                    ),
                    hintText:
                        'Password', // displays string 'Password' when the box is idle. string disappears when user fills text.
                    hintStyle: const TextStyle(
                        color: Colors.white), // color to display 'Password'.
                  ),
                  onChanged: (password) {
                    g_password = password;
                  },
                ),

                const SizedBox(
                  // create box widget.
                  height: 40, // set widget size to 40.
                ),

                Row(
                    // Row widget sets structure for a series of inputs.( next button, sign in string)
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // spaces the inputs evenly on the screen.
                    children: [
                      // the children defined in the 'Row' widget.
                      const Text(
                        // text widget
                        'Sign In', // displays 'Sign In' in the display.
                        style: TextStyle(
                          // widget allows customization.
                          color: Colors.white, // 'Sign In' set to white.
                          fontSize: 27, // font size for 'Sign In'
                          fontWeight: FontWeight
                              .w700, //changes how bold the string is displayed.
                        ),
                      ),

                      CircleAvatar(
                        radius:
                            30, //creates widget circle and sets the radius (size) to 30.
                        backgroundColor: const Color(
                            0xff4c505b), // sets the background color of the circle widget.
                        child: IconButton(
                          color: Colors
                              .white, //the color of icon inside the button. currently set to white.
                          onPressed: () async {
                            var db = await mongo.Db.create(
                                MONGO_URL_Signup); //wait to locate url
                            await db
                                .open(); //opens the connection to url - reuquired db
                            inspect(db); //ensures url exists
                            var status =
                                db.serverStatus(); //provides the status of url

                            // ignore: avoid_print
                            print(
                                status); //debug print to ensure sucessful status
                            var collection = db.collection(
                                COLLECTION_NAME_signup); //accesses collection name

                            var data =
                                utf8.encode(g_password); // data being hashed
                            var hashvalue = sha1.convert(data);

                            await collection.insert({
                              "name": g_name,
                              "password": hashvalue.toString(),
                              "email": g_email
                            });
                            var databaseLogin = await mongo.Db.create(
                                MONGO_URL_LOGIN); //wait for check in table to open
                            await databaseLogin.open(); //wait for it to open
                            var userCollection = // connect to the specific table
                                databaseLogin.collection(COLLECTION_NAME_users);

                            await userCollection.insert({
                              "email": g_email,
                              "isCheckedIn": "false",
                            });

                            // final arrData = await collection.find().toList();
                            // return arrData;

                            Navigator.pushNamed(context, 'login_page');
                          },
                          // what actions are taken the button is pressed.
                          icon: const Icon(Icons
                              .arrow_forward), // the icon nested inside the circle button, currently shown as an arrow.
                        ),
                      ),
                    ]),

                const SizedBox(
                  //const value of the text box.
                  height: 40, //the size of the box that lets the user type in.
                ),

                Row(
                    // row widget
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, //divides the space between the children evenly.
                    children: [
                      // sets the children in the row.
                      TextButton(
                        //enables a text button feature to be shown on the app.
                        onPressed: () {
                          // on press funtion.
                          Navigator.pushNamed(context,
                              'login_page'); //when log in page is pressed, the app redirects to login page.
                        },
                        child: const Text(
                          'Login', //displays Login string
                          style: TextStyle(
                            decoration: TextDecoration
                                .underline, //how the string is displayed 'Login'
                            fontSize: 18, //font size of the string 'Login'
                            color: Colors.white, //color of the string 'Login'
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
