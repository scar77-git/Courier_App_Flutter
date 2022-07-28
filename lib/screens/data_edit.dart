import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User usernya = _auth.currentUser;
final String uid = usernya.uid;
final ref = FirebaseDatabase.instance.reference().child('Users').child(uid);
String first;
String second;
String email;

class Editdata extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Editdata> {
  Future<String> getUsername() async {
    return ref.once().then((DataSnapshot snap) {
      final String userName = snap.value['f_name'].toString();
      print(userName);
      return userName;
    });
  }

  Future<String> getlname() async {
    return ref.once().then((DataSnapshot snap) {
      final String userName = snap.value['l_name'].toString();
      print(userName);
      return userName;
    });
  }

  Future<String> getemail() async {
    return ref.once().then((DataSnapshot snap) {
      final String userName = snap.value['Email'].toString();
      print(userName);
      return userName;
    });
  }

  String msg = 'NO ORDERS FOUND';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "EDIT YOUR DATA HERE",
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..color = Color.fromARGB(255, 130, 76, 175),
                  ),
                ),
                FutureBuilder<String>(
                  future: getUsername(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TextFormField(
                        initialValue: snapshot.data,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Enter new value here',
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.update({"f_name": first});
                            },
                            icon: Icon(
                              Icons.save,
                              color: Color.fromARGB(255, 33, 243, 68),
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          first = val;
                        },
                      );
                    } else {
                      return Text(
                        "Loading data...",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      );
                    }
                  },
                ),
                SizedBox(height: 10),
                FutureBuilder<String>(
                  future: getlname(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TextFormField(
                        initialValue: snapshot.data,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Enter new value here',
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.update({"l_name": second});
                            },
                            icon: Icon(
                              Icons.save,
                              color: Color.fromARGB(255, 33, 243, 114),
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          second = val;
                        },
                      );
                    } else {
                      return Text(
                        "Loading data...",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder<String>(
                  future: getemail(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TextFormField(
                        initialValue: snapshot.data,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter new value here',
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.update({"Email": email});
                            },
                            icon: Icon(
                              Icons.save,
                              color: Color.fromARGB(255, 33, 243, 114),
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          email = val;
                        },
                      );
                    } else {
                      return Text(
                        "Loading data...",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
