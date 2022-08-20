import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saeed/Model/MainModel.dart';
import 'package:saeed/Model/ModelOfPlace.dart';
import 'package:saeed/Model/Suggestion.dart';
import 'package:saeed/Screens/Controllers/MapControl.dart';

class AddressSearch extends SearchDelegate<MainModel> {
  String sessionToken;

  AddressSearch(this.sessionToken);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          mapControlState.isloading.value=!mapControlState.isloading.value;

          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {

        close(context, MainModel(suggestion: null,modelOfPlace: ModelOfPlace(status: '', htmlAttributions: [])));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  MapControl mapControlState=Get.put(MapControl());

  @override
  Widget buildSuggestions(BuildContext context) {
    PlaceApiProvider xd = PlaceApiProvider(sessionToken);
    ModelOfPlace? mmodelOfPlace;
    return FutureBuilder(
      // We will put the api call here
      future: xd.fetchSuggestions(query, "eng"),
      builder: (context, AsyncSnapshot<dynamic> snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? serachList(snapshot,xd,mmodelOfPlace)
              : Center(child: CupertinoActivityIndicator()),
    );
  }

  serachList(snapshot,xd,mmodelOfPlace){
    return GestureDetector(
      onTap: (){

      },
      child: Obx(() => Stack(children: [

        ListView.builder(
          itemBuilder: (context, index) => ListTile(
            // we will display the data returned from our future here
            title: Text(snapshot.data[index].description),
            onTap: () {

              mapControlState.isloading.value=true;
              print(snapshot.data[index].placeId);
              xd.getPlaceDetailFromId(snapshot.data[index].placeId).then((value)  {
                mmodelOfPlace=value;

                mapControlState.isloading.value=false;

                if(mmodelOfPlace!.status=="OK")
                {
                  print(mmodelOfPlace!.result!.addressComponents.first);
                  close(context, MainModel(modelOfPlace: mmodelOfPlace,suggestion:  snapshot.data[index]));
                }

              });

              //close(context, snapshot.data[index]);
            },
          ),
          itemCount: snapshot.data.length,
        ),

        mapControlState.isloading.value?Container(
          alignment: Alignment.center,
          color: Colors.grey.withOpacity(0.3),
          child: CupertinoActivityIndicator(),
        ):Container()




      ],



      )),
    );
  }
}
