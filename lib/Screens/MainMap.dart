import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saeed/Screens/Controllers/MapControl.dart';
import 'dart:math';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/scheduler.dart';



class MainMap extends StatefulWidget{
  double pickLat;
  double pickLong;
  double dropLat;
  double dropLong;


  MainMap(this.pickLat, this.pickLong, this.dropLat, this.dropLong);
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {

  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyCFiS3J95syNrmbl4JjQpWr8po9vXLzJvw";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(0.0, 0.0);
  LatLng endLocation = LatLng(0.0, 0.0);

  double distance = 0.0;
  MapControl mapControlState=Get.put(MapControl());


  @override
  void initState() {
    print("${widget.pickLat} ${widget.pickLong}");
     startLocation = LatLng(widget.pickLat, widget.pickLong);
     endLocation = LatLng(widget.dropLat, widget.dropLong);
    markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

   // getDirections(); //fetch direction polylines from Google API

    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,

    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for(var i = 0; i < polylineCoordinates.length-1; i++){
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i+1].latitude,
          polylineCoordinates[i+1].longitude);
    }
    print(totalDistance);

    setState(() {
      distance = totalDistance;
    });

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Color(0xff1e319d),
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
            children:[
              GoogleMap( //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition( //innital position in map
                  target: startLocation, //initial position
                  zoom: 14.0, //initial zoom level
                ),
                markers: markers, //markers to show on map
                polylines: Set<Polyline>.of(polylines.values), //polylines
                mapType: MapType.normal, //map type
                onMapCreated: (controller) { //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                  getDirections();
                },
              ),

              SlidingUpPanel(
                renderPanelSheet: false,
                panel: _floatingPanel(),
                collapsed: _floatingCollapsed(),
                // body: Center(
                //   child: Text("This is the Widget behind the sliding panel"),
                // ),
              ),

            ]
        )
    );


  }
  GlobalKey _toolTipKey = GlobalKey();

  Widget _floatingCollapsed(){

    return Container(
      decoration: BoxDecoration(
        color:  Color(0xff1e319d),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 0.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.location_on_outlined,color: Colors.white,),
                      tooltip: "${mapControlState.pickUpPlace.value.text}",
                      onPressed: (){},
                    ),
                    Text(
                      "${mapControlState.pickUpPlace.value.text}",
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    )

                  ],
                ),
              ),

              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      "Charges ${formula().ceil()} Dinnar",
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      color: Colors.white,
                    ),
                    Text(
                      "${distance.ceil()} Km distance",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.location_on_outlined,color: Colors.white,),
                      tooltip: "${mapControlState.pickUpPlace.value.text}",
                      onPressed: (){},
                    ),
                    Text(
                      "${mapControlState.pickUpPlace.value.text}",
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    )

                  ],
                ),
              ),


            ],
          ),

        ],
      ),
    );
  }
  double formula()
  {

    var fixedPrice=5;
    var chargesPerKm=2;

    var total=fixedPrice+(chargesPerKm*distance);
    return total;
  }

  Widget _floatingPanel(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey,
            ),
          ]
      ),
      margin: const EdgeInsets.all(1.0),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.directions_bike_sharp,color: Color(0xff1e319d),size: 30,),
              Text("Al-Mandoob",style: TextStyle(color:Color(0xff1e319d),fontWeight: FontWeight.bold,fontSize: 30),),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          SizedBox(
            height: 20,
          ),
          Text(
            "Pickup Details",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1e319d)),
          ),


          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "House #, floor #, Street Name, etc",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)
              ),
              prefixIcon: Icon(Icons.maps_home_work_outlined,color: Colors.grey,),
              label: Text("Pickup Address detail")
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: "+965 XXXXXXXX",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                prefixIcon: Icon(Icons.person,color: Colors.grey,),
                label: Text("Sender Contact")
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: "Parcel Weight, Size , etc",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                prefixIcon: Icon(Icons.shopping_bag_outlined,color: Colors.grey,),
                label: Text("Parcel Detail")
            ),
          ),


          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: MaterialButton(
              minWidth: double.infinity,
              height: 40,
              onPressed: (){
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) =>Home()));
              },
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),

              color: Color(0xff1e319d),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_bike_sharp,color: Colors.white,size: 20,),
                  SizedBox(width: 5,),
                  Text("Call Rider",style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  
}