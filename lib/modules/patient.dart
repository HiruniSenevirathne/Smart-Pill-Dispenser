class Patients {
  late String patientId;
  late String patientName;
  // late String patientPhoneNo;
  late String patientAge;
  String? image;

  Patients(
      {required this.patientId,
      required this.patientName,
      // required this.patientPhoneNo,
      required this.patientAge,
      this.image});

  Patients.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    // patientPhoneNo = json['patient_phoneNo'];
    patientAge = json['patient_age'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.patientId;
    data['patient_name'] = this.patientName;
    // data['patient_phoneNo'] = this.patientPhoneNo;
    data['patient_age'] = this.patientAge;
    data['image'] = this.image;
    return data;
  }
}
