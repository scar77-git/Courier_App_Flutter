import 'package:flutter/material.dart';
import 'package:phone_verification/screens/data_edit.dart';
import 'package:phone_verification/screens/image_edit.dart';
import 'map.dart';
import 'orders.dart';
import 'Profile.dart';
import 'wallet.dart';
import 'bottom.dart';

class Bottomnav1 extends StatelessWidget {
  const Bottomnav1({Key key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom NavBar Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 96, 47, 141),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: const HomePage1(),
    );
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({Key key}) : super(key: key);

  @override
  _HomePageState1 createState() => _HomePageState1();
}

class _HomePageState1 extends State<HomePage1> {
  int pageIndex = 0;

  final pages = [
    Editdata(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 208, 196, 223),
      appBar: AppBar(
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 71, 6, 124),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Bottomnav()));
          },
          child: Wrap(
            children: <Widget>[
              Icon(
                Icons.skip_previous,
                color: Color.fromARGB(255, 230, 226, 235),
                size: 24.0,
              ),
            ],
          ),
        ),
        title: Text(
          "TRANSPAD",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.edit_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          SizedBox(width: 20),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.image_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}
