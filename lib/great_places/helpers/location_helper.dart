import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationHelper {
  static final accessToken =
      'pk.eyJ1Ijoicm9vcGFpc2giLCJhIjoiY2t2OWU1eDF6YTI4ZDMwcWptNXR4aGhoaSJ9.GoTZXtGmHQnjMoyX59EntA';

  static String generateLocationPreviewImage(
      {required double lat, required double lng}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-s-a+a724cc($lng,$lat)/$lng,$lat,17/1080x600?access_token=$accessToken';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.https(
        "api.mapbox.com", "/geocoding/v5/mapbox.places/$lng,$lat.json", {
      'access_token': '$accessToken',
    });
    final response = await http.get(url);
    final place = json.decode(response.body)['features'][0]['place_name'];
    return place;
  }

  static Future<List> getPlaceCoordinates(String place) async {
    final url =
        Uri.https("api.mapbox.com", "/geocoding/v5/mapbox.places/$place.json", {
      'access_token': '$accessToken',
    });
    print("---------------get Place coordinates");
    print(url);
    final response = await http.get(url);
    final coordinates =
        json.decode(response.body)['features'][0]['geometry']['coordinates'];
    print([coordinates[1], coordinates[0]]);
    return [coordinates[1], coordinates[0]];
  }
}
