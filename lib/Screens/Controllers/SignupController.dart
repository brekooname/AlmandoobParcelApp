

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saeed/Model/SignUpModel.dart';
import 'package:saeed/RemoteServices/RemoteService.dart';
import 'package:saeed/Screens/SignInScreen.dart';

class SignupController extends GetxController
{
  var showpass1=true.obs;

  var showpass2=true.obs;
  var formKey ;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    formKey = GlobalKey<FormState>();
  }



  var firstnameTextCon=TextEditingController().obs;
  var lastnameTextCon=TextEditingController().obs;
  var emailTextCon=TextEditingController().obs;
  var phoneTextCon=TextEditingController().obs;
  var passwordTextCon=TextEditingController().obs;
  var confpasswordTextCon=TextEditingController().obs;


  var signupModel= SignUpModel(message: "",success: false).obs;

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

    // 'fname': 'Amir',
    // 'lname': 'Raza',
    // 'email': 'amir@gmail.com',
    // 'phone': '03121245454',
    // 'password': '123456'

    // map['first_name']=firstnameTextCon.value.text;
    // map['last_name']=lastnameTextCon.value.text;
    // map['email']=emailTextCon.value.text;
    // map['phone']=phoneTextCon.value.text;
    // map['password']=passwordTextCon.value.text;
    // map['password_confirmation']=confpasswordTextCon.value.text;
    // map['type']="rider";

    map['fname']=firstnameTextCon.value.text;
    map['lname']=lastnameTextCon.value.text;
    map['email']=emailTextCon.value.text;
    map['phone']=phoneTextCon.value.text;
    map['password']=passwordTextCon.value.text;
      try{

      isLoading(true);

        await   RemoteService.insertRegisterData(map).then((value) {
        if(value.success)
        {
          Get.snackbar("message", "Registration Successful",snackPosition: SnackPosition.BOTTOM);

          Get.off(()=>SiginScreen());
        }
        else{
          Get.snackbar("message", "${value.message}",snackPosition: SnackPosition.BOTTOM);

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