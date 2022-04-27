import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final GestureTapCallback click;
  final String label;
  final Color color;
  DeleteButton(this.click, this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      height: 40.0,
      minWidth: 80.0,
      elevation: 0,
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 40, right: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: color,
      textColor: Colors.white,
      child: Text(
        label,
        style: TextStyle(fontSize: 16),
      ),
      onPressed: click,
    );
  }
}
