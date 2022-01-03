class Schedule {
  int? id;
  late String medicationType;
  late String date;
  late String time;
  late String comments;
  late String status;
  late String unixTimestamp;

  Schedule(
      {this.id,
      required this.medicationType,
      required this.date,
      required this.time,
      required this.comments,
      required this.status,
      required this.unixTimestamp});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicationType = json['medication_type'];
    date = json['date'];
    time = json['time'];
    comments = json['comments'];
    status = json['status'];
    unixTimestamp = json['unix_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medication_type'] = this.medicationType;
    data['date'] = this.date;
    data['time'] = this.time;
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['unix_timestamp'] = this.unixTimestamp;
    return data;
  }
}
