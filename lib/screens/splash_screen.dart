import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:the_weather/screens/home_screen.dart';
import 'package:the_weather/utils/location.dart';

const SPLASH_DELAY = 3; //seconds

class SplashScreen extends StatelessWidget {
  getCurrentLocation(BuildContext context) async {
    Location location = Location();
    await location.getCurrentLocation();

    Future.delayed(Duration(seconds: SPLASH_DELAY), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(location: location),
        ),
      );
      print('Go to Home Screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Image.asset(
              'images/splash_bg.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            SpinKitDoubleBounce(
              color: Colors.white,
              size: double.infinity,
            ),
          ],
        ));
  }
}
