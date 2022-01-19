import 'package:Smart_Pill_Dispenser_App/components/defaultButton.dart';
import 'package:Smart_Pill_Dispenser_App/components/scheduleCard.dart';
import 'package:Smart_Pill_Dispenser_App/db/firebaseRefs.dart';
import 'package:Smart_Pill_Dispenser_App/modules/schedule.dart';
import 'package:Smart_Pill_Dispenser_App/screens/caretaker/caretakerAddScheduleItem.dart';
import 'package:Smart_Pill_Dispenser_App/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class CaretakerViewScheduleScreen extends StatefulWidget {
  final String patientId;
  const CaretakerViewScheduleScreen({Key? key, required this.patientId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CaretakerViewScheduleScreenState();
  }
}

class CaretakerViewScheduleScreenState
    extends State<CaretakerViewScheduleScreen> {
  List<ScheduleItem> patientSchedules = <ScheduleItem>[];

  var moment = Moment.now();

  List<String> dateList = [];

  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // getScheduleList();
  }

  Widget scheduleListBuilder(BuildContext context) {
    Query schedulesRef = FirebaseRefs.dbRef
        .child(FirebaseRefs.getScheduleListRef(widget.patientId));

    return StreamBuilder(
        stream: schedulesRef.onValue,
        builder: (context, AsyncSnapshot dataSnapshot) {
          List<ScheduleItem> listdata = [];
          if (dataSnapshot.hasData) {
            // print(dataSnapshot.hasData);
            DatabaseEvent event = dataSnapshot.data;
            if (event.snapshot.exists) {
              Map<dynamic, dynamic> result = event.snapshot.value as Map;

              // print(result.values);

              patientSchedules.clear();
              result.keys.forEach((key) {
                var element = result[key];
                patientSchedules.add(ScheduleItem.fromJson(element, key));
              });
              var dateToday = moment.format('yyyy-MM-dd');
              dateList.add(dateToday);
              print(dateList);
              dateList.forEach((date) {
                listdata.addAll(patientSchedules.where((element) {
                  return element.date == date;
                }));
              });
            }
          }
          // if (listdata.length == 0) {
          //   listdata.add(
          //     Text("Please add schedule items."),
          //   );
          // }

          // return SliverList(
          //   delegate: SliverChildListDelegate(<Widget>[
          //     Column(
          //         // mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[...listdata]),
          //   ]),
          // );
          return GroupedListView<ScheduleItem, String>(
              elements: listdata,
              groupBy: (schedule) => schedule.date,
              groupSeparatorBuilder: (String groupByValue) {
                String formatDate = new DateFormat("MMM d")
                    .format(DateTime.parse(groupByValue))
                    .toString();
                return Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    formatDate,
                  ),
                );
              },
              itemComparator: (item1, item2) =>
                  item1.date.compareTo(item2.date), // optional
              useStickyGroupSeparators: true, // optional
              floatingHeader: true, // optional
              order: GroupedListOrder.ASC,
              itemBuilder: (context, schedule) {
                return ScheduleCard(
                  patientId: widget.patientId,
                  scheduleItem: schedule,
                );
              });
        });
  }

  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('Schedules'),
          backgroundColor: ColorThemes.colorOrange,
          foregroundColor: ColorThemes.colorWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: screenWidth / 15),
              child: SizedBox(
                width: 35.0,
                height: 5.0,
                child: FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      toAddSchedule(context);
                    }),
              ),
            )
          ],
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: scheduleListBuilder(context),

            // ListView(children: <Widget>[

            //   Padding(
            //       padding: EdgeInsets.only(
            //         top: screenHeight / 35,
            //         left: 33,
            //         right: 20,
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           // CustomScrollView(shrinkWrap: true, slivers: <Widget>[
            //           //   SliverPadding(

            //           //     padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
            //           //     sliver: scheduleListBuilder(context),
            //           //   ),
            //           // ]),
            //         ],
            //       ))
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: DefaultButton(() {
              setState(() => {toGetFututreSchedules(context)});
            }, ">", ColorThemes.colorGreen),
          ),
        ]));
  }

  // void getScheduleList() async {
  //   Query schedulesRef =

  //       //TODO: add try catch and snackbar
  //       FirebaseRefs.dbRef
  //           .child(FirebaseRefs.getScheduleListRef(widget.patientId));

  //   DataSnapshot event = await schedulesRef.get();
  //   Map<dynamic, dynamic> result = event.value as Map;
  //   print("schedues -----");
  //   print(result.values);

  //   patientSchedules.clear();
  //   result.keys.forEach((key) {
  //     var element = result[key];
  //     patientSchedules.add(ScheduleItem.fromJson(element, key));
  //   });
  //   setState(() {});
  // }

  void toAddSchedule(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CaretakerAddScheduleItemScreen(
          patientId: widget.patientId,
          isEdit: false,
        ),
      ),
    );
  }

  void toGetFututreSchedules(BuildContext context) {
    var nextDay = moment.add(days: 1);
    setState(() {
      moment = nextDay;
    });
    print('Moment' + moment.toString());
    //   var momentNew = moment.add(days: 1);
    //   var nextDate = momentNew.format('yyyy-MM-dd');
    //   print('Nextday' + nextDate);
    //   listdata.addAll(patientSchedules.where((element) {
    //     return element.date == nextDate.toString();
    //   }));
    //   setState(() {
    //     moment = momentNew;
    //   });
    //   print('Moment' + moment.toString());
    // }
  }
}
