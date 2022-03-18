class ScheduleItem {
  late String scheduleId;
  late String time;
  late String date;
  late String medicationType;
  late String comment;
  int? dispensedTime;
  String? status;
  int? dispenserSlot;

  static final String STATUS_Pending = "0";
  static final String STATUS_Taken = "1";
  static final String STATUS_NotTaken = "2";
  ScheduleItem(
      {required this.time,
      required this.date,
      required this.medicationType,
      required this.comment,
      this.dispenserSlot,
      this.status,
      this.dispensedTime});

  ScheduleItem.fromJson(Map<dynamic, dynamic> json, String scheduleId_) {
    time = json['time'];
    date = json['date'];
    medicationType = json['medication_type'];
    comment = json['comment'];
    scheduleId = scheduleId_;
    dispenserSlot = json['dispenser_slot'];
    dispensedTime = json['dispensed_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['date'] = this.date;
    data['medication_type'] = this.medicationType;
    data['comment'] = this.comment;
    data['dispenser_slot'] = this.dispenserSlot;
    data['dispensed_time'] = this.dispensedTime;
    data['status'] = this.status;
    return data;
  }
}
