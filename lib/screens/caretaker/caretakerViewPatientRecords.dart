import 'package:Smart_Pill_Dispenser_App/components/recordListBuilder.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:flutter/material.dart';

class CaretakerViewPateintRecords extends StatefulWidget {
  final String patientId;
  const CaretakerViewPateintRecords({Key? key, required this.patientId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CaretakerViewPateintRecordsState();
  }
}

class CaretakerViewPateintRecordsState
    extends State<CaretakerViewPateintRecords> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Records'),
          backgroundColor: ColorThemes.colorOrange,
          foregroundColor: ColorThemes.colorWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: RecordListBuilder(patientId: widget.patientId),
          ),
        ]));
  }
}
