import 'dart:developer';
import 'package:flutter_application_1/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';


/*
* NAME OF CODE ARTIFACT - display.dart
* BRIEF DESCRIPTION -  
* PROGRAMMERS NAME - Jowaki Merani
* DATE CODE CREATED - November 1, 2022
* DATE REVISED - 
* PRECONDITIONS - None
* POSTCONDITIONS - connects to the database for when the user signs up 
* ERROR AND EXCEPTION CONDITION: None
* SIDE EFFECTS: None
* INVARIANTS: None
* KNOWN FAULT - None
*/


class MongoDbDatabase {
  //  static get email => null;  static get password => null; static get username => null;
 
//create class to connect db 
  static connect() async {//conect function used to connect to db 
    var db = await Db.create(MONGO_URL_Signup);
                    // Match(where.eq('name', 'hello')).toList();

                var coll = db.collection('find');
                // Fluent way
                // var collection;
                var temp = await coll.find(where.eq('name', 'hello')).toList();
                // or Standard way
                // await collection.find({'name': 'Tom', 'rating': {r'$gt': 10}}).toList();
                temp.forEach(print);
    // ignore: avoid_print
    // print(await collection.find().toList());//prinst the data added to the db 

  }
}