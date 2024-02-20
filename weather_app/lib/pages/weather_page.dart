import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherservice = WeatherService('e9369b7763af44b903ee0abeaffac873');

  Weather? weather;
  String? city;

  //Fetch weather
  Future<void> _fetchWeather() async {
    try {
      weather = await _weatherservice.getWeather(city!);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> _requestPermission() async {
    await _weatherservice.requestPermissions();
    city = await _weatherservice.getCurrentCity();
    await _fetchWeather();
    setState(() {});
  }

  @override
  void initState() {
    _requestPermission();
    // TODO: implement initState
    super.initState();
  }

  //weather animation
  String getWeatherCondation(String? weatherCondation) {
    if (weatherCondation == null) return 'assets/sunny.json';
    switch (weatherCondation.toLowerCase()) {
      case 'rain':
        return 'assets/rain.json';
      case 'snow':
        return 'assets/snow.json';
      case 'cloudes':
        return 'assets/cloud.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'thunderstrome':
        return 'assets/thunder.json';
      default:
        return 'assets/cloud.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400]!.withOpacity(0.8),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //cityName
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(city ?? 'loading...', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
                  SizedBox(
                    width: 20,
                  ),
                  (weather?.main.temp == null)
                      ? Text(
                          '--℃',
                        )
                      : Text('${weather?.main.temp} ℃', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500))
                ],
              ),
              Lottie.asset(getWeatherCondation(weather?.main.condation)),

              //Weather
              // Text('${weather?.temperature}℃')
            ],
          ),
        ));
  }
}
