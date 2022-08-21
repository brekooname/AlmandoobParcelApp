

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
    showpass1.value=!showpass1.value;
  }

  submitButton() {
    if (formKey.currentState!.validate()) {

      inserData();
    }
  }

  inserData()async{

    Map<String,String> map=new Map();

    map['fname']=firstnameTextCon.value.text;
    map['lname']=firstnameTextCon.value.text;
    map['email']=firstnameTextCon.value.text;
    map['phone']=firstnameTextCon.value.text;
    map['password']=firstnameTextCon.value.text;

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
      Get.snackbar("message", "Some Thing Wrong Try Again",snackPosition: SnackPosition.BOTTOM);

    }

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("die");
  }

}