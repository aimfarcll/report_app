import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/src/places.dart';
import 'location_services.dart';

class LocationController extends GetxController {
//Placemark help to get address, specific code from a string
  Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

//after user types in. a list of prediction for places is stored here
  List<Prediction> _predictionList = [];

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    //each time user searches, list gets build from scratch
    if (text != null && text.isNotEmpty) {
      //http.response class contains data received from a successful http
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      print("my status is " + data['status']);
      if (data['status'] == 'OK') {
        _predictionList = [];
        //data we get from decoding status will be looked thru n put in the list
        data['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {}
    }
    return _predictionList;
  }
}
