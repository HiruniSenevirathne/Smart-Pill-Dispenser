import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final GestureTapCallback click;
  final String label;
  final Color color;
  DefaultButton(this.click, this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      height: 40.0,
      minWidth: 80.0,
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
//   void toAddSchedule(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (context) => CaretakerViewScheduleScreen()),
//     );
//   }
//   void add() {
//   debugPrint('Add');
// }

}
