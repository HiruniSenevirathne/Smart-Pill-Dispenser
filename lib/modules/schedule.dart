class ScheduleItem {
  late String scheduleId;
  late String time;
  late String date;
  late String medicationType;
  late String comment;
  int? dispenserSlot;

  ScheduleItem({
    required this.time,
    required this.date,
    required this.medicationType,
    required this.comment,
    this.dispenserSlot,
  });

  ScheduleItem.fromJson(Map<dynamic, dynamic> json, String scheduleId_) {
    time = json['time'];
    date = json['date'];
    medicationType = json['medication_type'];
    comment = json['comment'];
    scheduleId = scheduleId_;
    dispenserSlot = json['dispenserSlot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['date'] = this.date;
    data['medication_type'] = this.medicationType;
    data['comment'] = this.comment;
    data['dispenserSlot'] = this.dispenserSlot;
    return data;
  }
}
