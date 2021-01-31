import 'package:geolocator/geolocator.dart';
import 'package:park_kar/models/parkingLot.dart';

import 'networking.dart';

class ParkingRequest {
  Future<dynamic> allPL() async {
    NetworkHelper networkHelper =
        NetworkHelper(url: "https://parkkar-server.herokuapp.com/api/pl/all");
    List<ParkingModel> parkingData = await networkHelper.getRequest();
    return parkingData;
  }

  Future<dynamic> distanceTime(Position current, ParkingModel dest) async {
    NetworkHelper networkHelper = NetworkHelper(
        url:
            "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${current.latitude},${current.longitude} &destinations=${dest.latitude},${dest.longitude} &key=AIzaSyBTpq2aXpU-MsCALXcmCWpNE6-hNZ11mZI");
    return await networkHelper.getDistanceTime();
  }
}
