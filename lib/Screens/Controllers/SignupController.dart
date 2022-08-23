

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saeed/Model/SignUpModel.dart';
import 'package:saeed/RemoteServices/RemoteService.dart';

class SignupController extends GetxController
{
  var showpass1=true.obs;

  var showpass2=true.obs;
  var formKey = GlobalKey<FormState>();


  var firstnameTextCon=TextEditingController().obs;
  var lastnameTextCon=TextEditingController().obs;
  var emailTextCon=TextEditingController().obs;
  var phoneTextCon=TextEditingController().obs;
  var passwordTextCon=TextEditingController().obs;
  var confpasswordTextCon=TextEditingController().obs;


  var signupModel= SignUpModel(message: '', token: '').obs;

  var isLoading=false.obs;

  changShowPass1(){
    showpass1.value=!showpass1.value;
  }

  changShowPass2(){
    showpass2.value=!showpass2.value;
  }

  submitButton() {
    if (formKey.currentState!.validate()) {

      inserData();
    }
  }

  inserData()async{

    Map<String,String> map=new Map();
    //
    // {
    //   'first_name': map["fname"].toString(),
    // 'email': map["email"].toString(),
    // 'password': map["password"].toString(),
    // 'password_confirmation': map["password"].toString(),
    // 'type': 'rider',
    // 'last_name': map["lname"].toString()
    // }

    map['first_name']=firstnameTextCon.value.text;
    map['last_name']=lastnameTextCon.value.text;
    map['email']=emailTextCon.value.text;
    map['phone']=phoneTextCon.value.text;
    map['password']=passwordTextCon.value.text;
    map['password_confirmation']=confpasswordTextCon.value.text;
    map['type']="rider";

    try{

      isLoading(true);

        await   RemoteService.insertRegisterData(map).then((value) {
        if(value.message.toString()=="Successfully Login")
        {
          Get.snackbar("message", "Registration Successful",snackPosition: SnackPosition.BOTTOM);
        }
        else{
          Get.snackbar("message", "Some Thing Wrong Try Again",snackPosition: SnackPosition.BOTTOM);

        }

      });
    }
    finally{
      isLoading(false);
      //Get.snackbar("message", "Some Thing Wrong Try Again",snackPosition: SnackPosition.BOTTOM);

    }

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("die");
  }

}