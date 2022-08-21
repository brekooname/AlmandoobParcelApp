// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
   required this.token,
    required this.message,
  });

  String token;
  String message;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "message": message,
  };
}
