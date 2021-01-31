import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:park_kar/models/parkingLot.dart';
import 'ParkingRoute.dart';

class DetailedInfo extends StatefulWidget {
  DetailedInfo({@required this.lot, @required this.lat, @required this.lng});
  final ParkingModel lot;
  final num lat;
  final num lng;

  @override
  _DetailedInfoState createState() => _DetailedInfoState();
}

class _DetailedInfoState extends State<DetailedInfo> {
  ParkingModel Lot;
  @override
  void initState() {
    Lot = widget.lot;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(454, 969), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xFF192a56),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 60, right: 30),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          image: DecorationImage(
                            image: NetworkImage(widget.lot.image),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          widget.lot.name,
                          style: TextStyle(
                              height: 1.3,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              fontFamily: 'Cairo'),
                        ),
                      ),
                      Text(
                        widget.lot.address,
                        textAlign:  TextAlign.center,
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'Commissioner'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Distance : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Commissioner'),
                      ),
                      Text(
                        widget.lot.distance,
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Commissioner'),
                      ),
                      Text(
                        "Time : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Commissioner'),
                      ),
                      Text(
                        widget.lot.duration,
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Commissioner'),
                      ),
                      Text(
                        "Charges : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Commissioner'),
                      ),
                      Text(
                        "₹ ${widget.lot.charges} / hr",
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Commissioner'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Timing : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Commissioner'),
                      ),
                      Text(
                        "${widget.lot.startingTime}:00 - ${widget.lot.endingTime}:00",
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Commissioner'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Available Parking : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Commissioner'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Four Wheeler : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Commissioner'),
                          ),
                          Text(
                            widget.lot.fourSpotsLeft.toString(),
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Commissioner'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Two Wheeler : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Commissioner'),
                          ),
                          Text(
                            widget.lot.twoSpotsLeft.toString(),
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Commissioner'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Contact : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Commissioner'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Phone : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Commissioner'),
                          ),
                          Text(
                            widget.lot.phone.toString(),
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Commissioner'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Email : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Commissioner'),
                          ),
                          Text(
                            widget.lot.email.toString(),
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Commissioner'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 800),
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => ParkingRoute(
                            lot: Lot, lat: widget.lat, lng: widget.lng)),
                  );
                },
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                highlightColor: Color(0xFF273c75),
                color: Color(0xFF283b6b),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Navigate',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.1,
                      fontSize: 25,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
