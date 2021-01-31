import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_kar/Network/data.dart';
import 'package:park_kar/screens/LoginScreen.dart';
import 'package:park_kar/screens/boarding.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Network/UserRequest.dart';
import 'constants.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int flag = 0;
  Position position;

  void getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition();
  }

  void getParkingLocation() async {
    parkingLot = await ParkingRequest().allPL();
  }

  void getDistanceTime() async {
    for (int i = 0; i < parkingLot.length; i++) {
      var data = await ParkingRequest().distanceTime(position, parkingLot[i]);
      parkingLot[i].distanceValue =
          data["rows"][0]["elements"][0]["distance"]["value"];
      parkingLot[i].distance =
          data["rows"][0]["elements"][0]["distance"]["text"];
      parkingLot[i].duration =
          data["rows"][0]["elements"][0]["duration"]["text"];
    }
  }

  Future<Widget> loadFromFuture() async {
    await getParkingLocation();
    await getCurrentLocation();
    await getDistanceTime();

    parkingLot.sort((a, b) => a.distanceValue.compareTo(b.distanceValue));

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Widget screenToShow;

    if (sharedPreferences.getString('cred') != null) {
      var cred = sharedPreferences.getString('cred');
      var password = sharedPreferences.getString('password');
      user = await UserAuth().loginRequest(cred, password);
      screenToShow = BoardingScreen(position: position);
    } else {
      flag = 1;
      screenToShow = LoginScreen();
    }
    return Future.value(screenToShow);
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        imageBackground: AssetImage('images/loading.jpg'),
        navigateAfterFuture: loadFromFuture().then((value) => {
              if (flag == 1)
                {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BoardingScreen(position: position)),
                  )
                }
            }),
        // seconds: 10,
        // navigateAfterSeconds: BoardingScreen(position: position),
        // title: new Text(
        //   'Loading',
        //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        // ),
        // styleTextUnderTheLoader:  TextStyle(),
        loaderColor: Colors.red);
  }
}
