//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:phone_verification/main.dart';
import 'package:phone_verification/screens/bottom.dart';
import 'package:phone_verification/screens/map.dart';
import 'home1.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification/screens/login_screen.dart';
import 'Sample.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User usernya = _auth.currentUser;
final String uid = usernya.uid;
final ref = FirebaseDatabase.instance.reference().child('Users').child(uid);
String fName;
String lname;
String email;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // This function is triggered when the "Save" button is pressed
  void _saveForm() {
    final bool isValid = _formKey.currentState.validate();
    if (isValid) {
      if (kDebugMode) {
        ref.set({
          "f_name": fName,
          "l_name": lname,
          "Email": email,
          "pimg": " ",
          "img": " ",
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bottomnav()),
        );
      }
      // And do something here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 35),
              Image.asset('assets/user_details.JPG'),
              TextFormField(
                validator: (value) {
                  if (value != null && value.trim().length < 3) {
                    return 'This field requires a minimum of 3 characters';
                  }

                  return null;
                },
                onChanged: (val) {
                  fName = val;
                },
                decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5))),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value != null && value.trim().length < 3) {
                    return 'This field requires a minimum of 3 characters';
                  }

                  return null;
                },
                onChanged: (val) {
                  lname = val;
                },
                decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5))),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value != null && value.trim().length < 3) {
                    return 'This field requires a minimum of 3 characters';
                  }

                  return null;
                },
                onChanged: (val) {
                  email = val;
                },
                decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 244, 54, 54),
                            width: 5))),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: const Icon(Icons.save),
                label: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 114, 76, 175),
                  onPrimary: Colors.white,
                  shadowColor: Color.fromARGB(255, 168, 105, 240),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(400, 40), //////// HERE
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
