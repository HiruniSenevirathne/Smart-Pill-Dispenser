import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final GestureTapCallback click;
  final String label;

  HomeButton(this.click, this.label);
  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      height: 65.0,
      minWidth: 300.0,
      elevation: 0,
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: ColorThemes.colorGreen,
      textColor: Colors.white,
      child: Text(
        label,
        style: TextStyle(fontSize: 23),
      ),
      onPressed: click,
    );
  }
}
