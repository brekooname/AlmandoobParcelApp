import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:saeed/Model/ModelOfPlace.dart';

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;
  double lat;
  double  long;

  Place({
    required this.streetNumber,
    required this.street,
    required this.city,
    required this.zipCode,
    required this.lat,
    required this.long,
  });



  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyCFiS3J95syNrmbl4JjQpWr8po9vXLzJvw';
  static final String iosKey = 'AIzaSyCFiS3J95syNrmbl4JjQpWr8po9vXLzJvw';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

   Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    // final request =
    //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';

     final request="https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=en&components=country:PK&key=$apiKey&radius=5000&location=24.8607  67.0011";
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<ModelOfPlace> getPlaceDetailFromId(String placeId) async {
    var request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    print("sdflkjhdsfkjdfsbhkj ${response.statusCode}");
    if (response.statusCode == 200) {

      ModelOfPlace modelOfPlace=modelOfPlaceFromJson(response.body);

      // print(modelOfPlace.result!.geometry.location.lat);
      return modelOfPlace;

    } else {

      return ModelOfPlace(htmlAttributions: [], status: "failed");
    }
  }
}