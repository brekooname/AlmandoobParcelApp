import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

 class MapControl extends GetxController
 {


     var isloading=false.obs;

     var pickUpPlace=TextEditingController().obs;
     var dropOffPlace=TextEditingController().obs;

     var pickLat=0.0.obs;
     var pickLong=0.0.obs;
     var dropLat=0.0.obs;
     var dropLong=0.0.obs;



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

 }