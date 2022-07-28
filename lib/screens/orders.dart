import 'package:flutter/material.dart';
import 'map.dart';

class Orders extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Orders> {
  String msg = 'NO ORDERS FOUND';
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
                Image.asset('assets/order_pic.JPG'),
                RaisedButton(
                  child: Text(
                    "BOOK NOW",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Maps()),
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
