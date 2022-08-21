import 'package:http/http.dart' as http;
import 'package:saeed/Model/SignUpModel.dart';
import 'dart:convert' as convert;


class RemoteService{

  static final domain="https://almandoob.app/api/v1/";
  static final userRegister="register";

  static Future<SignUpModel> insertRegisterData(Map<String, String> map)async{
    var headers = {
      'Accept': 'application/json'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://almandoob.app/api/v1/register'));
    request.fields.addAll({
      'first_name': map["fname"].toString(),
      'email': map["email"].toString(),
      'password': map["password"].toString(),
      'password_confirmation': map["password"].toString(),
      'type': 'rider',
      'last_name': map["lname"].toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      final SignUpModel res = signUpModelFromJson(await response.stream.bytesToString());
      print(await response.stream.bytesToString());
      return res;

    }
    else {
      print(response.reasonPhrase);
      return SignUpModel(token: "", message: "");
    }

  }
}