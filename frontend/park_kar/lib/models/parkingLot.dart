class ParkingModel {
  String id;
  String name;
  String email;
  int phone;
  String address;
  num latitude;
  num longitude;
  String image;
  num charges;
  String startingTime;
  String endingTime;
  int fourSpotsLeft;
  int twoSpotsLeft;
  String mapApiData;
  num averageRating;
  String distance;
  num distanceValue;
  String duration;

  ParkingModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.latitude,
      this.longitude,
      this.image,
      this.charges,
      this.startingTime,
      this.endingTime,
      this.fourSpotsLeft,
      this.twoSpotsLeft,
      this.mapApiData,
      this.averageRating});

  factory ParkingModel.fromJson(Map<String, dynamic> json) {
    return ParkingModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as int,
      address: json['address'] as String,
      latitude: json['latitude'] as num,
      longitude: json['longitude'] as num,
      image: json['image'][0] as String,
      charges: json['charges'] as num,
      startingTime: json['startingTime'] as String,
      endingTime: json['endingTime'] as String,
      fourSpotsLeft: json['FourSpotsLeft'] as int,
      twoSpotsLeft: json['TwoSpotsLeft'] as int,
      mapApiData: json['mapApiData'] as String,
      averageRating: json['averageRating'] as num,
    );
  }
}
