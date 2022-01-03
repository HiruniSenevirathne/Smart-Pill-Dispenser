import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(left: 15.0, right: 10.0, bottom: 94.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 100,
                ),
                Text('Welcome to Smart pill dispenser',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.left),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.left),
              ],
            )));
  }
}
