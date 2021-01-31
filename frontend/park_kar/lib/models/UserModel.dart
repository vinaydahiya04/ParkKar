class UserModel {
  String id;
  String name;
  String email;
  int phone;
  String password;
  int v;

  UserModel(
      {this.name, this.id, this.v, this.email, this.password, this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['_id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as int,
        password: json['password'] as String,
        v: json['__v'] as int);
  }
}
