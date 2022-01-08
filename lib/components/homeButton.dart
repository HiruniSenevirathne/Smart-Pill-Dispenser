import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final GestureTapCallback click;
  final String label;

  HomeButton(this.click, this.label);
  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      height: 100.0,
      minWidth: 300.0,
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: ColorThemes.customButtonColor,
      textColor: Colors.white,
      child: Text(
        label,
        style: TextStyle(fontSize: 23),
      ),
      onPressed: click,
    );
  }
}
