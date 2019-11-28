import 'package:bloc_weather/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded({
    @required this.weather
  });

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {}
