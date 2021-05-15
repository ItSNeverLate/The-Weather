import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:the_weather/service/weather_service.dart';
import 'package:the_weather/utils/location.dart';

class HomeScreen extends StatefulWidget {
  final Location location;

  HomeScreen({@required this.location});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int temp;
  String quiryCity = '';
  String cityName = '';
  String iconName = '';
  String condition = '';

  void updateUI(data) => setState(() {
        temp = (data['main']['temp']).toInt();
        iconName = (data['weather'][0]['icon']);
        condition = (data['weather'][0]['main']);
        cityName = (data['name']);
        quiryCity = '';
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/home_bg.jpeg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          onPressed: () async {
                            var weatherService = WeatherService();
                            Response response =
                                await weatherService.getWeatherDataByLocation(
                              widget.location.latitude,
                              widget.location.longitude,
                            );
                            if (response.statusCode == 200) {
                              updateUI(jsonDecode(response.body));
                            }
                          },
                        ),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              setState(() {
                                quiryCity = value;
                              });
                            },
                            decoration: InputDecoration(
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                hintText: "Enter City Name",
                                fillColor: Colors.white38,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide.none,
                                )
                                // borderSide: BorderSide(color: Colors.red,width: 3.0)),
                                ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          onPressed: () async {
                            var weatherService = WeatherService();
                            Response response = await weatherService
                                .getWeatherDataByCity(quiryCity);
                            if (response.statusCode == 200) {
                              updateUI(jsonDecode(response.body));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: (temp != null)
                      ? Card(
                          color: Colors.white24,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            height: 300,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      temp.toString(),
                                      style: TextStyle(
                                        fontSize: 75.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '˚',
                                      style: TextStyle(
                                        fontSize: 50.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'C',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.network(
                                  'https://openweathermap.org/img/wn/$iconName@4x.png',
                                  height: 90,
                                  width: 90,
                                ),
                                Text(
                                  condition,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Text(
                          'Select your location by pin button, or Search a city',
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    cityName.toUpperCase(),
                    style: TextStyle(fontSize: 35.0),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
