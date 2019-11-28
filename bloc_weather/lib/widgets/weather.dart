import 'dart:async';

import 'package:bloc_weather/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[400],
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );

              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(FetchWeather(city: city));
              }
            },
          ),
        ],
      ),
      body: Center(child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherEmpty) {
            return Center(
              child: Text('Please Select a Location'),
            );
          }
          if (state is WeatherLoaded) {
            final weather = state.weather;

            return ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: Location(location: weather.location),
                  ),
                ),
                Center(
                  child: LastUpdated(dateTime: weather.lastUpdated),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Center(
                    child: CombinedWeatherTemperature(weather: weather),
                  ),
                )
              ],
            );
          }

          if (state is WeatherError) {
            return Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red),
            );
          }
          return new Container(width: 0.0, height: 0.0);
        },
      )),
    );
  }
}
