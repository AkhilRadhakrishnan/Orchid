class LoginModel {
  LoginModel({this.status, this.message, this.otp, this.access_token});

  bool? status;
  String? message;
  String? otp;
  String? access_token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      status: json["status"],
      message: json["message"],
      otp: json["otp"],
      access_token: json["access_token"]);
}
