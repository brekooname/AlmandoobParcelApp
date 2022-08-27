import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:saeed/Screens/Controllers/MapControl.dart';
import 'package:saeed/Screens/Dashboard.dart';
import 'package:saeed/Screens/FromMap/FromMap.dart';
import 'package:saeed/Screens/FromMap/ToMap.dart';
import 'package:saeed/Screens/MainMap.dart';
import 'package:saeed/Screens/SignInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var bg_color=Color(0xff1e319d);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  MapControl mapControlState=Get.put(MapControl());

  String? fname,lname,email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValuesSF();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    var htextTheme=TextStyle(color: Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 30.sp);

    return Scaffold(
      key: _key, // Assign the key to Scaffold.

      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 180.h,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  CircleAvatar(
                    backgroundColor: bg_color,
                    radius: 46,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage("assets/images/userLogo.png"),
                    ),
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${fname??"Fetching..."} ${lname??""}',style: TextStyle(color: bg_color,fontWeight: FontWeight.bold,fontSize: 18.sp),

                      ),
                      Text(
                        '${email??""}',style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold,fontSize: 14.sp),
                      ),

                    ],
                  ),
                ],
              ),
            ),




            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.home_outlined,color: bg_color,),
              title: Text('Home'),

            ),
            ListTile(
              leading: Icon(Icons.card_giftcard_rounded,color: bg_color,),
              title: Text('My Parcels '),

            ),
            ListTile(
              leading: Icon(Icons.mode_edit_outline_outlined,color: bg_color,),
              title: Text('Edit Profile'),

            ),

            ListTile(
              leading: Icon(Icons.perm_contact_cal_outlined,color: bg_color,),
              title: Text('Contact Us'),

            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Other',
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout,color: bg_color,),
              title: Text('SignOut'),
              onTap: ()
              async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLogin', false);

                Get.offAll(()=>{SiginScreen()});
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(

        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Al-Mandoob",style: TextStyle(color: Color(0xff1e319d),fontWeight: FontWeight.bold,fontSize: 18.sp),),
        leading: IconButton(icon:  Icon(Icons.menu,color: bg_color,),onPressed: (){
          _key.currentState!.openDrawer();
        },),

        actions: [
          Icon(Icons.info_outline,color: bg_color,)
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/parcel_bg.png',
                      width: double.infinity,height: 180.h,fit: BoxFit.fill,),
                  ),
                )),


            Container(
              margin: EdgeInsets.only(top: 1.h),
              alignment: Alignment.center,
              child: Text("Deliver your Parcel",style: TextStyle(fontSize: 18.sp,color: Color(0xff1e319d)),),
            ),

            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("From",style: TextStyle(fontSize: 24.sp),),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),

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
                    child: Obx(() => TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      controller: mapControlState.pickUpPlace.value,
                      readOnly: true,
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => FromMap(),));

                      },
                      decoration: InputDecoration(
                          hintText: "Where To Pick Parcel Address ?",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 8.w)
                      ),
                    )),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("To",style: TextStyle(fontSize: 24.sp),),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),

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
                    child: Obx(() => TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      controller: mapControlState.dropOffPlace.value,
                      readOnly: true,
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ToMap(),));

                      },
                      decoration: InputDecoration(
                          hintText: "Where To Drop Parcel Address ?",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 8.w)
                      ),
                    )),
                  ),
                ],
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: 30.h),
              alignment: Alignment.center,
              child: Obx(() => MaterialButton(
                minWidth: double.infinity,
                disabledColor: Colors.grey,
                onPressed: mapControlState.showGoButton()?(){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>MainMap(mapControlState.pickLat.value,mapControlState.pickLong.value,mapControlState.dropLat.value,mapControlState.dropLong.value)));
                }:null,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),

                color: Color(0xff1e319d),
                child: Text("Go",style: TextStyle(color: Colors.white),),
              )),
            ),

          ],
        ),
      ),
    );
  }


  Future<void> getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool

    fname  = prefs.getString('c_fname')??"";
    lname  = prefs.getString('c_lname')??"";
    email  = prefs.getString('c_email')??"";
  }
}
