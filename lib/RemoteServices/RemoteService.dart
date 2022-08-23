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
    request.fields.addAll(map);

    // request.fields.addAll({
    //   'first_name': 'saeed',
    //   'email': 'saeedcs93m18@gm.c',
    //   'password': 'saeed123',
    //   'password_confirmation': 'saeed123',
    //   'type': 'rider',
    //   'last_name': 'sikandar'
    // });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      final SignUpModel res = signUpModelFromJson(await response.stream.bytesToString());
  //    print(await response.stream.bytesToString()+"ll");
      return res;

    }
    else {
      print("${response.reasonPhrase} fdfdf");
      return SignUpModel(token: "", message: "");
    }

  }
}