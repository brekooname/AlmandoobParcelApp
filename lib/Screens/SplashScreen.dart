import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saeed/Screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'SignInScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3),
    //         ()=>getBoolValuesSF()
    // );

    getBoolValuesSF().then((value) {
      print("sds");
      Timer(Duration(seconds: 3), () {
        if(value==true)
        {
          print("sssdds");

          Get.off(()=>Home());
        }
        else
        {
          print("sdsssssss");

          Get.off(()=>SiginScreen());

        }
      });
    });
  }

 Future<bool> getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool

    bool boolValue = prefs.getBool('isLogin')??false;
    return boolValue;
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    var htextTheme=TextStyle(color: Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 30.sp);

    return Scaffold(
      body: Container(
        width: double.infinity,
          height: double.infinity,
          color: Color(0xff1e319d),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.directions_bike_sharp,color: Colors.white,size: 100.h,),
              Text("Al-Mandoob",style: htextTheme,),
            ],
          ),
      ),
    );
  }
}