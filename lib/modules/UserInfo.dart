class UserInfo {
  late String mode;
  late String userId;
  late String lastName;
  late String firstName;
  late String email;

  UserInfo(
      {required this.mode,
      required this.userId,
      required this.lastName,
      required this.firstName,
      required this.email});

  UserInfo.fromJson(Map<dynamic, dynamic> json) {
    mode = json['mode'];
    userId = json['user_id'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    email = json['email'];
    print(" json['last_name']" + json['last_name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['user_id'] = this.userId;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    return data;
  }
}
