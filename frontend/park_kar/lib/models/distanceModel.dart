class DistanceModel {
  String distance;
  String duration;
  num distanceValue;

  DistanceModel({this.distance, this.duration, this.distanceValue});

  factory DistanceModel.fromJson(Map<String, dynamic> json) {
    return DistanceModel(
      distance: json['rows'][0]["elements"][0]["distance"]["text"] as String,
      duration: json['rows'][0]["elements"][0]["duration"]["text"] as String,
      distanceValue: json['rows'][0]["elements"][0]["distance"]["value"] as num,
    );
  }
}
