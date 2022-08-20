import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saeed/Screens/Home.dart';


class SigupScreen extends StatefulWidget {
  const SigupScreen({Key? key}) : super(key: key);

  @override
  State<SigupScreen> createState() => _SigupScreenState();
}

class _SigupScreenState extends State<SigupScreen> {



  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, designSize: const Size(360, 690));

    var htextTheme=TextStyle(color: Color(0xff1e319d),fontWeight: FontWeight.bold,fontSize: 30.sp);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){

          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.grey,)),
      ),


      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(top: 40.h),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text("Al-Mandoob",style: htextTheme,),
            ),

            Container(
              margin: EdgeInsets.only(top: 50.h),
              child: Text("Create your Account",style: TextStyle(fontSize: 18.sp),),
            ),

            Container(
              margin: EdgeInsets.only(top: 10.h),
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
              ),              child: TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
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
              child: TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
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
              child: TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
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
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>Home()));
                },
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),

                color: Color(0xff1e319d),
                child: Text("Sign Up",style: TextStyle(color: Colors.white),),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
