import 'package:Smart_Pill_Dispenser_App/components/getImageAsset.dart';
import 'package:Smart_Pill_Dispenser_App/components/getImageBuilder.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ViewUserProfile extends StatefulWidget {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;

  const ViewUserProfile(
      {Key? key,
      required this.userId,
      required this.firstName,
      required this.lastName,
      required this.email})
      : super(key: key);
  @override
  State<ViewUserProfile> createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        left: 25.0,
        right: 10.0,
      ),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: screenHeight / 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                        left: screenWidth / 8,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: SizedBox(
                          child: GetImageBuilder(),
                        ),
                      ),
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                            child: Text(
                              'First Name',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: ColorThemes.colorBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                            child: Text(
                              " :",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorThemes.colorBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 15.0, left: 15),
                              child: Text(
                                widget.firstName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          )
                        ]),
                    Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Last Name',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: ColorThemes.colorBlue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          " :",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorThemes.colorBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 15.0, left: 15),
                          child: Text(
                            widget.lastName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            softWrap: true,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ]),
                    Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: ColorThemes.colorBlue),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          " :",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorThemes.colorBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 15.0, left: 15),
                          child: Text(
                            widget.email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            softWrap: true,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
