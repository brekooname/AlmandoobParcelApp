import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saeed/Screens/Home.dart';

import 'Controllers/SignInController.dart';
import 'SignUpScreen.dart';

class SiginScreen extends StatefulWidget {
  const SiginScreen({Key? key}) : super(key: key);

  @override
  State<SiginScreen> createState() => _SiginScreenState();
}

class _SiginScreenState extends State<SiginScreen> {
  var default_color=Color(0xff8A1538);

  SignInController signinController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    var htextTheme = TextStyle(
        color: default_color, fontWeight: FontWeight.bold, fontSize: 30.sp);
    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: signinController.SiginformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.h),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "Al-Mandoob",
                  style: htextTheme,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Text(
                  "Sign In your Account",
                  style: TextStyle(fontSize: 18.sp),
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
                  controller: signinController.emailTextCon.value,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Email must be fill";
                    } else if (!(v.isEmail)) {
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
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5.h, vertical: 8.w)),
                ),
              ),
              GetX<SignInController>(
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
                    controller: signinController.passwordTextCon.value,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Password must be fill";
                      } else if (v.length < 6) {
                        return "Password must be greater then Six";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: controller.showpass1.value
                            ? Icon(
                                Icons.visibility,
                                color: default_color,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: default_color,
                              ),
                        onPressed: () {
                          Get.find<SignInController>().changShowPass1();
                        },
                      ),
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 5.w)
                    ),
                  ),
                ),
              ),
              GetX<SignInController>(
                builder: (controller) => Container(
                  margin: EdgeInsets.only(top: 30.h),
                  alignment: Alignment.center,
                  child: controller.isLoading.value
                      ? CupertinoActivityIndicator()
                      : MaterialButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  Get.find<SignInController>().submitButton();
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) =>Home()));
                                },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: default_color,
                          child: Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Don't have an account ?"),
                        GestureDetector(
                            onTap: (){
                              Get.to(()=>SigupScreen());
                            },
                            child: Text("Sign Up",style: TextStyle(color: default_color,fontWeight: FontWeight.bold),)),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
