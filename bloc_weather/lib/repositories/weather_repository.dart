import 'package:bloc_weather/models/weather.dart';
import 'package:bloc_weather/repositories/repositories.dart';
import 'package:flutter/material.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({
    @required this.weatherApiClient
  });

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeather(locationId);
  }
}