import 'dart:convert';
import 'package:http/browser_client.dart' as httpClient;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../imports.dart';

class LocationServicesProvider with ChangeNotifier {
  Map<String, dynamic> _location = {};
  String _weatherTemp = "";
  String _weatherIcon = "";
  String _weatherDescription = "";

  final client = httpClient.BrowserClient()..withCredentials = true;
  final locationEndpoint = Uri.parse("$hostname/api/getLocation/");

  Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

// Get the Weather of User's Current Location
  Future getWeather() async {
    try {
      Map<String, double> location = {};
      // Try to get location based on GeoLocator plugin (requires user's permission for location services)
      try {
        final geoLocation = await getLocation();
        debugPrint("Location Retrieved from location services");
        debugPrint(geoLocation.toString());
        location.addAll({"latitude": geoLocation.latitude});
        location.addAll({"longitude": geoLocation.longitude});
      } catch (e, stackTrace) {
        print("Unable to get location by geolocator: $e, $stackTrace");
      }
      // If location services are turned off or denied permission, get location based on user's IP address via ipAPI
      if (location.isEmpty) {
        final locationRes = await client.get(locationEndpoint);
        debugPrint("Location Retrieved from IP address");
        debugPrint(locationRes.body);
        final locationResBody = json.decode(locationRes.body);
        location.addAll({"latitude": locationResBody["latitude"]});
        location.addAll({"longitude": locationResBody["longitude"]});
      }
      // final WeatherFactory wf =
      //     WeatherFactory("5b6c5e649bd2f3b6973cdc9d083da9bc");
      final WeatherFactory wf = WeatherFactory(const String.fromEnvironment(
          "WEATHER_API_KEY")); // get API key from --dart-define/.env
      Weather w = await wf.currentWeatherByLocation(location["latitude"] ?? 0,
          location["longitude"] ?? 0); // fallback to 0 if null
      var weatherF = w.temperature!.fahrenheit!.round().toString() + "°";

      // Save location in Provider
      saveLocation(location);
      // Save weather temperature in Provider
      saveWeatherTemp(weatherF);
      // Save weather icon in Provider
      saveWeatherIcon(w.weatherIcon);
      // Save weather description in Provider
      saveWeatherDescription(w.weatherDescription);
      debugPrint(w.weatherDescription);
      debugPrint(w.weatherIcon);
      print(location);
      notifyListeners();

      // debugPrint(weather);
    } catch (e, stackTrace) {
      print(
          "Something went wrong with location/weather request: $e, $stackTrace");
    }
  }

  Map<String, dynamic> get location => _location;
  void saveLocation(location) {
    _location = location;
    notifyListeners();
  }

  String get weatherTemp => _weatherTemp;
  void saveWeatherTemp(weatherTemp) {
    _weatherTemp = weatherTemp;
    notifyListeners();
  }

  String get weatherIcon => _weatherIcon;
  void saveWeatherIcon(weatherIcon) {
    _weatherIcon = weatherIcon;
    notifyListeners();
  }

  String get weatherDescription => _weatherDescription;
  void saveWeatherDescription(weatherDesciption) {
    _weatherDescription = weatherDescription;
    notifyListeners();
  }
}
