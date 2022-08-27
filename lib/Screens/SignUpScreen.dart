import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saeed/Screens/Controllers/SignupController.dart';
import 'package:saeed/Screens/Home.dart';
import 'package:saeed/Screens/SignInScreen.dart';


class SigupScreen extends StatefulWidget {
  const SigupScreen({Key? key}) : super(key: key);

  @override
  State<SigupScreen> createState() => _SigupScreenState();
}

class _SigupScreenState extends State<SigupScreen> {



  SignupController signupController=Get.put(SignupController());
  var defaultColor=Color(0xff1e319d);

  var htextTheme=TextStyle(color: Color(0xff1e319d),fontWeight: FontWeight.bold,fontSize: 30.sp);

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, designSize: const Size(360, 690));


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){

          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.grey,)),
      ),


      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: signupController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text("Al-Mandoob",style: htextTheme,),
                ),

                Container(
                  margin: EdgeInsets.only(top: 50.h),
                  child: Text("Create your Account",style: TextStyle(fontSize: 18.sp),),
                ),

                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (v)
                  {
                    if(v!.isEmpty)
                    {
                      return "First name must be fill";
                    }
                    return null;
                  },
                  controller: signupController.firstnameTextCon.value,
                  decoration: InputDecoration(
                      hintText: "First Name",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 8.w)
                  ),
                ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: signupController.lastnameTextCon.value,
                    validator: (v)
                    {
                      if(v!.isEmpty)
                      {
                        return "Last Name must be fill";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Last Name",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 8.w)
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: signupController.emailTextCon.value,
                    validator: (v)
                    {
                      if(v!.isEmpty)
                      {
                        return "Email must be fill";
                      }
                      else  if(!(v.isEmail))
                      {
                        return "Enter a Correct Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 8.w)
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    controller: signupController.phoneTextCon.value,

                    validator: (v)
                    {
                      if(v!.isEmpty)
                      {
                        return "Phone no must be fill";
                      }
                      else if(v.length<11)
                      {
                        return "Phone no must be equal to 11";

                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "974XXXXXXXXXX",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 8.w)
                    ),
                  ),
                ),


                GetX<SignupController>(

                  builder: (controller) => Container(
                  margin: EdgeInsets.only(top: 30.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obscureText: controller.showpass1.value,
                    controller: signupController.passwordTextCon.value,
                    validator: (v)
                    {
                      if(v!.isEmpty)
                      {
                        return "Password must be fill";
                      }
                      else if(v.length<6)
                      {
                        return "Password must be greater then Six";

                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon:   IconButton(
                          icon:controller.showpass1.value?Icon(Icons.visibility_off,color: defaultColor,):Icon(Icons.visibility,color: defaultColor,),
                          onPressed: (){
                            Get.find<SignupController>().changShowPass1();
                          },
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 5.w)
                    ),
                  ),
                ),),

                GetX<SignupController>(

                  builder: (controller) => Container(
                    margin: EdgeInsets.only(top: 30.h),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      obscureText: controller.showpass2.value,
                      controller: signupController.confpasswordTextCon.value,
                      validator: (v)
                      {
                        if(v!.isEmpty)
                        {
                          return "Password must be fill";
                        }
                        else if(v.length<6)
                        {
                          return "Password must be greater then to Six";

                        }
                        else if(v!=controller.passwordTextCon.value.text)
                        {
                          return "Password does not match";

                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon:   IconButton(
                          icon:controller.showpass2.value?Icon(Icons.visibility_off,color: defaultColor,):Icon(Icons.visibility,color: defaultColor,),
                          onPressed: (){

                            Get.find<SignupController>().changShowPass2();
                            },
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 5.w)
                      ),
                    ),
                  ),),


                GetX<SignupController>(
                  builder: (controller) => Container(
                    margin: EdgeInsets.only(top: 30.h),
                    alignment: Alignment.center,
                    child: controller.isLoading.value?
                    CupertinoActivityIndicator(): MaterialButton(
                      onPressed: controller.isLoading.value?null: (){
                        Get.find<SignupController>().submitButton();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) =>Home()));
                      },
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),

                      color: Color(0xff1e319d),
                      child: Text("Sign Up",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),


                Container(
                    margin: EdgeInsets.only(bottom: 20.h,top: 50.h),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Do you have already account ?"),
                        GestureDetector(
                            onTap: (){
                              Get.off(()=>SiginScreen());
                            },
                            child: Text("Signin",style: TextStyle(color: defaultColor,fontWeight: FontWeight.bold),)),
                      ],
                    ))


              ],
            ),
          ),
        ),
      ),

    );
  }
}
