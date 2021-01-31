import 'package:http/http.dart' as http;
import 'package:park_kar/models/distanceModel.dart';
import 'dart:convert';
import 'package:park_kar/models/parkingLot.dart';

class NetworkHelper {
  NetworkHelper({this.url});
  final url;

  Future getRequest() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      final parsed = json.decode(data);
      return (parsed as List)
          .map<ParkingModel>((json) => new ParkingModel.fromJson(json))
          .toList();
    } else {
      print(response.statusCode);
    }
  }

  Future getDistanceTime() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      final parsed = json.decode(data);
      return parsed;
          // .map<DistanceModel>((json) => new DistanceModel.fromJson(json));
    } else {
      print(response.statusCode);
    }
  }
}
