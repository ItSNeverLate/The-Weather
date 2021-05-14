import 'package:flutter/material.dart';
import 'package:the_weather/utils/location.dart';

class HomeScreen extends StatefulWidget {
  final Location location;

  HomeScreen({@required this.location});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.location.latitude.toString()),
      ),
    );
  }
}
