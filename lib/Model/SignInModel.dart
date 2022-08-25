// To parse required this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  SignInModel({
    required this.success,
    required this.message,
    required this.userData,
  });

  bool success;
  String message;
  UserData userData;

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
    success: json["success"],
    message: json["message"],
    userData: UserData.fromJson(json["userData"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "userData": userData.toJson(),
  };
}

class UserData {
  UserData({
    required this.cId,
    required this.cFname,
    required this.cLname,
    required this.cEmail,
    required this.cPhone,
    required this.cPassword,
    required this.cDate,
    required this.cTime,
    required this.firebaseToken,
  });

  String cId;
  String cFname;
  String cLname;
  String cEmail;
  String cPhone;
  String cPassword;
  String cDate;
  String cTime;
  String firebaseToken;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    cId: json["c_id"],
    cFname: json["c_fname"],
    cLname: json["c_lname"],
    cEmail: json["c_email"],
    cPhone: json["c_phone"],
    cPassword: json["c_password"],
    cDate: json["c_date"],
    cTime: json["c_time"],
    firebaseToken: json["firebase_token"],
  );

  Map<String, dynamic> toJson() => {
    "c_id": cId,
    "c_fname": cFname,
    "c_lname": cLname,
    "c_email": cEmail,
    "c_phone": cPhone,
    "c_password": cPassword,
    "c_date": cDate,
    "c_time": cTime,
    "firebase_token": firebaseToken,
  };
}
