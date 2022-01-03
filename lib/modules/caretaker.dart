class Caretaker {
  int? id;
  late String caretakerName;
  late String email;
  late String phoneNo;

  Caretaker(
      {this.id,
      required this.caretakerName,
      required this.email,
      required this.phoneNo});

  Caretaker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caretakerName = json['caretaker_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['caretaker_name'] = this.caretakerName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}
