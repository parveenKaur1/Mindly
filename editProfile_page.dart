/*
* NAME OF CODE ARTIFACT - editProfile_page.dart
* BRIEF DESCRIPTION - This is the page for users to edit their information 
* PROGRAMMERS NAME - Parveen Kaur
* DATE CODE CREATED - 24th February 2023
* DATE REVISED -
* PRECONDITIONS - user must navigate to edit profile page.
* POSTCONDITIONS - profile page is modified from the user.
* ERROR AND EXCEPTION CONDITION: None
* SIDE EFFECTS: None
* INVARIANTS: None
* KNOWN FAULT - None
*/
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/personal%20details/profile.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
// import 'package:mongo_dart/mongo_dart.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import '../constant.dart';

class EditProfileUI extends StatefulWidget {
  String email;
  String password;
  String name;
  //creates a constructor with necessary parameters
  EditProfileUI(
      {required this.email, required this.password, required this.name});
  //creates a nother function that takes specific parameters
  _EditProfileUIState createState() => _EditProfileUIState(
      email: '$email', password: '${password}', name: '${name}');
}

// function that extends state
class _EditProfileUIState extends State<EditProfileUI> {
  bool isObscurePassword = true; //check if password
  // ignore: non_constant_identifier_names
  //variables needed to extract or update information
  String g_email = "";
  String g_name = "";
  String g_password = "";

  String email;
  String password;
  String name;

// constructor for this state
// takes necessary paramters

// this state essentially created the entire UI of the page
// there are three boxes for name, email and password where users are able to edit
//once edited, information is sent to database and updated accordingly
  _EditProfileUIState(
      {required this.email, required this.password, required this.name});
  // build of official page
  Widget build(BuildContext context) {
    // initialize global variables to be variables coming in
    g_email = email;
    g_name = name;
    g_password = password;

    //scaffold
    return Scaffold(
        //creating the top bar on the screen
        appBar: AppBar(
          //text
          title: Text('Mindly Edit Profile'),
          //arrow to go back to previous page
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            //once pressed, push all changed data and go to previous page
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  // if tapped, go to this page
                  builder: (context) => Profile_pg(
                        email: ('${g_email}'),
                        password: ('${g_password}'),
                        name: ('${g_name}'),
                      )));
            },
          ),
        ),
        ////creating the boxes
        body: Container(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15),
            child: GestureDetector(
              //for image
              // onTap: () {
              //   FocusScope.of(context).unfocus();
              // },
              // page is list view
              child: ListView(
                children: [
                  Center(
                    //center it and stack them
                    child: Stack(
                      children: [
                        Container(
                            //container properties
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border:
                                    // this is to create the image
                                    Border.all(width: 4, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1))
                                ],
                                //shape of box which is circle
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  //image from network
                                  image: NetworkImage(
                                      'https://as2.ftcdn.net/v2/jpg/05/48/94/67/1000_F_548946790_ipaWsWpiJO5XLnkNLIAd4w18ES4pPIke.jpg'),
                                ))),
                        //position of the box for small edit icon image
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                //container properties
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 4, color: Colors.white),
                                    color: Colors.blue),
                                child: Icon(
                                  //icon to display
                                  Icons.edit,
                                  color: Colors.white,
                                )))
                      ],
                    ),
                  ),
                  // call necessary functions with necessary hint txts and current variables
                  // also mention is text is a password or not
                  SizedBox(height: 30),
                  buildTextFieldName("Full Name", '${name}', false),
                  buildTextEmail("Email", '$email', false),
                  buildTextPass("Password", '${password}', true),
                  SizedBox(height: 30),
                  Row(
                    // fix spacing between buttons
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          //route to previous page
                          Navigator.of(context).push(MaterialPageRoute(
                              // if tapped, go to this page
                              builder: (context) => Profile_pg(
                                    email: ('${email}'),
                                    password: ('${password}'),
                                    name: ('${name}'),
                                  )));
                        },
                        child: Text(
                          // cancel button which just takes you back to previous page
                          "Cancel",
                          //styling the text
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black,
                          ),
                        ),
                        //creating next
                        style: OutlinedButton.styleFrom(
                            // changing the aesthetic of buttons
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            // radius of button
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      ElevatedButton(
                          // what happens when button is pressed
                          onPressed: () async {
                            // create a connection to the database
                            var db = await mongo.Db.create(
                                MONGO_URL_Signup); //wait to locate url
                            // wait for daabase to open
                            await db
                                .open(); //opens the connection to url - reuquired db
                            inspect(db); //ensures url exists
                            var status =
                                db.serverStatus(); //provides the status of url

                            // ignore: avoid_print
                            print(
                                status); //debug print to ensure sucessful status

                            // call the collection
                            var collection =
                                db.collection(COLLECTION_NAME_signup);
                            //update the entry where email is such and set it to following properties
                            collection.update(
                                mongo.where.eq('email', '${email}'),
                                mongo.modify.set('name', '${g_name}'));
                            collection.update(
                                mongo.where.eq('email', '${email}'),
                                mongo.modify.set('password', '${g_password}'));
                            collection.update(
                                mongo.where.eq('email', '${email}'),
                                mongo.modify.set('email', '${g_email}'));
                          },
                          // save texr
                          child: Text(
                            "SAVE",
                            //text style
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                          // button
                          style: ElevatedButton.styleFrom(
                              // color of button
                              primary: Colors.blue,
                              // /symmetry of button
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))))
                    ],
                  )
                ],
              ),
            )));
  }

// when Name field is edited
  Widget buildTextFieldName(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            TextField(
              //creates textField widget
              decoration: InputDecoration(
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,

                // the text box to be filled
                fillColor: Colors.grey.shade100, //  color is set to white.
                filled:
                    true, // sets the entire box to be filled to the color above.
                border: OutlineInputBorder(
                  //outline border widget.
                  borderRadius: BorderRadius.circular(
                      10), // size of the border set to 10.
                ),
              ),
              onChanged: (feeling) =>
                  (g_name = feeling), // store value in global variable
            ),
          ],
        ));
  }

//when password field is updated
  Widget buildTextPass(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
        // padding
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            TextField(
              // check is password
              //creates textField widget
              decoration: InputDecoration(
                labelText: labelText, // label of the field
                floatingLabelBehavior:
                    FloatingLabelBehavior.always, // have it float
                hintText: "********", // hint text

                // the text box to be filled
                fillColor: Colors.grey.shade100, //  color is set to white.
                filled:
                    true, // sets the entire box to be filled to the color above.
                border: OutlineInputBorder(
                  //outline border widget.
                  borderRadius: BorderRadius.circular(
                      10), // size of the border set to 10.
                ),
              ),
              onChanged: (mail) =>
                  (g_password = mail), // store value in global variable
            ),
          ],
        )

        // child: TextField(
        //   obscureText: isPasswordTextField ? true : false,
        //   decoration: InputDecoration(
        //       suffixIcon: isPasswordTextField
        //           ? IconButton(
        //               icon: Icon(
        //                 Icons.remove_red_eye,
        //                 color: Colors.grey,
        //               ),
        //               onPressed: () {},
        //             )
        //           : null,
        //       contentPadding: EdgeInsets.only(bottom: 5),
        //       labelText: labelText,
        //       floatingLabelBehavior: FloatingLabelBehavior.always,
        //       hintText: placeholder,
        //       hintStyle: TextStyle(
        //         fontSize: 16,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.grey,
        //       )),
        // ),
        );
  }

  Widget buildTextEmail(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            TextField(
              //creates textField widget
              decoration: InputDecoration(
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,

                // the text box to be filled
                fillColor: Colors.grey.shade100, //  color is set to white.
                filled:
                    true, // sets the entire box to be filled to the color above.
                border: OutlineInputBorder(
                  //outline border widget.
                  borderRadius: BorderRadius.circular(
                      10), // size of the border set to 10.
                ),
              ),
              onChanged: (mail) =>
                  (g_email = mail), // store value in global variable
            ),
          ],
        ));
  }
}
