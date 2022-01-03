class Patients {
  int? id;
  late String patientName;
  // late String patientPhoneNo;
  late String patientAge;
  String? image;

  Patients(
      {this.id,
      required this.patientName,
      // required this.patientPhoneNo,
      required this.patientAge,
      this.image});

  Patients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patient_name'];
    // patientPhoneNo = json['patient_phoneNo'];
    patientAge = json['patient_age'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_name'] = this.patientName;
    // data['patient_phoneNo'] = this.patientPhoneNo;
    data['patient_age'] = this.patientAge;
    data['image'] = this.image;
    return data;
  }
}
