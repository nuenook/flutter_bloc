import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WeatherEvent extends Equatable {

  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final String city;

  const FetchWeather({
    @required this.city
  });

  @override
  List<Object> get props => [city];
}

class RefreshWeather extends WeatherEvent {
  final String city;

  const RefreshWeather({this.city});
  
  @override
  List<Object> get props => [city];

}