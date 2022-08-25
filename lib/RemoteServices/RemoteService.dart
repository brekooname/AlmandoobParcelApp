import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saeed/ApisRegistration/ApisRegistration.dart';
import 'package:saeed/Model/SignUpModel.dart';
import 'dart:convert';

import '../Model/SignInModel.dart';


class RemoteService{

  static Future<SignUpModel> insertRegisterData(Map<String, String> map)async{
    var headers = {
      'Accept': 'application/json'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApisRegistration.domain+ApisRegistration.userRegister));
    request.fields.addAll(map);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {


      var getresponse=await response.stream.bytesToString();

      final SignUpModel res = signUpModelFromJson(getresponse);


      return res;

    }
    else {
      print("${response.reasonPhrase} fdfdf");
      return SignUpModel(message: '', success: false);
    }

  }

  static Future<SignInModel> signinUser(Map<String, String> map)async{

    SignInModel res=SignInModel(success: false, message: "", userData: UserData(cId: "", cFname: "",
        cLname: "", cEmail: "", cPhone: "", cPassword: "", cDate: "", cTime: "", firebaseToken: ""));;

    var headers = {
      'Accept': 'application/json'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApisRegistration.domain+ApisRegistration.userLogin));
    request.fields.addAll(map);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {


      var getresponse=await response.stream.bytesToString();


      var data=json.decode(getresponse);

      if(data['success'])
      {
         res = signInModelFromJson(getresponse);

      }
      else
      {
        Get.snackbar("message", data['message'],snackPosition: SnackPosition.BOTTOM);
      }



      return res;

    }
    else {
      print("${response.reasonPhrase} fdfdf");
      return res;
    }

  }
}