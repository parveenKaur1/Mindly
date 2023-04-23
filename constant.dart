// ignore_for_file: constant_identifier_names

/*
* NAME OF CODE ARTIFACT - constant.dart
* BRIEF DESCRIPTION - this file helps link the code to the db 
* PROGRAMMERS NAME - Jowaki Merani
* DATE CODE CREATED - October 23rd, 2022
* DATE REVISED - October 23rd 
                 Jowaki Merani & Parveen Kaur - created the file with the required login details  
* PRECONDITIONS: NONE- requires no input 
* POSTCONDITIONS: NONE- just creates shortcuts for specific mongodb URL's
* ERRORS AND EXCEPTIONS: NONE
* Side EFFECTS: NONE
* INVARIANTS: NONE
* KNOWN FAULT - None
* KNOWN FAULT - None
* KNOWN FAULT - None
*/

const MONGO_URL_Signup =
    "mongodb+srv://jjep2022:Capstone2022@mindlycapstone.pqp946b.mongodb.net/SignUp?retryWrites=true&w=majority";
const COLLECTION_NAME_signup = "UserInfo";

const MONGO_URL2_journal =
    "mongodb+srv://jjep2022:Capstone2022@mindlycapstone.pqp946b.mongodb.net/Journal?retryWrites=true&w=majority";
const COLLECTION_NAME_journal = "Entry";

const MONGO_URL_CHECKIN =
    "mongodb+srv://jjep2022:Capstone2022@mindlycapstone.pqp946b.mongodb.net/Questionnaire?retryWrites=true&w=majority";
const COLLECTION_NAME_checkin = "checkin";

const MONGO_URL_LOGIN =
    "mongodb+srv://jjep2022:Capstone2022@mindlycapstone.pqp946b.mongodb.net/Login?retryWrites=true&w=majority";
const COLLECTION_NAME_users = "Users";

// const MONGO_URL_Quiz =
//     "mongodb+srv://jjep2022:Capstone2022@mindlycapstone.pqp946b.mongodb.net/Questionnaire?retryWrites=true&w=majority";
// const COLLECTION_NAME_quiz = "checkin";
