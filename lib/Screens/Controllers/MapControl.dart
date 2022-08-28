import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../RemoteServices/RemoteService.dart';

 class MapControl extends GetxController
 {


     var isloading=false.obs;

     var pickUpPlace=TextEditingController().obs;
     var dropOffPlace=TextEditingController().obs;

     var pickLat=0.0.obs;
     var pickLong=0.0.obs;
     var dropLat=0.0.obs;
     var dropLong=0.0.obs;

     var OrderPlaceformKey ;

     /*for order*/

     var orderPickAddress=TextEditingController().obs;
     var senderContact=TextEditingController().obs;
     var parcelDetail=TextEditingController().obs;
     var isLoading=false.obs;


     String userId="0";

     @override
     void onInit() {
       // TODO: implement onInit
       super.onInit();
       OrderPlaceformKey= GlobalKey<FormState>();


       initSF().then((value) {

         senderContact.value.text=value.getString('c_phone')??"";;
         userId=value.getString('c_id')??"0";;

       });

     }


     setPickUp(p)
     {
       pickUpPlace.value.text=p;
     }
     setDropOffUp(d)
     {
       dropOffPlace.value.text=d;
     }

    bool showGoButton()
     {

       if(pickUpPlace.value.text.isEmpty && dropOffPlace.value.text.isEmpty)
       {

         return false;
       }
       else
       {
         return true;
       }
     }

    Future insertPlaceParcel()async{
       if (OrderPlaceformKey.currentState!.validate()) {

        await callRiderInserData();
       }

     }


     Future callRiderInserData()async{

       Map<String,String> map=new Map();

       // 'pickup_lat': '24234234',
       // 'pickup_lng': '24234234',
       // 'dropoff_lat': '234234',
       // 'dropoff_lng': '234242',
       // 'pickup_address': 'bvbv',
       // 'dropoff_address': 's',
       // 'consumer_id': '1',
       // 'consumer': 's',
       // 'consumer_contact': '2',
       // 'receiver_contact': '3',
       // 'receiver': '4',
       // 'parcel_details': '5'
       map['pickup_lat']=pickLat.value.toString();
       map['pickup_lng']=pickLong.value.toString();
       map['dropoff_lat']=dropLat.value.toString();
       map['dropoff_lng']=dropLong.value.toString();
       map['consumer_id']=userId;
       map['consumer_contact']=senderContact.value.text.toString();
       map['parcel_details']=parcelDetail.value.text.toString();
       map['pickup_address']=orderPickAddress.value.text.toString();



       try{

         isLoading(true);

         await  RemoteService.insertOrderPlace(map);
       }
       finally{
         // isLoading(false);
         //Get.snackbar("message", "Some Thing Wrong Try Again",snackPosition: SnackPosition.BOTTOM);

       }

     }


     Future<SharedPreferences> initSF() async {
       //Return bool

       SharedPreferences prefs = await SharedPreferences.getInstance();

       return prefs;
     }




 }