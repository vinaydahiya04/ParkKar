import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:park_kar/models/parkingLot.dart';

class ParkingRoute extends StatefulWidget {
  ParkingRoute({@required this.lot, @required this.lat, @required this.lng});
  final ParkingModel lot;
  final num lat;
  final num lng;

  @override
  _ParkingRouteState createState() => _ParkingRouteState();
}

class _ParkingRouteState extends State<ParkingRoute> {
  int _polylineCount = 1;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  GoogleMapController _controller;

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("Current"),
        position: LatLng(widget.lat, widget.lng),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Current Location"),
      ),
      Marker(
        markerId: MarkerId("Parking"),
        position: LatLng(widget.lot.latitude, widget.lot.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Parking"),
      )
    ].toSet();
  }

  GoogleMapPolyline _googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyBTpq2aXpU-MsCALXcmCWpNE6-hNZ11mZI");

  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  LatLng _originLocation;
  LatLng _destinationLocation;

  _getPolylinesWithLocation() async {
    List<LatLng> _coordinates =
        await _googleMapPolyline.getCoordinatesWithLocation(
            origin: _originLocation,
            destination: _destinationLocation,
            mode: RouteMode.driving);

    setState(() {
      _polylines.clear();
    });
    _addPolyline(_coordinates);
  }

  _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color: Colors.blueAccent,
        points: _coordinates,
        width: 10,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    });
  }

  @override
  void initState() {
    _originLocation = LatLng(widget.lat, widget.lng);
    _destinationLocation = LatLng(widget.lot.latitude, widget.lot.longitude);

    _getPolylinesWithLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(454, 969), allowFontScaling: false);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, cont) {
          return GoogleMap(
            mapType: MapType.normal,
            markers: _createMarker(),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            polylines: Set<Polyline>.of(_polylines.values),
            initialCameraPosition: CameraPosition(
              target: LatLng((widget.lat+widget.lot.latitude)/2, (widget.lng+widget.lot.longitude)/2),
              zoom: 15.0,
            ),
          );
        },
      ),
    );
  }
}
