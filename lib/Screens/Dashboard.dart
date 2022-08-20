import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:saeed/Model/MainModel.dart';
import 'package:saeed/Model/Suggestion.dart';
import 'package:saeed/Screens/Controllers/MapControl.dart';
import 'package:uuid/uuid.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'SearchScreen.dart';

class Dashboard extends StatefulWidget {

final  double pickLat;
  double pickLong;
  double dropLat;
  double dropLong;


  Dashboard(this.pickLat, this.pickLong, this.dropLat, this.dropLong);

  @override
  State<Dashboard> createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {
 Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = Set<Marker>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  String googleAPIKey = "AIzaSyBu5iEduyb6tEbj_sE-QzN5aYqgTrIEYmY";
  Map<PolylineId, Polyline> _polylines = {};
  final _tcontroller = TextEditingController();

  MapControl mapControlState=Get.put(MapControl());
 var htextTheme=TextStyle(color: Color(0xff1e319d),fontWeight: FontWeight.bold,fontSize: 30);


   double CAMERA_ZOOM = 12;
   double CAMERA_TILT = 80;
   double CAMERA_BEARING = 30;
   LatLng SOURCE_LOCATION = LatLng(24.860665519213455, 67.06979213800852);
   LatLng DEST_LOCATION = LatLng(24.860665519213455, 67.06979213800852);

// the user's initial location and current location
// as it moves
  LocationData? currentLocation;
// a reference to the destination location
  LocationData? destinationLocation;
// wrapper around the location API
  Location? location;
  double totalDistance = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    SOURCE_LOCATION = LatLng(widget.pickLat, widget.pickLong);
    DEST_LOCATION = LatLng(widget.dropLat, widget.dropLong);
    // create an instance of Location
    location = new Location();
    polylinePoints = PolylinePoints();

    setInitialLocation();
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition = LatLng(SOURCE_LOCATION.latitude,SOURCE_LOCATION.longitude );
    // get a LatLng out of the LocationData object
    var destPosition = LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
    // add the initial source location pin
    _markers.add(Marker(
      markerId: MarkerId('sourcePin'),
      position: pinPosition,
    ));
    // destination pin
    _markers.add(Marker(
      markerId: MarkerId('destPin'),
      position: destPosition,

    ));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    try {
      setPolylines();
    } catch (e) {
      print("dsffff ${e}");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void setPolylines() async {
    print("i am call");
      PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
          "AIzaSyCFiS3J95syNrmbl4JjQpWr8po9vXLzJvw",
          PointLatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
          PointLatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude),
          travelMode: TravelMode.driving,
          );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          print("343dsf  ${point}");
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
  
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Color(0xff1e319d), points: polylineCoordinates);
    _polylines[id] = polyline;


    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("i am cccccc");


    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

      print("i am bbbbb");
      if(currentLocation!=null) {
        initialCameraPosition = CameraPosition(
            target:
            LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
            zoom: CAMERA_ZOOM,
            tilt: CAMERA_TILT,
            bearing: CAMERA_BEARING);
      }

    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(onPressed: () { setPolylines(); },),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                  myLocationEnabled: false,
                  compassEnabled: false,
                  mapToolbarEnabled: false,
                  tiltGesturesEnabled: true,
                  markers: _markers,
                  polylines: Set<Polyline>.of(_polylines.values),
                  mapType: MapType.normal,
                  initialCameraPosition: initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    // my map has completed being created;
                    // i'm ready to show the pins on the map
                    showPinsOnMap();
                  }),

              SlidingUpPanel(
                renderPanelSheet: false,
                panel: _floatingPanel(),
                collapsed: _floatingCollapsed(),
                // body: Center(
                //   child: Text("This is the Widget behind the sliding panel"),
                // ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget _floatingCollapsed(){
    return Container(
      decoration: BoxDecoration(
        color:  Color(0xff1e319d),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: Center(
        child: Text(
          "This is the collapsed Widget",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _floatingPanel(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]
      ),
      margin: const EdgeInsets.all(24.0),
      child: Center(
        child: Text("This is the SlidingUpPanel when open"),
      ),
    );
  }
  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    // currentLocation = await location!.getLocation().then((value) {
    //   presentLat=value.latitude;
    //   presentLong=value.longitude;
    // });


    // hard-coded destination for this example
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
  }


  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
}
