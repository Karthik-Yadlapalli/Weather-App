// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Coordinates{
  double lat;
  double lon;
  Coordinates({required this.lat,required this.lon});
}

class WeatherCondations{
  String condation;
  String temp;
  String humidity;
  String pressure;
  String sea_level;
  String grnd_level;
  WeatherCondations({required this.condation, required this.temp,required this.humidity, required this.pressure,required this.sea_level, required this.grnd_level});
}


class Weather {
  Coordinates coord;
  WeatherCondations main;
  Weather({required this.coord,required this.main});
}
