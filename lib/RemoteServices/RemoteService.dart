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

    try{
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
    catch(e){
      print("${e} error");
      return SignUpModel(message: 'Try Again ${e}', success: false);

    }

  }

  static Future<SignInModel> signinUser(Map<String, String> map)async{

    SignInModel res=SignInModel(success: false, message: "Try Again", userData: UserData(cId: "", cFname: "",
        cLname: "", cEmail: "", cPhone: "", cPassword: "", cDate: "", cTime: "", firebaseToken: ""));;

    var headers = {
      'Accept': 'application/json'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApisRegistration.domain+ApisRegistration.userLogin));
    request.fields.addAll(map);

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var getresponse = await response.stream.bytesToString();


        var data = json.decode(getresponse);

        if (data['success']) {
          res = signInModelFromJson(getresponse);
        }
        else {
          Get.snackbar(
              "message", data['message'], snackPosition: SnackPosition.BOTTOM);
        }


        return res;
      }
      else {
        print("${response.reasonPhrase} fdfdf");
        return res;
      }
    }
    catch(e){
      print("${e} error");
      return res;

    }

  }



  static Future<bool> insertOrderPlace(Map<String, String> map)async{


    var headers = {
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMmQ5M2QwZDM5Mjk1OTE4YjcyY2ViYTM5MWMwODIyYjU3Zjc0ZWViODM1YTBkYThjNjQwOWNkNWUwYjcxNzhjM2I5MmJlOGMxNWE1NGQ3ODYiLCJpYXQiOjE2NjE1NDE2MTIuMTQ4Mjg4LCJuYmYiOjE2NjE1NDE2MTIuMTQ4MjkxLCJleHAiOjE2OTMwNzc2MTIuMTQ2ODM4LCJzdWIiOiIxMSIsInNjb3BlcyI6W119.fnsKEdgVOPBxO4GPwLo8O4VrEW1tz7wnDhvG-_yD4iGJYcI8BGZoT2o87jIvUjaHtcDa0Kkm9-LgFOpydpqZDqU6awF8svrU9xM1exlpy2y9zooMBCBf5gL-oXkAKBE61ns05Fiyw3SI1tKwoUqo-zhN3JgBjTCzd5hEVJN_9qlGkTP7gqqNE3oqh4C2g3h1N2S8sBCWoHPCocQyVFoXdvvRivb8nfZIje6djmqVolZ6-d5OBPWL3_eLQuQmOk06zMdisKLRTbbNRGCUlPc87m32y7pUf0tLAQFk2JKuFCTAXmw_8N8ahjMrlvAfwj-V_mqnrMVSpGYx_EhbKUGLox223nVN4poRTHeVaMgw9URR3xwW6TnXkZ0iDKE-SVs8HTTKIBlj5Ar7SQsRT_gIiCR_g9lrkMuo9dbL76sdDh1ce_BbhzCM3aVTOcLbMP4u0LPNYI5FzSKhqmkdjDoVObVELAxvebY16cu508fnZWLpvaAVZi2WMiHsLmYhWtuPpbQk3LfTurOepYCmD8wyfY3LqZ141qomNYs_KgD0FES4_6JFsLH5eMixjBaXnH5QKo1BtgQ_y9gCA-HytCkuPhRetd0S7HR6wy2c2ns2Z_VeI4WTiWHWiAUJg7CWPebf9jsjLvdZwRlzLFBZjfeVvBX3KTYpXQohykUb0EgixVo'
    };
    var request = http.MultipartRequest('POST', Uri.parse("https://almandoob.app/api/v1/user/parcel"));
    request.fields.addAll(map);

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var getresponse = await response.stream.bytesToString();


        var data = json.decode(getresponse);

        if (data['success']) {

          Get.snackbar(
              "message", data['message'], snackPosition: SnackPosition.BOTTOM);
          return true;

        }
        else {
          Get.snackbar(
              "message", data['message'], snackPosition: SnackPosition.BOTTOM);
          return false;

        }


      }
      else {
        print("${response.reasonPhrase} fdfdf");
        return false;
      }
    }
    catch(e){
      print("${e} error");
      return false;

    }

  }

}