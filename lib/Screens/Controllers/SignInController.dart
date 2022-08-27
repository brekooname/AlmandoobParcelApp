

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saeed/Model/SignInModel.dart';
import 'package:saeed/Model/SignUpModel.dart';
import 'package:saeed/RemoteServices/RemoteService.dart';
import 'package:saeed/Screens/Home.dart';
import 'package:saeed/Screens/SignInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController
{
  var showpass1=true.obs;

  var SiginformKey ;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SiginformKey= GlobalKey<FormState>();

  }


   var emailTextCon=TextEditingController().obs;
  var passwordTextCon=TextEditingController().obs;


  var signupModel= SignUpModel(message: "",success: false).obs;

  var isLoading=false.obs;

  changShowPass1(){
    showpass1.value=!showpass1.value;
  }


  submitButton() {
    if (SiginformKey.currentState!.validate()) {

      inserData();
    }
  }

  inserData()async{

    Map<String,String> map=new Map();


    map['email']=emailTextCon.value.text;
    map['password']=passwordTextCon.value.text;
      try{

      isLoading(true);

        await   RemoteService.signinUser(map).then((value) async {
        if(value.success)
        {
          await saveUserData(value.userData);

          Get.snackbar("message", "SignIn Successful",snackPosition: SnackPosition.BOTTOM);

          Get.off(()=>Home());


        }
        else{
         // Get.snackbar("message", "${value.message}",snackPosition: SnackPosition.BOTTOM);

        }

      });
    }
    finally{
      isLoading(false);
      //Get.snackbar("message", "Some Thing Wrong Try Again",snackPosition: SnackPosition.BOTTOM);

    }

  }
  saveUserData(UserData userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('c_id', userData.cId);
    prefs.setString('c_fname', userData.cFname);
    prefs.setString('c_lname', userData.cLname);
    prefs.setString('c_email', userData.cEmail);
    prefs.setString('c_phone', userData.cPhone);
    prefs.setString('c_password', userData.cPassword);
    prefs.setString('firebase_token', userData.firebaseToken);
    prefs.setBool('isLogin', true);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("die");

  }

}