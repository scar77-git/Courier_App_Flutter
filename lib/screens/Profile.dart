import 'package:flutter/material.dart';
import 'package:phone_verification/screens/bottom2.dart';
import 'package:phone_verification/screens/home_screen.dart';
import 'package:phone_verification/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

String eposta;
final FirebaseAuth _auth = FirebaseAuth.instance;
final User usernya = _auth.currentUser;
final String uid1 = usernya.uid;
final ref = FirebaseDatabase.instance.reference().child('Users').child(uid1);
void abc() {
  ref.once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
  });
}

//DatabaseEvent event = await ref.once();
class Profile extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Profile> {
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

  Future<String> geturl() async {
    return ref.once().then((DataSnapshot snap) {
      final String userName = snap.value['img'].toString();
      print(userName);
      eposta = userName;
      return userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              new Container(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        FutureBuilder<String>(
                          future: getUsername(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
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
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
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
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
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
                    SizedBox(
                      width: 100,
                    ),
                    Column(
                      children: [
                        FutureBuilder<String>(
                          future: geturl(),
                          builder: (context, snapshot) {
                            if (eposta != " ") {
                              return CircleAvatar(
                                radius: 50,
                                child: ClipOval(
                                  child: new SizedBox(
                                    width: 180.0,
                                    height: 180.0,
                                    child: Image.network(
                                      eposta,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return CircleAvatar(
                                radius: 50,
                                child: ClipOval(
                                  child: new SizedBox(
                                    width: 180.0,
                                    height: 180.0,
                                    child: Image.network(
                                      "https://firebasestorage.googleapis.com/v0/b/useapp-34bb9.appspot.com/o/emptprofile.webp?alt=media&token=0d3be244-1d9c-4aef-8a9d-54830c2462e8",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          child: Text(
                            "Edit",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Bottomnav1()));
                          },
                          color: Color.fromARGB(255, 255, 255, 255),
                          textColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              new Container(
                child: Column(children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Contact us",
                      ),
                      Text("For any query or help"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                          ),
                          RaisedButton(
                            child: Text(
                              "Call Us",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          RaisedButton(
                            child: Text(
                              "Mail Us",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                          )
                        ],
                      )
                    ],
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              new Container(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Invite your friends",
                        ),
                        SizedBox(height: 15),
                        Text("If you admire our efforts,"),
                        Text("do share us with your"),
                        Text("friends & family"),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          child: Text(
                            "Invite",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {},
                          color: Color.fromARGB(255, 255, 255, 255),
                          textColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Image.asset('assets/invite_frnds.JPG',
                            height: 200, width: 200),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new Container(
                child: Column(children: [
                  Text("App Version"),
                  Text("1.0.11.03"),
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text(
                      "Log out",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
