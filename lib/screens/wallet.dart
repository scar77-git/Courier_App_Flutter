import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Wallet> {
  String msg = 'NO DATA AVAILABLE';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  msg,
                  style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                ),
                RaisedButton(
                  child: Text(
                    "Click Here",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.yellow,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
