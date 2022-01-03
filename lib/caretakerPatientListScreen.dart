import 'package:flutter/material.dart';

class CaretakerPatientListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Pill Dispenser'),
          backgroundColor: Color(0xff140078),
        ),
        body: Container(
            margin: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            child: ListView(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Patients',
                            style: TextStyle(fontSize: 40, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 20),
                          child: Row(children: <Widget>[
                            SizedBox(
                                width: 70.0,
                                height: 70.0,
                                child: new FloatingActionButton(
                                    child: new Icon(
                                      Icons.add,
                                      size: 40,
                                    ),
                                    backgroundColor: new Color(0xFF8559da),
                                    onPressed: () {})),
                            SizedBox(width: 30, height: 5),
                            Text(
                              'Add a New Patient',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(children: <Widget>[
                            SizedBox(
                              width: 75.0,
                              height: 75.0,
                              child: getImageAsset(),
                            ),
                            SizedBox(width: 30, height: 5),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Hiruni Senevirathne',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  SizedBox(width: 5, height: 10),
                                  Row(children: <Widget>[
                                    new MaterialButton(
                                        height: 43.0,
                                        minWidth: 120.0,
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 12,
                                            right: 12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        color: Color(0xff512DA8),
                                        textColor: Colors.white,
                                        child: Text(
                                          'View',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () {
                                          //
                                        }),
                                    SizedBox(width: 5, height: 5),
                                    new MaterialButton(
                                        height: 43.0,
                                        minWidth: 120.0,
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 12,
                                            right: 12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        color: Color(0xff512DA8),
                                        textColor: Colors.white,
                                        child: Text(
                                          'Schedule',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () {
                                          //
                                        }),
                                  ])
                                ])
                          ]),
                        ),
                        Divider(color: Colors.black)
                      ]))
            ])));
  }
}

Widget getImageAsset() {
  AssetImage assetImage = AssetImage('images/avater.jpg');
  Image image = Image(
    image: assetImage,
  );
  return Container(
    child: image,
  );
}
