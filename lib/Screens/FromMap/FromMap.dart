import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:saeed/Model/MainModel.dart';
import 'package:saeed/Model/Suggestion.dart';
import 'package:saeed/Screens/Controllers/MapControl.dart';
import 'package:saeed/Screens/SearchScreen.dart';
import 'package:uuid/uuid.dart';


class FromMap extends StatefulWidget {
  const FromMap({Key? key}) : super(key: key);

  @override
  State<FromMap> createState() => _FromMapState();
}

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

// the user's initial location and current location
// as it moves
LocationData? currentLocation;
// a reference to the destination location

Location? location;

class _FromMapState extends State<FromMap> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  Set<Marker> _markers = Set<Marker>();


  final _tcontroller = TextEditingController();


  MapControl mapControlState=Get.put(MapControl());


  double? presentlat=0.0;//=24.8630885;
  double? presentlong=0.0;//=67.0741685;

  bool showButton=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // create an instance of Location
    location = new Location();

    setInitialLocation();
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    print("ds");
    currentLocation = await location!.getLocation().then((value) {
      presentlat=value.latitude!;
     presentlong=value.longitude!;

      mapController!.animateCamera(CameraUpdate.newLatLngZoom(LatLng(presentlat!, presentlong!), 16 ));

      showPinsOnMap();
      setState((){});
    });
  }


  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition = LatLng(presentlat!, presentlong!);

    // add the initial source location pin
    _markers.add(Marker(
      markerId: MarkerId('sourcePin'),
      position: pinPosition,
        onTap: () {
          print('Tapped');
        },
        draggable: true,
        onDragEnd: ((newPosition) {
          print(newPosition.latitude);
          print(newPosition.longitude);
        })
    ));


  }



  @override
  Widget build(BuildContext context) {

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(0.0, 0.0));

      print("i am bbbbb");
      if(currentLocation!=null) {
        initialCameraPosition = CameraPosition(
            target:
            LatLng(presentlat!, presentlong!),
            zoom: CAMERA_ZOOM,
            tilt: CAMERA_TILT,
            bearing: CAMERA_BEARING);
      }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () { setPolylines(); },),
      body: Stack(
        children: <Widget>[
          GoogleMap(
             myLocationEnabled: false,
             compassEnabled: false,
             mapToolbarEnabled: false,
             tiltGesturesEnabled: true,
             markers: _markers,
             mapType: MapType.normal,
             initialCameraPosition: initialCameraPosition,
             onMapCreated: (GoogleMapController controller) {
               _controller.complete(controller);
               mapController=controller;
               // my map has completed being created;
               // i'm ready to show the pins on the map
               showPinsOnMap();
             }),


          Container(
            margin: EdgeInsets.only(top: 30,left: 20,right: 20),
            padding: EdgeInsets.symmetric(horizontal: 8),

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
              controller: _tcontroller,
              onTap: () async {
                // generate a new token here
                final sessionToken = Uuid().v4();
                final MainModel? result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );
                // This will change the text displayed in the TextField
                if (result != null) {
                  mapControlState.pickLat.value=result.modelOfPlace!.result!.geometry.location.lat;
                  mapControlState.pickLong.value=result.modelOfPlace!.result!.geometry.location.lng;

                  setState((){
                 mapControlState.setPickUp( result.suggestion.description);

                      _tcontroller.text = result.suggestion.description;

                  presentlat=result.modelOfPlace!.result!.geometry.location.lat;
                   presentlong=result.modelOfPlace!.result!.geometry.location.lng;



                      print("dfsd lat ${mapControlState.pickLat.value}");
                      print("dfsd lat ${ mapControlState.pickLong.value}");

                      mapController!.animateCamera(CameraUpdate.newLatLngZoom(LatLng(presentlat!,  presentlong!), 16 ));
                      // _markers.clear();


                      showButton=true;
                      showPinsOnMap();
                  });
                }
              },
              readOnly: true,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Search Addresss",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,size: 24,),

                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
              ),
            ),
          ),


          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 20),
            child: MaterialButton(
              color: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              onPressed: showButton&&_controller.isCompleted?(){

                Get.back();

              }:null,child: Text("Confirm Pickup Point",style: TextStyle(color: Colors.white)),),
          ),

        ],
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _tcontroller.dispose();
    mapController!.dispose();
    super.dispose();
  }
}
