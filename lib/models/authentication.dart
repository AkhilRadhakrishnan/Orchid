class LoginModel {
  LoginModel(
      {this.status, this.message, this.otp, this.access_token, this.user});

  bool? status;
  String? message;
  String? otp;
  String? access_token;
  User? user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      user: User.fromJson(json["user"]),
      status: json["status"],
      message: json["message"],
      otp: json["otp"],
      access_token: json["access_token"]);
}

class User {
  User(
      {this.id,
      this.fileNo,
      this.email,
      this.name,
      this.contactNo,
      this.image,
      this.gender,
      this.dob});
  String? id;
  String? fileNo;
  String? name;
  String? email;
  String? image;
  String? contactNo;
  String? gender;
  String? dob;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["custid"],
      fileNo: json["file_no"],
      email: json["email"],
      name: json["cust_name"],
      contactNo: json["contact_no"],
      image: json["image"],
      gender: json["gender"],
      dob: json["dob"]);

  Map<String, dynamic> toJson() {
    return {
      'custid': id,
      'file_no': fileNo,
      'email': email,
      'cust_name': name,
      'contact_no': contactNo,
      'image': image,
      'gender': gender,
      'dob': dob
    };
  }
}
