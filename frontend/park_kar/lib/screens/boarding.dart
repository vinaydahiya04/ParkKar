import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:park_kar/models/parkingLot.dart';
import 'package:park_kar/widgets/parkingList.dart';

import 'DetailedInfo.dart';

List<ParkingModel> parkingLot;
List<Marker> marker = [];

class BoardingScreen extends StatefulWidget {
  BoardingScreen({@required this.position});

  final Position position;
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  num _lat, _lng;

  GoogleMapController _controller;
  Widget _child;
  String _address;

  Set<Marker> _createMarker() {
    return marker.toSet();
  }

  void getAddress(double latitude, double longitude) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);

    // _address =
    //     placemark[0].name.toString() + "," + placemark[0].locality.toString();
    //     placemark[0].name.toString() + "," + placemark[0].locality.toString();

    setState(() {
      _child = GoogleMap(
        mapType: MapType.normal,
        markers: _createMarker(),
        initialCameraPosition: CameraPosition(
          target: LatLng(_lat, _lng),
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      );
    });
  }

  @override
  void initState() {
    _lat = widget.position.latitude;
    _lng = widget.position.longitude;

    getAddress(_lat, _lng);

    marker.add(Marker(
      markerId: MarkerId("Current"),
      position: LatLng(_lat, _lng),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: "Current Location", snippet: _address),
    ));
    for (int i = 0; i < parkingLot.length; i++) {
      marker.add(Marker(
        markerId: MarkerId("Current"),
        position: LatLng(parkingLot[i].latitude, parkingLot[i].longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
            title: parkingLot[i].name,
            snippet:
                "4-Wheeler:${parkingLot[i].fourSpotsLeft}, 2-Wheeler:${parkingLot[i].twoSpotsLeft}"),
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(454, 969), allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("ParkKar"),
        backgroundColor: Color(0xFF192a56),
      ),
      body: Column(
        children: [
          SizedBox(height: 250.h, child: _child),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          child: new TextFormField(
                            autofocus: false,
                            decoration: new InputDecoration(
                              labelText: "Search",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                            onChanged: (String keyword) {},
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // await showModalBottomSheet<dynamic>(
                          //   isScrollControlled: true,
                          //   context: context,
                          //   builder: (BuildContext bc) {
                          //     return Wrap(children: <Widget>[SortFilter()]);
                          //   },
                          // );
                          // search('');
                        },
                        child: Container(
                          height: 40.0.h,
                          width: 30.0.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Icon(Icons.filter_list_rounded,
                                  size: 40, color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 520,
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.h),
                  child: ListView.builder(
                    itemCount: parkingLot.length,
                    itemBuilder: (BuildContext context, i) {
                      return ParkingLotList(
                        lot: parkingLot[i],
                        onPress: () async {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => DetailedInfo(
                                      lot: parkingLot[i],
                                      lat: _lat,
                                      lng: _lng,
                                    )),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
