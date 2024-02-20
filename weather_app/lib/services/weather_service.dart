import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;
  Position? position;
  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    //  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String url = '$baseUrl?q=$cityName&lat=${position?.latitude}&lon=${position?.longitude}&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);

      Weather weather = Weather(
          coord: Coordinates(lat: position!.latitude, lon: position!.longitude),
          main: WeatherCondations(
            condation: data['weather'][0]['main'].toString(),
              temp: data['main']['temp'].toString(),
              humidity: data['main']['humidity'].toString(),
              pressure: data['main']['pressure'].toString(),
              sea_level: data['main']['sea_level'].toString(),
              grnd_level: data['main']['grnd_level'].toString()));
      // final temp = data['main']['temp'].toString();
      return weather;
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  requestPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        getCurrentCity();
      }
    }
  }

  Future<String> getCurrentCity() async {
    // permission= await Geolocator.requestPermission();
    List<Placemark> placemarks = [];

    // fetch location
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    // Convert the location into placemark list
    placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);

    // extract the city from the first placemark
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}
